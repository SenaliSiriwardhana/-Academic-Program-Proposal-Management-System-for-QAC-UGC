<?php
session_start();
//echo "<pre>DEBUG: SESSION DATA:\n";
//print_r($_SESSION);
//echo "</pre>";

require 'databaseconnection.php'; // Database connection

// Ensure user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Retrieve logged-in user's details
$username = $_SESSION['username'];
$query = "SELECT first_name, last_name, role, university FROM users WHERE username = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();


if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    $_SESSION['full_name'] = $user['first_name'] . ' ' . $user['last_name'];
    $_SESSION['role'] = str_replace(" of the university", "", $user['role']); // Normalize role
    $_SESSION['university'] = $user['university']; // Ensure university is set
} else {
    die("<pre>Error: User details not found.</pre>");
}

// Define role-based settings
//$role = $_SESSION['role'];
$university = $_SESSION['university'];

$role = trim(strtolower($_SESSION['role'])); // Normalize role

// Normalize the role (trim spaces and convert to lowercase)
$normalizedRole = strtolower(trim($_SESSION['role']));

// Remove "of the university" to prevent mismatches
$normalizedRole = str_ireplace("of the university", "", $normalizedRole);

//  If the role contains "dean", set as "dean"
if (stripos($normalizedRole, "dean") !== false) {
    $normalizedRole = "dean";
}



if (strpos($normalizedRole, "dean") !== false) {
    $dashboardTitle = "Dean Dashboard";
    $statusFilter = "submitted"; // Dean sees submitted proposals
    $approvedPage = "approved_proposals.php";
    $rejectedPage = "rejected_proposals.php";

}elseif (strpos($role, "vice chancellor") !== false || strpos($role, "vc") !== false) {
    $dashboardTitle = "VC Dashboard";
    $statusFilter = "approvedbycqa"; // VC sees proposals approved by Dean
    $approvedPage = "approved_proposals.php";
    $rejectedPage = "rejected_proposals.php";

} elseif (stripos($role, "cqa director") !== false) {  //  Case-insensitive & Flexible
    error_log("DEBUG: Entered CQA Director Condition");
    $dashboardTitle = "CQA Director Dashboard";
    $statusFilter = "approvedbydean"; // CQA sees proposals approved by VC
    $approvedPage = "approved_proposals.php";
    $rejectedPage = "rejected_proposals.php";
  
      
} else {
    die("<pre>Error: Unauthorized access. Role detected: " . htmlspecialchars($role) . "</pre>");
}


// Fetch university_id using university name
$query = "SELECT university_id FROM universities WHERE university_name = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $university);
$stmt->execute();
$result = $stmt->get_result();
$university_data = $result->fetch_assoc();
$stmt->close();

if (!$university_data) {
    die("<pre>Error: University ID not found.</pre>");
}

$university_id = $university_data['university_id'];
$_SESSION['university_id'] = $university_id;



// Fetch pending proposals that match the required status
$pendingProposals = [];
$stmt = $connection->prepare("
    SELECT p.proposal_id, p.proposal_code, p.submitted_at, u.first_name, u.last_name, u.email, gi.degree_name_english
    FROM proposals p
    JOIN users u ON p.created_by = u.id
    LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id
    WHERE p.status = ? 
    AND u.university_id = ? 
    ORDER BY p.submitted_at ASC
"

);

$stmt->bind_param("si", $statusFilter, $university_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $pendingProposals[] = $row;
}
$stmt->close();


//echo "<pre>Debug SQL: ";
//print_r([
  //  'status' => $statusFilter,
   // 'university_id' => $university_id,
   // 'count' => $result->num_rows
//]);
//echo "</pre>";

// Get Degree Name English

$getdegreename = [];
$stmt = $connection->prepare("SELECT degree_name_english from proposal_general_info where proposal_id = ?");
$stmt->bind_param("i", $proposal_id);
$stmt->execute();
$result = $stmt->get_result();


//  Store results in an array **before** debugging or using them
while ($row = $result->fetch_assoc()) {
    $pendingProposals[] = $row;

}

//Debugging: Fetch and display results
//echo "<pre>DEBUG: Pending Proposals Result:\n";
//while ($row = $result->fetch_assoc()) {
     //print_r($row); // Print each row for debugging
    //$pendingProposals[] = $row; // Store in array for later use
//}
//echo "</pre>";
$stmt->close();

// Retrieve submitted proposals
$submittedProposals = [];
$stmt = $connection->prepare("SELECT p.proposal_id,p.proposal_code, p.status, gi.degree_name_english FROM proposals p JOIN proposal_general_info gi ON p.proposal_id = gi.proposal_id WHERE p.university_id = ? AND p.status NOT IN ('draft', 'fresh','submitted') ORDER BY p.proposal_id ASC");
$stmt->bind_param("i", $university_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $submittedProposals[] = $row;
}
$stmt->close();

// =================================================================
// NEW CODE BLOCK START: Fetch history for the "Submitted Proposals" table
// =================================================================
$history_by_proposal = [];
if (!empty($submittedProposals)) {
    $proposal_ids = array_column($submittedProposals, 'proposal_id');
    $placeholders = implode(',', array_fill(0, count($proposal_ids), '?'));
    $types = str_repeat('i', count($proposal_ids));

    $history_query = "
        SELECT proposal_id, proposal_status, `Date`, comment
        FROM proposal_comments
        WHERE proposal_id IN ($placeholders)
        ORDER BY proposal_id, `Date` ASC
    ";

    $stmt_history = $connection->prepare($history_query);
    $stmt_history->bind_param($types, ...$proposal_ids);
    $stmt_history->execute();
    $history_result = $stmt_history->get_result();

    while ($history_row = $history_result->fetch_assoc()) {
        $history_by_proposal[$history_row['proposal_id']][] = $history_row;
    }
    $stmt_history->close();
}
// =================================================================
// NEW CODE BLOCK END
// =================================================================

?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $dashboardTitle; ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            overflow-x: hidden;
        }
        .sidebar {
            height: 100vh;
            position: fixed;
            background-color: #2c3e50;
            color: white;
            width: 250px;
            transition: all 0.3s;
            z-index: 1000;
        }
        .sidebar.collapsed {
            width: 70px;
        }
        .sidebar .user-info {
            text-align: center;
            margin: 20px 0;
        }
        .sidebar .user-info h6 {
            margin: 0;
            font-size: 16px;
            font-weight: bold;
        }
        .sidebar .user-info p {
            margin: 0;
            font-size: 14px;
            color: #bdc3c7;
        }
        .sidebar .nav-item {
            padding: 10px 20px;
        }
        .sidebar .nav-link {
            color: white;
            font-size: 16px;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover {
            background-color: #34495e;
            border-radius: 4px;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
            font-size: 18px;
        }
        .sidebar .toggle-btn {
            position: absolute;
            top: 15px;
            right: -20px;
            background-color: #2c3e50;
            border: none;
            color: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            font-size: 20px;
            cursor: pointer;
        }
        .main-content {
            margin-left: 250px;
            transition: all 0.3s;
            padding: 20px;
        }
        .main-content.collapsed {
            margin-left: 70px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            font-weight: bold;
            border-radius: 10px 10px 0 0;
        }
        footer {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            color: #7f8c8d;
        }

        /* -- NEW CSS FOR WORKFLOW MODAL -- */
        .workflow-step { 
            display: flex; 
            align-items: start; 
            margin-bottom: 15px; 
            padding-bottom: 15px; 
            border-bottom: 1px solid #e9ecef; 
        }
        .workflow-step:last-child { 
            border-bottom: none; 
            margin-bottom: 0; 
            padding-bottom: 0; 
        }
        .workflow-icon { 
            font-size: 24px; 
            margin-right: 15px; 
            flex-shrink: 0; 
            padding-top: 3px; 
        }
        .workflow-icon .fa-check-circle { 
            color: #28a745; 
        }
        .workflow-icon .fa-times-circle { 
            color: #dc3545; 
        }
        .workflow-icon .fa-info-circle { 
            color: #0dcaf0; 
        }
        .workflow-details .status { 
            font-weight: bold; 
        }
        .workflow-details .date { 
            font-size: 0.85em; 
            color: #6c757d; 
        }
        .workflow-details .comment { 
            font-size: 0.9em; 
            color: #495057; 
            margin-top: 5px; 
            white-space: pre-wrap; 
            word-break: break-word; 
        }
        .badge { 
            text-transform: capitalize; 
        }

    </style>
</head>
<body>

<!-- Sidebar -->
<div id="sidebar" class="sidebar">
    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
    <div class="user-info">
        <h6><?php echo htmlspecialchars($_SESSION['full_name']); ?></h6>
        <p><?php echo htmlspecialchars($_SESSION['role']); ?></p>
        <p><?php echo htmlspecialchars($_SESSION['university']); ?></p>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item"><a class="nav-link" href="uni_dashboards.php"><i class="fas fa-home"></i> Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="approved_proposals.php"><i class="fas fa-check-circle"></i> Approved Proposals</a></li>
        <li class="nav-item"><a class="nav-link" href="rejected_proposals.php"><i class="fas fa-times-circle"></i> Rejected Proposals</a></li>
        <?php if (strpos($normalizedRole, "vice chancellor") !== false || strpos($normalizedRole, "vc") !== false): ?>
        <li class="nav-item">
            <a class="nav-link" href="management_reports_vc.php">
                <i class="fas fa-chart-line"></i> Management Reports
            </a>
        </li>
    <?php endif; ?>
        <li class="nav-item"><a class="nav-link" href="login.php"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</div>

<!-- Main Content -->
<div id="main-content" class="main-content">
    <h3><?php echo $dashboardTitle; ?></h3>

    <div class="card">
        <div class="card-header bg-warning">Pending Proposals</div>
        <div class="card-body">
            <table class="table">
                <tr>
                    
                    <th>Proposal Code</th>
                    <th>Degree Name</th>
                    <th>Submitted Date</th>
                    <th>Submitted By</th>
                    <th>Action</th>
                </tr>
                <?php foreach ($pendingProposals as $proposal) { ?>
                    <tr>
                        
                        <td><?php echo $proposal['proposal_code']; ?></td>
                        <td><?php echo $proposal['degree_name_english']; ?></td>
                        <td><?php echo $proposal['submitted_at']; ?></td>
                        <td><?php echo $proposal['first_name'] . " " . $proposal['last_name']; ?></td>
                        <td><a href="review_proposal.php?id=<?php echo $proposal['proposal_id']; ?>" class="btn btn-primary">Review</a></td>
                    </tr>
                <?php } ?>
            </table>
        </div>
    </div>

     <!-- Spacer -->
     <div class="mb-4"></div> <!-- Adds spacing between tables -->

   <!-- Submitted Proposals Status Table -- MODIFIED SECTION -->
    <div class="card">
        <div class="card-header bg-warning">Submitted Proposals Status </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Proposal Code</th>
                            <th>Degree Name</th>
                            <th>Current Status</th>
                            <th>Status Workflow</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($submittedProposals)): ?>
                            <tr><td colspan="4" class="text-center">No other processed proposals to display.</td></tr>
                        <?php else: foreach ($submittedProposals as $proposal): ?>
                            <?php
                                // Determine badge color based on status
                                $status_lower = strtolower($proposal['status']);
                                $badge_class = 'bg-info'; // Default
                                if (strpos($status_lower, 'approved') !== false) $badge_class = 'bg-success';
                                if (strpos($status_lower, 'rejected') !== false) $badge_class = 'bg-danger';
                            ?>
                            <tr>
                                <td><?php echo htmlspecialchars($proposal['proposal_code']); ?></td>
                                <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                                <td>
                                    <span class="badge <?php echo $badge_class; ?>">
                                        <?php echo str_replace("_", " ", htmlspecialchars($proposal['status'])); ?>
                                    </span>
                                </td>
                                <td>
                                    <!-- The button to trigger the modal -->
                                    <button type="button" class="btn btn-outline-secondary btn-sm" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#statusModal"
                                            data-proposal-code="<?php echo htmlspecialchars($proposal['proposal_code']); ?>"
                                            data-history='<?php echo htmlspecialchars(json_encode($history_by_proposal[$proposal['proposal_id']] ?? [])); ?>'>
                                        <i class="fas fa-sitemap"></i> View
                                    </button>
                                </td>
                                <td>
                                    <!-- NEW "View Proposal" BUTTON -->
                                    <a href="view_proposal.php?id=<?php echo $proposal['proposal_id']; ?>" class="btn btn-primary btn-sm">
                                        <i class="fas fa-eye"></i> View Proposal
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<footer>Copyright © 2024 University Grants Commission. Developed by UGC.</footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('collapsed');
        }
    </script>

    <!-- ================================================================= -->
<!-- NEW CODE BLOCK START: Status History Modal -->
<!-- ================================================================= -->
<div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="statusModalLabel">Approval Workflow</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modal-body-content">
                <!-- Workflow steps will be injected here by JavaScript -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- ================================================================= -->
<!-- NEW CODE BLOCK END -->
<!-- ================================================================= -->

<script>
     // =================================================================
    // NEW CODE BLOCK START: JavaScript for Modal
    // =================================================================
    const statusModal = document.getElementById('statusModal');
    statusModal.addEventListener('show.bs.modal', event => {
        const button = event.relatedTarget;
        const proposalCode = button.getAttribute('data-proposal-code');
        const history = JSON.parse(button.getAttribute('data-history'));

        const modalTitle = statusModal.querySelector('.modal-title');
        modalTitle.textContent = `Workflow for: ${proposalCode}`;

        const modalBody = statusModal.querySelector('#modal-body-content');
        modalBody.innerHTML = ''; 

        if (history.length === 0) {
            modalBody.innerHTML = '<p class="text-center">No workflow history available for this proposal yet.</p>';
            return;
        }

        history.forEach(step => {
            const statusStr = (step.proposal_status || '').toLowerCase();
            const isApproved = statusStr.includes('approved') || statusStr.includes('recommended');
            const isRejected = statusStr.includes('rejected') || statusStr.includes('revision');
            
            let iconHtml = '<i class="fas fa-info-circle text-info"></i>'; // Default
            if (isApproved) {
                iconHtml = '<i class="fas fa-check-circle text-success"></i>';
            } else if (isRejected) {
                iconHtml = '<i class="fas fa-times-circle text-danger"></i>';
            }

            let statusText = (step.proposal_status || '')
                .replace(/by/g, ' by ').replace(/_/g, ' ')
                .replace(/([A-Z])/g, ' $1').replace(/^ / , '')
                .split(' ').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
            
            let commentHtml = '';
            if (step.comment && step.comment.trim() !== '') {
                const escapedComment = document.createElement('div');
                escapedComment.innerText = step.comment;
                commentHtml = `<div class="comment fst-italic bg-light p-2 rounded mt-2"><strong>Comment:</strong> ${escapedComment.innerHTML}</div>`;
            }

            const stepHtml = `
                <div class="workflow-step">
                    <div class="workflow-icon">${iconHtml}</div>
                    <div class="workflow-details">
                        <div class="status">${statusText}</div>
                        <div class="date">On: ${new Date(step.Date).toLocaleString()}</div>
                        ${commentHtml}
                    </div>
                </div>
            `;
            modalBody.insertAdjacentHTML('beforeend', stepHtml);
        });
    });
    // =================================================================
    // NEW CODE BLOCK END
    // =================================================================
</script>


</body>
</html>