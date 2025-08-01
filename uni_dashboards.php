<?php
session_start();
// echo "<pre>DEBUG: SESSION DATA:\n";
// print_r($_SESSION);
// echo "</pre>";



require 'databaseconnection.php'; // Database connection

// Ensure user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Retrieve logged-in user's details
$username = $_SESSION['username'];
$query = "SELECT first_name, last_name, role, faculty_of, university FROM users WHERE username = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();


if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    $_SESSION['full_name'] = $user['first_name'] . ' ' . $user['last_name'];
    $_SESSION['role'] = str_replace(" of the university", "", $user['role']); // Normalize role
    $_SESSION['faculty_of'] = $user['faculty_of'];
    $_SESSION['university'] = $user['university']; // Ensure university is set
} else {
    die("<pre>Error: User details not found.</pre>");
}

// Define role-based settings
//$role = $_SESSION['role'];
$university = $_SESSION['university'];

$user_faculty = $_SESSION['faculty_of'] ?? null;
//echo "DEBUG: Faculty from session = $user_faculty";


$role = trim(strtolower($_SESSION['role'])); // Normalize role

// Normalize the role (trim spaces and convert to lowercase)
$normalizedRole = strtolower(trim($_SESSION['role']));

// Remove "of the university" to prevent mismatches
$normalizedRole = str_ireplace("of the university", "", $normalizedRole);

//  If the role contains "dean", set as "dean"
if (stripos($normalizedRole, "dean") !== false) {
    $normalizedRole = "dean";
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
$base_query="
    SELECT p.proposal_id, p.proposal_code,p.proposal_type, p.status, p.university_visible_status, p.proposal_type, p.submitted_at, u.first_name, u.last_name, u.faculty_of, u.email, gi.degree_name_english
    FROM proposals p
    JOIN users u ON p.created_by = u.id
    LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id
"
;
$where_clause = "";
$params = [];
$types = "";




if (strpos($normalizedRole, "dean") !== false) {
    $dashboardTitle = "Dean Dashboard";
   

    if (!empty($user_faculty)) {
        $where_clause = "
            WHERE u.university_id = ? 
              AND u.faculty_of = ?
              AND p.status IN ('submitted', 'approvedbyqachead_revised', 'resignature_request_from_university')
        ";
        $params = [$university_id, $user_faculty];
        $types = "is"; // i = university_id, s = faculty string
    } else {
        // If dean has no faculty set, they see nothing
        $where_clause = "WHERE 1 = 0";
        $params = [];
        $types = "";
    }

    $approvedPage = "approved_proposals.php";
    $rejectedPage = "rejected_proposals.php";


// echo "<pre>DEBUG WHERE CLAUSE:\n$where_clause\n";
// print_r($params);
// echo "</pre>";

}elseif (strpos($role, "vice chancellor") !== false || strpos($role, "vc") !== false) {
    $dashboardTitle = "VC Dashboard";
    // VC sees initial proposals approved by CQA, AND proposals needing re-signature approved by CQA.
    $where_clause = "WHERE u.university_id = ? AND (p.status = 'approvedbycqa' AND p.proposal_type LIKE 'initial_proposal') OR (p.status = 're-signed_cqa') ";
    $params = [$university_id];
    $types = "i";
    $approvedPage = "approved_proposals.php";
    $rejectedPage = "rejected_proposals.php";

} elseif (stripos($role, "cqa director") !== false) {  //  Case-insensitive & Flexible
    error_log("DEBUG: Entered CQA Director Condition");
    $dashboardTitle = "CQA Director Dashboard";
   // CQA sees ALL proposals approved by the Dean.
    $where_clause = "WHERE u.university_id = ? AND p.status IN ('approvedbydean','re-signed_dean')";
    $params = [$university_id];
    $types = "i";
    $approvedPage = "approved_proposals.php";
    $rejectedPage = "rejected_proposals.php";
  
      
} else {
    die("<pre>Error: Unauthorized access. Role detected: " . htmlspecialchars($role) . "</pre>");
}

if (!empty($where_clause)) {
    $stmt = $connection->prepare("$base_query $where_clause ORDER BY p.submitted_at ASC");
    if (!empty($types)) {
        $stmt->bind_param($types, ...$params);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $pendingProposals[] = $row;
    }
    $stmt->close();
}

// $stmt->bind_param("si", $statusFilter, $university_id);
// $stmt->execute();
// $result = $stmt->get_result();
// while ($row = $result->fetch_assoc()) {
//     $pendingProposals[] = $row;
// }
// $stmt->close();


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
// $stmt->close();

// Retrieve submitted proposals
$submittedProposals = [];
if (strpos(strtolower($role), 'dean') !== false && !empty($user_faculty)) {
    // Dean-specific query filtered by faculty
    $stmt = $connection->prepare("
        SELECT p.proposal_id, p.proposal_code,p.proposal_type, p.university_visible_status, p.status, gi.degree_name_english
        FROM proposals p
        JOIN proposal_general_info gi ON p.proposal_id = gi.proposal_id
        JOIN users u ON p.created_by = u.id
        WHERE p.university_id = ? 
          AND u.faculty_of = ?
          AND p.status NOT IN ('draft', 'fresh')
        ORDER BY p.proposal_id ASC
    ");
    $stmt->bind_param("is", $university_id, $user_faculty);
}else{
$stmt = $connection->prepare("SELECT p.proposal_id, p.proposal_type, p.proposal_code, p.university_visible_status, p.status, gi.degree_name_english FROM proposals p JOIN proposal_general_info gi ON p.proposal_id = gi.proposal_id WHERE p.university_id = ? AND p.status NOT IN ('draft', 'fresh') ORDER BY p.proposal_id ASC");
$stmt->bind_param("i", $university_id);
}
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $submittedProposals[] = $row;
}
$stmt->close();

// // =================================================================
// // NEW CODE BLOCK START: Fetch history for the "Submitted Proposals" table
// // =================================================================
// $history_by_proposal = [];
// if (!empty($submittedProposals)) {
//     $proposal_ids = array_column($submittedProposals, 'proposal_id');
//     $placeholders = implode(',', array_fill(0, count($proposal_ids), '?'));
//     $types = str_repeat('i', count($proposal_ids));

//     $history_query = "
//         SELECT proposal_id, proposal_status, `Date`, comment
//         FROM proposal_comments
//         WHERE proposal_id IN ($placeholders)
//         ORDER BY proposal_id, `Date` ASC
//     ";

//     $stmt_history = $connection->prepare($history_query);
//     $stmt_history->bind_param($types, ...$proposal_ids);
//     $stmt_history->execute();
//     $history_result = $stmt_history->get_result();

//     while ($history_row = $history_result->fetch_assoc()) {
//         $history_by_proposal[$history_row['proposal_id']][] = $history_row;
//     }
//     $stmt_history->close();
// }
// // =================================================================
// // NEW CODE BLOCK END
// // =================================================================

// =================================================================
// NEW CODE BLOCK: Fetch FILTERED history for ALL proposals on the page
// =================================================================
$history_by_proposal = [];

// 1. Combine IDs from all proposal groups (no change here)
$submitted_ids = array_column($submittedProposals, 'proposal_id');
$all_proposal_ids = array_unique(array_merge($submitted_ids));

if (!empty($all_proposal_ids)) {
    // 2. Define the internal department statuses to HIDE from the university view.
    $statuses_to_hide = [
        'approvedbyugcfinance', 'rejectedbyugcfinance',
        'approvedbyugchr',      'rejectedbyugchr',
        'approvedbyugcidd',     'rejectedbyugcidd',
        'approvedbyugcacademic','rejectedbyugcacademic',
        'approvedbyugcadmission','rejectedbyugcadmission',
        'approvedbyalldepartments'
    ];

    // 3. Prepare placeholders for both proposal IDs and the statuses to hide.
    $id_placeholders = implode(',', array_fill(0, count($all_proposal_ids), '?'));
    $status_placeholders = implode(',', array_fill(0, count($statuses_to_hide), '?'));

    // 4. Create the new query with the "NOT IN" clause.
    $history_query = "
        SELECT proposal_id, proposal_status, `Time`, comment
        FROM proposal_comments
        WHERE proposal_id IN ($id_placeholders)
          AND proposal_status NOT IN ($status_placeholders)
        ORDER BY proposal_id, `Time` ASC
    ";

    $stmt_history = $connection->prepare($history_query);
    
    // 5. Combine parameters and bind them to the query.
    $params_to_bind = array_merge($all_proposal_ids, $statuses_to_hide);
    $types = str_repeat('i', count($all_proposal_ids)) . str_repeat('s', count($statuses_to_hide));
    $stmt_history->bind_param($types, ...$params_to_bind);

    // 6. Execute and fetch results (no change here)
    $stmt_history->execute();
    $history_result = $stmt_history->get_result();

    while ($history_row = $history_result->fetch_assoc()) {
        $history_by_proposal[$history_row['proposal_id']][] = $history_row;
    }
    $stmt_history->close();
}

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

              /* -- NEW CSS FOR WORKFLOW MODAL TABLE -- */
        .workflow-table {
            width: 100%;
            border-collapse: collapse;
        }
        .workflow-table th, .workflow-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #dee2e6;
            text-align: left;
            vertical-align: top;
        }
        .workflow-table th {
            background-color: #f8f9fa;
            font-weight: 500;
        }
        .workflow-table .status-icon {
            font-size: 1.2rem;
            width: 30px;
        }
        .workflow-table .status-text {
            font-weight: bold;
        }
        .workflow-table .comment-text {
            font-style: italic;
            color: #555;
            white-space: pre-wrap;
            word-break: break-word;
        }
        /* END NEW CSS */

        footer {
            margin-top: 20px;
            /* ... rest of footer css ... */
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
        <li class="nav-item">
            <a class="nav-link" href="edit_profile.php">
                <i class="fas fa-user-edit"></i> Edit Profile
            </a>
        </li>
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
		            <th>Proposal Type</th>
                    <th>Degree Name</th>
                    <th>Submitted Date</th>
                    <th>Submitted By</th>
                    <th>Action</th>
                </tr>
                <?php foreach ($pendingProposals as $proposal) { ?>
                    <tr>
                        
                        <td><?php echo $proposal['proposal_code']; ?></td>
			            <td><?php echo $proposal['proposal_type']; ?></td>
                        <td><?php echo $proposal['degree_name_english']; ?></td>
                        <td><?php echo $proposal['submitted_at']; ?></td>
                        <td><?php echo $proposal['first_name'] . " " . $proposal['last_name']; ?></td>
                        <!-- <td><a href="review_proposal.php?id=<?php echo $proposal['proposal_id']; ?>" class="btn btn-primary">Review</a></td> -->
                         <td>
                            <?php
                            // These are the statuses where the button should say "Re-Sign"
                            $resign_statuses = ['resignature_request_from_university', 're-signed_dean', 're-signed_cqa'];
                            
                            // Get the current status for this specific proposal
                            $current_proposal_status = $proposal['university_visible_status'] ?? '';

                            // Set default button text and color
                            $button_text = 'Review';
                            $button_class = 'btn-primary';

                            // If the status is in our list, change the text and color
                            if (in_array($current_proposal_status, $resign_statuses)) {
                                $button_text = 'Sign Final Version';
                                $button_class = 'btn-warning'; // Yellow/Orange stands out
                            }
                            ?>
                            <a href="review_proposal.php?id=<?php echo $proposal['proposal_id']; ?>" class="btn <?php echo $button_class; ?>">
                                <?php echo $button_text; ?>
                            </a>
                        </td>              
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
                            <th>Proposal Type</th>
                            <th>Degree Name</th>
                            <th>Current Status</th>
                            <th>Status Workflow</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($submittedProposals)): ?>
                            <tr><td colspan="4" class="text-center">No processed proposals to display.</td></tr>
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
                                <td><?php echo htmlspecialchars($proposal['proposal_type']); ?></td>
                                <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                                <td>
                                    <span class="badge <?php echo $badge_class; ?>">
                                        <?php echo str_replace("_", " ", htmlspecialchars($proposal['university_visible_status'])); ?>
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

        // --- START: BUILD THE TABLE ---
            let tableHtml = `
                <div class="table-responsive">
                    <table class="workflow-table">
                        <thead>
                            <tr>
                                <th style="width: 5%;"></th>
                                <th style="width: 25%;">Status</th>
                                <th style="width: 25%;">Date</th>
                                <th>Comment</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            history.forEach(step => {
                const statusStr = (step.proposal_status || '').toLowerCase();
                const isApproved = statusStr.includes('approved') || statusStr.includes('recommended');
                const isRejected = statusStr.includes('rejected') || statusStr.includes('revision');
                
                let iconHtml = '<i class="fas fa-info-circle text-info"></i>'; // Default
                if (isApproved) iconHtml = '<i class="fas fa-check-circle text-success"></i>';
                else if (isRejected) iconHtml = '<i class="fas fa-times-circle text-danger"></i>';

                let statusText = (step.proposal_status || '')
                    .replace(/by/g, ' by ')
                    .replace(/_/g, ' ')
                    .replace(/\b\w/g, l => l.toUpperCase()); // Capitalize each word

                // Securely handle comments
                let commentText = (step.comment && step.comment.trim() !== '') ? step.comment : 'No comment provided.';
                const tempDiv = document.createElement('div');
                tempDiv.innerText = commentText; // Use .innerText to escape any potential HTML
                const escapedComment = tempDiv.innerHTML;

                const stepDate = new Date(step.Time).toLocaleString('en-GB', {
                    year: 'numeric', month: 'short', day: 'numeric',
                    hour: '2-digit', minute: '2-digit', hour12: true
                });

                tableHtml += `
                    <tr>
                        <td class="status-icon">${iconHtml}</td>
                        <td class="status-text">${statusText}</td>
                        <td>${stepDate}</td>
                        <td class="comment-text">${escapedComment}</td>
                    </tr>
                `;
            });

            tableHtml += `
                        </tbody>
                    </table>
                </div>
            `;
            // --- END: BUILD THE TABLE ---

            modalBody.innerHTML = tableHtml;
        });
    
</script>




</body>
</html>