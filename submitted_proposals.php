<?php
session_start();
include 'databaseconnection.php';

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Retrieve user details
$username = $_SESSION['username'];
$query = "SELECT first_name, last_name, role, university, university_id, id FROM users WHERE username = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    $full_name = $user['first_name'] . ' ' . $user['last_name'];
    $Role = str_replace(" of the university", "", $user['role']);
    $university = $user['university'];
    $university_id = $user['university_id']; // Store university_id
    $user_id = $user['id']; // store user_id to apply created_by

    $_SESSION['university'] = $university;
} else {
    $full_name = "Unknown User";
    $Role = "Unknown Role";
    $university = "Unknown University";

    $_SESSION['university'] = $university;
}


// Define the upload directory
$uploadDir = __DIR__ . '/../uploads/';  // Adjust path if necessary
$uploadUrl = '/qac_ugc/Proposal_sections/uploads/';

// Function to delete uploaded files from session data
function deleteUploadedFiles($section) {
    global $uploadDir, $uploadUrl;

    if (!empty($_SESSION[$section])) {
        foreach ($_SESSION[$section] as $key => $fileUrl) {
            if (is_string($fileUrl) && strpos($fileUrl, $uploadUrl) === 0) { // Ensure it's a file path
                $filePath = str_replace($uploadUrl, $uploadDir, $fileUrl); // Convert URL to file path
                if (file_exists($filePath)) {
                    unlink($filePath); // Delete the file
                }
            }
        }
    }
}


// Retrieve list of draft proposals
$drafts = [];
$stmt = $connection->prepare("SELECT proposal_id, proposal_code, status FROM proposals WHERE status = 'submitted' AND university_id = ? ORDER BY proposal_id ASC");
$stmt->bind_param("i", $university_id); // Bind parameters 
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $drafts[] = $row;
}


// Retrieve submitted proposals
$submittedProposals = [];
$stmt = $connection->prepare("SELECT p.proposal_id, p.proposal_code, p.status, gi.degree_name_english FROM proposals p join proposal_general_info gi ON p.proposal_id = gi.proposal_id  WHERE university_id = ? AND status NOT IN ('draft', 'fresh') ORDER BY proposal_id ASC");
$stmt->bind_param("i", $university_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $submittedProposals[] = $row;
}
$stmt->close();



// Retrieve revised/rejected proposals
$revisedProposals = [];
$stmt = $connection->prepare("
    SELECT p.proposal_id, 
           p.proposal_code,
           p.status, 
           gi.degree_name_english,
           c.comment, 
           c.comment_id, 
           c.seal_and_sign, 
           c.proposal_status, 
           c.Date
    FROM proposals p
    LEFT JOIN proposal_comments c 
        ON p.proposal_id = c.proposal_id 
        AND c.comment_id = ( 
            SELECT MAX(comment_id) 
            FROM proposal_comments 
            WHERE proposal_id = p.proposal_id
        ) --  Select only the latest comment
    LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id
    WHERE p.university_id = ? 
      AND p.status LIKE 'rejectedby%' 
    ORDER BY p.proposal_id ASC
");

$stmt->bind_param("i", $university_id);
$stmt->execute();
$result = $stmt->get_result();

$revisedProposals = [];
while ($row = $result->fetch_assoc()) {
    $revisedProposals[] = $row;
}
$stmt->close();


// Retrieve final approved proposals
$finalapprovedProposals = [];
//$stmt = $connection->prepare("SELECT proposal_id, status FROM proposals WHERE university_id = ? AND status IN ('approvedbyugcacademic') ORDER BY proposal_id ASC");
$stmt = $connection->prepare("
    SELECT p.proposal_id,p.proposal_code, p.status, gi.degree_name_english,
        COALESCE(pc.comment, 'No Comment') AS latest_comment,
        COALESCE(pc.proposal_status, 'No Status') AS latest_status
    FROM proposals p
    LEFT JOIN proposal_comments pc 
        ON p.proposal_id = pc.proposal_id 
        AND pc.comment_id = (
            SELECT MAX(comment_id) FROM proposal_comments 
            WHERE proposal_id = p.proposal_id
        )
    LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id
    WHERE p.university_id = ? 
    AND p.status = 'approvedbyugcacademic'
    ORDER BY p.proposal_id ASC
");
$stmt->bind_param("i", $university_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $finalapprovedProposals[] = $row;
}
$stmt->close();


// =================================================================
// MODIFIED CODE BLOCK: Fetch history for ALL proposals on the page
// =================================================================
$history_by_proposal = [];

// 1. Combine IDs from all three proposal groups
$submitted_ids = array_column($submittedProposals, 'proposal_id');
$revised_ids = array_column($revisedProposals, 'proposal_id');
$approved_ids = array_column($finalapprovedProposals, 'proposal_id');
$all_proposal_ids = array_unique(array_merge($submitted_ids, $revised_ids, $approved_ids));

if (!empty($all_proposal_ids)) {
    // 2. Prepare a single query for all unique IDs
    $placeholders = implode(',', array_fill(0, count($all_proposal_ids), '?'));
    $types = str_repeat('i', count($all_proposal_ids));

    $history_query = "
        SELECT proposal_id, proposal_status, `Date`, comment
        FROM proposal_comments
        WHERE proposal_id IN ($placeholders)
        ORDER BY proposal_id, `Date` ASC
    ";

    $stmt_history = $connection->prepare($history_query);
    // 3. Bind all IDs and execute
    $stmt_history->bind_param($types, ...$all_proposal_ids);
    $stmt_history->execute();
    $history_result = $stmt_history->get_result();

    // 4. Organize results into the history array, same as before
    while ($history_row = $history_result->fetch_assoc()) {
        $history_by_proposal[$history_row['proposal_id']][] = $history_row;
    }
    $stmt_history->close();
}
// =================================================================
// END OF MODIFIED BLOCK
// =================================================================


// Fetch university data
//$query = "SELECT  
                 //(SELECT COUNT(*) FROM proposals WHERE university_id = ? AND status NOT IN ('draft', 'fresh') ORDER BY proposal_id ASC) AS total_submissions,
                 //(SELECT COUNT(*) FROM proposals WHERE university_id = ? AND status LIKE 'rejectedby%') AS rejected_proposals
          //FROM proposals order by total_submissions";


$query = "SELECT u.university_id, u.university_name, 
                
                 (SELECT COUNT(*) FROM proposals WHERE proposals.university_id = u.university_id) AS total_submissions,
                 (SELECT COUNT(*) FROM proposals WHERE proposals.university_id = u.university_id AND status LIKE 'rejectedby%') AS rejected_proposals
          FROM universities u
          WHERE u.university_name LIKE '%University of Colombo%'
          ORDER BY total_submissions DESC";

$stmt = $connection->prepare($query);
$stmt->execute();
$result = $stmt->get_result();


$reportData = [];
$max_submissions = 0;
while ($row = $result->fetch_assoc()) {
    $reportData[] = $row;
  
  $rejectionRate = ($row['rejected_proposals'] / $row['total_submissions']) * 100;
}
$stmt->close();

// Calculate participation rate
foreach ($reportData as &$row) {
    $row['rate'] = $rejectionRate;
}
unset($row);





?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Proposal - Proposal Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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

        /* Dropdown menu */
        .dropdown-menu 
        {
            list-style: none;
            padding-left: 20px;
            display: none;
            flex-direction: column;
            background: #2c3e50;    /* Light background, change as needed */
            border: 1px solid #ccc; /* Border to distinguish */
            width: 150px;
            position: absolute;      /* Position relative to dropdown container */
            z-index: 1000;
        }

        .dropdown-menu li 
        {
            margin-top: 5px;
            display:flex;
        }

        .nav-link.dropdown-toggle 
        {
            cursor: pointer;
        }

        .sub-link 
        {
            font-size: 14px;
            padding-left: 25px;
            color:rgba(36, 35, 35, 0.88);
            transition: 0.3s;
        }

        .sub-link:hover 
        {
            color: black;
            background-color: #34495e;
            border-radius: 4px;
        }

         footer {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            color: #7f8c8d;
        }
	
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

    </style>
</head>
<body>

    <!-- Sidebar -->
    <div id="sidebar" class="sidebar">
        <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
        <div class="user-info">
            <h6><?php echo htmlspecialchars($full_name); ?></h6>
            <p><?php echo htmlspecialchars($Role); ?></p>
            <p><?php echo htmlspecialchars($university); ?></p>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="submitted_proposals.php"><i class="fas fa-home"></i> Dashboard</a>
            </li>
           <li class="nav-item">
    <div class="nav-link dropdown-toggle" style="cursor: pointer;" onclick="toggleDropdown(event)">
        <i class="fas fa-file-alt"></i> New Proposals
    </div>
    <ul id="proposalDropdown" class="dropdown-menu">
        <li><a class="nav-link sub-link" href="new_proposal.php?type=undergraduate">Undergraduate Programs</a></li>
        <li><a class="nav-link sub-link" href="new_proposal_postgraduate.php?type=postgraduate">Postgraduate Programs</a></li>
        <li><a class="nav-link sub-link" href="new_proposal_external.php?type=external">External Programs</a></li>
    </ul>
</li>

            <li class="nav-item">
                <hr class="text-light">
                <a class="nav-link" href="reset_password.php"><i class="fas fa-key"></i> Reset Password</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="login.php"><i class="fas fa-sign-out-alt"></i> Log out</a>
            </li>
        </ul>
    </div>

   <!-- Main Content -->
    <div id="main-content" class="main-content">
        <div class="container-fluid">
            <!-- Submitted Proposals Table -- MODIFIED -->
            <div class="card mb-4">
                <div class="card-header text-bg-dark">Submitted Proposals</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
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
                                    <tr><td colspan="4" class="text-center">No submitted proposals found.</td></tr>
                                <?php else: foreach ($submittedProposals as $proposal): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($proposal['proposal_code']); ?></td>
                                        <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                                        <td><span class="badge bg-info"><?php echo str_replace("_", " ", htmlspecialchars($proposal['status'])); ?></span></td>
                                        <td>
                                            <button type="button" class="btn btn-info btn-sm" 
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

            <!-- Revised/Rejected Proposals Table -- MODIFIED -->
            <div class="card mb-4">
                <div class="card-header text-bg-dark">Revised / Rejected Proposals</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
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
                                <?php if (empty($revisedProposals)): ?>
                                    <tr><td colspan="5" class="text-center">No revised or rejected proposals found.</td></tr>
                                <?php else: foreach ($revisedProposals as $proposal): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($proposal['proposal_code']); ?></td>
                                        <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                                        <td><span class="badge bg-danger"><?php echo str_replace("_", " ", htmlspecialchars($proposal['status'])); ?></span></td>
                                        <td>
                                            <button type="button" class="btn btn-warning btn-sm" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#statusModal"
                                                    data-proposal-code="<?php echo htmlspecialchars($proposal['proposal_code']); ?>"
                                                    data-history='<?php echo htmlspecialchars(json_encode($history_by_proposal[$proposal['proposal_id']] ?? [])); ?>'>
                                                <i class="fas fa-sitemap"></i> View
                                            </button>
                                        </td>
                                        <td>
                                            <a href="new_proposal_section.php?proposal_id=<?php echo $proposal['proposal_id']; ?>&edit=true&initial" class="btn btn-primary btn-sm">Edit</a>
                                        </td>
                                    </tr>
                                <?php endforeach; endif; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Final Approved Proposals Table (already modified) -->
            <div class="card">
                <div class="card-header text-bg-dark">Final Approved Proposals</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Proposal Code</th>
                                    <th>Degree Name</th>
                                    <th>Status Workflow</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($finalapprovedProposals)): ?>
                                    <tr><td colspan="4" class="text-center">No final approved proposals found.</td></tr>
                                <?php else: foreach ($finalapprovedProposals as $proposal): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($proposal['proposal_code']); ?></td>
                                        <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                                        <td>
                                            <button type="button" class="btn btn-success btn-sm" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#statusModal"
                                                    data-proposal-code="<?php echo htmlspecialchars($proposal['proposal_code']); ?>"
                                                    data-history='<?php echo htmlspecialchars(json_encode($history_by_proposal[$proposal['proposal_id']] ?? [])); ?>'>
                                                <i class="fas fa-sitemap"></i> View
                                            </button>
                                        </td>
                                        <td>
                                            <a href="view_proposal.php?id=<?php echo $proposal['proposal_id']; ?>" class="btn btn-primary btn-sm"><i class="fas fa-eye"></i>View Proposal</a>
                                        </td>
                                    </tr>
                                <?php endforeach; endif; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Status History Modal (No changes needed here) -->
    <div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-scrollable"> <!-- Added modal-dialog-scrollable -->
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


     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>                                
    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
            document.getElementById('main-content').classList.toggle('collapsed');
        }

    
        function toggleDropdown() {
            const menu = document.getElementById('proposalDropdown');
            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
        }
    

    </script>


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

                const stepDate = new Date(step.Date).toLocaleString('en-GB', {
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


    <footer>
        Copyright © 2024 University Grants Commission. Developed by UGC.
    </footer>
</body>
</html>