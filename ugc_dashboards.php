<?php
session_start();
require 'databaseconnection.php'; // Database connection

// Ensure user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Retrieve logged-in user's details
$username = $_SESSION['username'];
$query = "SELECT first_name, last_name, role,university FROM users WHERE username = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    $_SESSION['full_name'] = $user['first_name'] . ' ' . $user['last_name'];
    $_SESSION['role'] = strtolower(trim($user['role'])); // Normalize role
} else {
    die("<pre>Error: User details not found.</pre>");
}

$role = $_SESSION['role'];

// Retrieve submitted proposals
$pendingProposals = [];

$base_query = "SELECT p.proposal_id,p.proposal_code,p.proposal_type,p.status, p.submitted_at, u.first_name, u.last_name, u.university, u.faculty_of, 
gi.degree_name_english FROM proposals p JOIN users u ON p.created_by = u.id LEFT JOIN proposal_general_info gi 
ON p.proposal_id = gi.proposal_id";

// --- Special logic for Technical Assistant ---
if ($role === 'ugc - technical assistant') {
    $dashboardTitle = "UGC - Technical Assistant Dashboard";
    // TA sees: 1) Initial proposals approved by VC. 2) Revised proposals approved by CQA.
    $query = "$base_query WHERE (p.status = 'approvedbyvc') OR (p.status = 'approvedbycqa' AND p.proposal_type LIKE 'revised%') OR (p.status LIKE 'under_review_by_%') ORDER BY p.submitted_at ASC";
    $stmt = $connection->prepare($query);
    
} else {
    

    // Define the list of statuses for the UGC-Departments
    $dept_queue_statuses = ['approvedbyqachead', 'approvedbyqachead_revised', 're-signed_vc'];

    // Role-to-status mapping for individual department approvals
    $dept_approval_status_map = [
        "ugc - finance department" => "approvedbyugcfinance",
        "ugc - hr department" => "approvedbyugchr",
        "ugc - idd department" => "approvedbyugcidd",
        "ugc - academic department" => "approvedbyugcacademic",
        "ugc - admission department" => "approvedbyugcadmission",
    ];

    // --- Standard logic for all other UGC roles ---
    $ugc_settings = [
        "ugc - secretary" => ["title" => "UGC - Secretary Dashboard", "status" => "approvedbyTA"],
        "head of the qac-ugc department" => ["title" => "Director QAC Dashboard", "status" => "approvedbysecretary"],
        "ugc - finance department" => ["title" => "UGC - Finance Department Dashboard", "status" =>  $dept_queue_statuses],
        "ugc - hr department" => ["title" => "UGC - HR Dashboard", "status" =>  $dept_queue_statuses],
        "ugc - idd department" => ["title" => "UGC - IDD Dashboard", "status" =>  $dept_queue_statuses],
        "ugc - academic department" => ["title" => "Academic Affairs Dashboard", "status" =>  $dept_queue_statuses],
        "ugc - admission department" => ["title" => "UGC - Admission Dashboard", "status" =>  $dept_queue_statuses],
        // *** KEY CHANGE HERE: Standing Committee now looks for the new status ***
        "standing committee" => ["title" => "Standing Committee Dashboard", "status" => "approvedbyalldepartments"],
    ];

    if (!array_key_exists($role, $ugc_settings)) {
        die("Unauthorized access for role: " . htmlspecialchars($role));
    }
    $dashboardTitle = $ugc_settings[$role]['title'];
    $statusFilter = $ugc_settings[$role]['status'];

    // if (is_array($statusFilter)) {
    //     // If the filter is an array, build an IN clause
    //     $placeholders = implode(',', array_fill(0, count($statusFilter), '?'));
    //     $query = "$base_query WHERE p.status IN ($placeholders) ORDER BY p.submitted_at ASC";
    //     $stmt = $connection->prepare($query);
    //     // Bind each value in the array
    //     $stmt->bind_param(str_repeat('s', count($statusFilter)), ...$statusFilter);
    // } else {
    //     // If the filter is a single string, use the simple query
    //     $query = "$base_query WHERE p.status = ? ORDER BY p.submitted_at ASC";
    //     $stmt = $connection->prepare($query);
    //     $stmt->bind_param("s", $statusFilter);
    // }

    // --- NEW QUERY LOGIC FOR PARALLEL DEPARTMENTS ---
// if (is_array($statusFilter) && array_key_exists($role, $dept_approval_status_map)) {
//     // This is one of the 5 parallel review departments.
//     // We only show proposals they have NOT yet approved.
//     $my_approval_status = $dept_approval_status_map[$role];
//     $placeholders = implode(',', array_fill(0, count($statusFilter), '?'));
//        $query = "$base_query 
//               WHERE p.status IN ($placeholders) 
//               AND NOT EXISTS (
//                   SELECT 1 FROM proposal_comments pc 
//                   WHERE pc.proposal_id = p.proposal_id AND pc.proposal_status = ?
//               )
//               ORDER BY p.submitted_at ASC";

//     $stmt = $connection->prepare($query);
//     // Bind the status filters and the department's own approval status
//     $params = array_merge($statusFilter, [$my_approval_status]);
//     $stmt->bind_param(str_repeat('s', count($params)), ...$params);

// } elseif (is_array($statusFilter)) {
//     // Standard array filter for roles that see multiple statuses but aren't in parallel review
//     $placeholders = implode(',', array_fill(0, count($statusFilter), '?'));
//     $query = "$base_query WHERE p.status IN ($placeholders) ORDER BY p.submitted_at ASC";
//     $stmt = $connection->prepare($query);
//     $stmt->bind_param(str_repeat('s', count($statusFilter)), ...$statusFilter);
// } else {
//     // Standard single status filter
//     $query = "$base_query WHERE p.status = ? ORDER BY p.submitted_at ASC";
//     $stmt = $connection->prepare($query);
//     $stmt->bind_param("s", $statusFilter);
// }
    
//}

// --- START: NEW, CORRECTED QUERY LOGIC FOR ALL NON-TA ROLES ---

// if (is_array($statusFilter) && array_key_exists($role, $dept_approval_status_map)) {
    
//     // --- THIS IS THE CORRECTED LOGIC FOR THE 5 PARALLEL DEPARTMENTS ---
//     $my_approval_status = $dept_approval_status_map[$role];
//     $pool_statuses = $statusFilter; // Use the statuses from the settings, e.g., ['approvedbyqachead', ...]
//     $placeholders = implode(',', array_fill(0, count($pool_statuses), '?'));

//     // This query shows a proposal UNLESS this department's approval is the latest department-level action.
//     $query = "$base_query 
//               WHERE p.status IN ($placeholders)
//                 AND COALESCE(
//                     (
//                         -- Subquery to find the status of the single most recent department-level comment
//                         SELECT pc_latest.proposal_status
//                         FROM proposal_comments pc_latest
//                         WHERE pc_latest.proposal_id = p.proposal_id
//                           AND pc_latest.proposal_status LIKE 'approvedbyugc%'
//                         ORDER BY pc_latest.Date DESC, pc_latest.comment_id DESC
//                         LIMIT 1
//                     ), 
//                     'none' -- Use 'none' as a default if no department has ever commented
//                 ) != ? -- The proposal is shown if the latest comment is NOT from this department
//               ORDER BY p.submitted_at ASC";

//     $stmt = $connection->prepare($query);
    
//     // Bind the pool statuses, and then the department's own approval status
//     $params = array_merge($pool_statuses, [$my_approval_status]);
//     $types = str_repeat('s', count($pool_statuses)) . 's';
//     $stmt->bind_param($types, ...$params);
//     // --- END OF CORRECTED LOGIC ---

if (is_array($statusFilter) && array_key_exists($role, $dept_approval_status_map)) {
    
    // --- THIS IS THE NEW, CORRECTED LOGIC FOR PARALLEL DEPARTMENTS ---
    $my_approval_status = $dept_approval_status_map[$role];
    $pool_statuses = $statusFilter;
    $placeholders = implode(',', array_fill(0, count($pool_statuses), '?'));
    
    // The "start line" trigger statuses
    $trigger_statuses = ['approvedbyqachead', 'approvedbyqachead_revised', 're-signed_vc'];
    $trigger_placeholders = implode(',', array_fill(0, count($trigger_statuses), '?'));

    // This query uses NOT EXISTS with a subquery that checks the timestamp.
    $query = "$base_query 
              WHERE p.status IN ($placeholders)
                AND NOT EXISTS (
                   
                    SELECT 1 
                    FROM proposal_comments pc
                    WHERE pc.proposal_id = p.proposal_id
                      AND pc.proposal_status = ?
                      AND pc.Time >= (
                          -- This finds the timestamp of the latest trigger
                          SELECT MAX(pc_trigger.Time)
                          FROM proposal_comments pc_trigger
                          WHERE pc_trigger.proposal_id = p.proposal_id
                            AND pc_trigger.proposal_status IN ($trigger_placeholders)
                      )
                )
              ORDER BY p.submitted_at ASC";

    $stmt = $connection->prepare($query);
    
    // We need to bind the pool statuses, my approval status, and the trigger statuses.
    $params = array_merge($pool_statuses, [$my_approval_status], $trigger_statuses);
    $types = str_repeat('s', count($pool_statuses)) . 's' . str_repeat('s', count($trigger_statuses));
    $stmt->bind_param($types, ...$params);
    // --- END OF CORRECTED LOGIC ---

} elseif (is_array($statusFilter)) {
    // This part for other roles (like QAC Head) is correct
    $placeholders = implode(',', array_fill(0, count($statusFilter), '?'));
    $query = "$base_query WHERE p.status IN ($placeholders) ORDER BY p.submitted_at ASC";
    $stmt = $connection->prepare($query);
    $stmt->bind_param(str_repeat('s', count($statusFilter)), ...$statusFilter);

} else {
    // This part for other roles (like Secretary) is correct
    $query = "$base_query WHERE p.status = ? ORDER BY p.submitted_at ASC";
    $stmt = $connection->prepare($query);
    $stmt->bind_param("s", $statusFilter);
}
}
// --- END: NEW, CORRECTED QUERY LOGIC ---



// Execute and fetch results
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $pendingProposals[] = $row;
}
$stmt->close();


// Retrieve submitted proposals
$submittedProposals = [];
$stmt = $connection->prepare("SELECT p.proposal_id,p.proposal_code, p.proposal_type, p.status, u.university,gi.degree_name_english FROM proposals p join users u on p.created_by=u.id LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id WHERE p.status NOT IN ('draft', 'fresh','submitted','approvedbydean','rejectedbydean','approvedbyvc','rejectedbyvc','rejectedbycqa') ORDER BY proposal_id ASC");
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $submittedProposals[] = $row;
}
$stmt->close();


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

// (This replaces the history-fetching block in ugc_dashboards.php)

// =================================================================
// MODIFIED CODE BLOCK: Fetch history for UGC view (hiding uni rejections)
// =================================================================
$history_by_proposal = [];

// 1. Combine IDs from all proposal groups shown on the UGC page
// Important: We need IDs from BOTH pending and submitted tables for a complete view
$pending_ids = array_column($pendingProposals, 'proposal_id');
$submitted_ids = array_column($submittedProposals, 'proposal_id');
$all_proposal_ids = array_unique(array_merge($pending_ids, $submitted_ids));

if (!empty($all_proposal_ids)) {
    // 2. Define the university rejection statuses to HIDE from the UGC view.
    $statuses_to_hide = [
        'rejectedbydean',
        'rejectedbyvc',
        'rejectedbycqa'
    ];
    
    // 3. Prepare placeholders for the query
    $id_placeholders = implode(',', array_fill(0, count($all_proposal_ids), '?'));
    $status_placeholders = implode(',', array_fill(0, count($statuses_to_hide), '?'));

    // 4. The new query with the "NOT IN" clause to filter out the unwanted statuses.
    $history_query = "
        SELECT proposal_id, proposal_status, `Time`, comment
        FROM proposal_comments
        WHERE proposal_id IN ($id_placeholders)
          AND proposal_status NOT IN ($status_placeholders)
        ORDER BY proposal_id, `Time` ASC
    ";

    $stmt_history = $connection->prepare($history_query);
    
    // 5. Combine parameters and bind them to the query
    $params_to_bind = array_merge($all_proposal_ids, $statuses_to_hide);
    $types = str_repeat('i', count($all_proposal_ids)) . str_repeat('s', count($statuses_to_hide));
    $stmt_history->bind_param($types, ...$params_to_bind);

    // 6. Execute and fetch the results
    $stmt_history->execute();
    $history_result = $stmt_history->get_result();

    while ($history_row = $history_result->fetch_assoc()) {
        $history_by_proposal[$history_row['proposal_id']][] = $history_row;
    }
    $stmt_history->close();
}
// =================================================================
// END OF MODIFIED BLOCK
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
           
        }
        .badge { 
            text-transform: capitalize; 
        }

        footer {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            color: #7f8c8d;
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
        <!-- <p><?php echo htmlspecialchars($_SESSION['university']); ?></p> -->
    </div>
    <ul class="nav flex-column">
        <li class="nav-item"><a class="nav-link" href="ugc_dashboards.php"><i class="fas fa-home"></i> Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="approved_proposals_ugc.php"><i class="fas fa-check-circle"></i> Approved Proposals</a></li>
        <li class="nav-item"><a class="nav-link" href="rejected_proposals_ugc.php"><i class="fas fa-times-circle"></i> Rejected Proposals</a></li>
        

        <!-- Management Reports link only for Head of QAC-UGC -->
        <?php if ($_SESSION['role'] === "head of the qac-ugc department"): ?>
        <li class="nav-item">
            <a class="nav-link" href="management_reports_qachead.php">
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

<!-- Search Bar -->
<div class="input-group mb-3">
  <input type="text" id="searchInput" class="form-control" placeholder="Search...">
  <button class="btn"style="background-color:#593F59; color:white;" onclick="runSearch()"><i class="fas fa-search"></i> Search</button>
  <button class="btn btn-outline-secondary" onclick="clearSearch()"><i class="fas fa-times"></i> Clear</button>
</div>

<p>Filter</p>
<!-- Filter Panel -->
<div class="row g-2 mb-2">
  <div class="col-md-3"><input type="text" class="form-control" id="filterCode" placeholder="Proposal Code"></div>
  <div class="col-md-3"><input type="text" class="form-control" id="filterDegree" placeholder="Degree Name"></div>
  <div class="col-md-3"><select class="form-select" id="filterUniversity">
  <option value="">All Universities</option>
  <option>University of Colombo</option>
  <option>University of Moratuwa</option>
  <option>University of Peradeniya</option>
  <option>University of Sri Jayewardenepura</option>
  <option>University of Kelaniya</option>
  <option>University of Jaffna</option>
  <option>University of Ruhuna</option>
  <option>Eastern University of Sri Lanka</option>
  <option>Rajarata University of Sri Lanka</option>
  <option>Sabaragamuwa University of Sri Lanka</option>
  <option>Wayamba University of Sri Lanka</option>
  <option>University of Visual and Performing Arts</option>
  <option>University of Uwa Wellassa</option>
  <option>South Eastern University of Sri Lanka</option>
  <option>Open University</option>
</select>
  
</div>
<div class="mb-3">
  <button class="btn" style="background-color:#F2935C; color:white;" onclick="runFilter()">Apply Filters</button>
  <button class="btn btn-secondary" onclick="clearFilter()">Clear Filters</button>
</div>

    <div class="card">
        <div class="card-header bg-warning">Pending Proposals</div>
        <div class="card-body">
            <table class="table" id="pendingTable">
                <tr>
                    <th>Proposal Code</th>
                    <th>Proposal Type</th>
                    <th>Proposal Status</th>
                    <th>Degree Name </th>
                    <th>Submitted Date</th>
                    <th>Submitted By</th>
                    <th>Faculty</th>
                    <th>University </th>
                    <th>Action</th>
                </tr>
                <?php foreach ($pendingProposals as $pproposal) { ?>
                    <tr>
                        <td><?php echo $pproposal['proposal_code']; ?></td>
                        <td><?php echo $pproposal['proposal_type']; ?></td>
                         <td>
                            <?php
                                // 1. Get the status and determine the badge color
                                $status_lower = strtolower($pproposal['status']);
                                $badge_class = 'bg-primary'; // Default blue for pending items

                                if (strpos($status_lower, 'under_review_by_ATechAssistant') !== false) {
                                    $badge_class = 'bg-warning text-dark'; // Yellow for in-progress
                                }
                                
                                // 2. Format the text for display
                                $display_text = ucwords(str_replace('_', ' ', $status_lower));
                            ?>
                            <span class="badge <?php echo $badge_class; ?>">
                                <?php echo $display_text; ?>
                            </span>
                        </td>
        

                        <td><?php echo $pproposal['degree_name_english']; ?></td>
                        <td><?php echo $pproposal['submitted_at']; ?></td>
                        <td><?php echo $pproposal['first_name'] . " " . $pproposal['last_name']; ?></td>
                        <td><?php echo $pproposal['faculty_of']?> </td>
                        <td><?php echo $pproposal['university']?> </td>
                        <td>
                            <a href="review_proposal_ugc.php?id=<?php echo $pproposal['proposal_id']; ?>" class="btn btn-primary">Review</a>
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
        <div class="card-header bg-warning">Submitted Proposals status</div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover" id="submittedTable">
                    <thead>
                        <tr>
                            <th>Proposal Code</th>
                            <th>Proposal Type</th>
                            <th>Degree Name</th>
                            <th>Current Status</th>
                            <th>Status Workflow</th>
                            <th>University</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($submittedProposals)): ?>
                            <tr><td colspan="5" class="text-center">No other processed proposals to display.</td></tr>
                        <?php else: foreach ($submittedProposals as $proposal): ?>
                            <?php
                                $status_lower = strtolower($proposal['status']);
                                $badge_class = 'bg-info';
                                if (strpos($status_lower, 'approved') !== false) $badge_class = 'bg-success';
                                if (strpos($status_lower, 'rejected') !== false) $badge_class = 'bg-danger';
                            ?>
                            <tr>
                                <td><?php echo htmlspecialchars($proposal['proposal_code']); ?></td>
                                <td><?php echo htmlspecialchars($proposal['proposal_type']); ?></td>
                                <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                                <td><span class="badge <?php echo $badge_class; ?>"><?php echo str_replace("_", " ", htmlspecialchars($proposal['status'])); ?></span></td>
                                <td>
                                    <button type="button" class="btn btn-outline-secondary btn-sm" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#statusModal"
                                            data-proposal-code="<?php echo htmlspecialchars($proposal['proposal_code']); ?>"
                                            data-history='<?php echo htmlspecialchars(json_encode($history_by_proposal[$proposal['proposal_id']] ?? [])); ?>'>
                                        <i class="fas fa-sitemap"></i> View
                                    </button>
                                </td>
                                <td><?php echo htmlspecialchars($proposal['university']); ?></td>
                                <td>
                                    <!-- NEW "View Proposal" BUTTON -->
                                    <a href="view_proposal_ugc.php?id=<?php echo $proposal['proposal_id']; ?>" class="btn btn-primary btn-sm">
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

<!-- Status History Modal -->
<div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="statusModalLabel">Approval Workflow</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modal-body-content"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('collapsed');
        }

    </script>

    <!-- Search and Filter Logic -->
     
    <script>
   // Search and Filter Logic -- MODIFIED runFilter function
    function runSearch() {
        const searchText = document.getElementById('searchInput').value.toLowerCase();
        ['pendingTable', 'submittedTable'].forEach(tableId => {
            const rows = document.querySelectorAll(`#${tableId} tbody tr`);
            rows.forEach(row => {
                row.style.display = row.innerText.toLowerCase().includes(searchText) ? '' : 'none';
            });
        });
    }

       function clearSearch() {
        document.getElementById('searchInput').value = '';
        showAllRows();
    }

   

    function runFilter() {
        const code = document.getElementById('filterCode').value.toLowerCase();
        const degree = document.getElementById('filterDegree').value.toLowerCase();
        const university = document.getElementById('filterUniversity').value.toLowerCase();

        // Filter the Pending Proposals table
        const pendingRows = document.querySelectorAll('#pendingTable tbody tr');
        pendingRows.forEach(row => {
            // Correct column indexes for the 'pendingTable'
            const codeText = row.cells[0] ? row.cells[0].innerText.toLowerCase() : '';
            const degreeText = row.cells[3] ? row.cells[3].innerText.toLowerCase() : ''; // Corrected: was 2
            const universityText = row.cells[7] ? row.cells[7].innerText.toLowerCase() : ''; // Corrected: was 6

            const matchCode = code === '' || codeText.includes(code);
            const matchDegree = degree === '' || degreeText.includes(degree);
            const matchUniversity = university === '' || universityText.includes(university);

            row.style.display = (matchCode && matchDegree && matchUniversity) ? '' : 'none';
        });

        // Filter the Submitted Proposals status table
        const submittedRows = document.querySelectorAll('#submittedTable tbody tr');
        submittedRows.forEach(row => {
            // Column indexes for the 'submittedTable'
            const codeText = row.cells[0] ? row.cells[0].innerText.toLowerCase() : '';
            const degreeText = row.cells[2] ? row.cells[2].innerText.toLowerCase() : '';
            const universityText = row.cells[5] ? row.cells[5].innerText.toLowerCase() : '';

            const matchCode = code === '' || codeText.includes(code);
            const matchDegree = degree === '' || degreeText.includes(degree);
            const matchUniversity = university === '' || universityText.includes(university);

            row.style.display = (matchCode && matchDegree && matchUniversity) ? '' : 'none';
        });
    }

    function clearFilter() {
      document.getElementById('filterCode').value = '';
      document.getElementById('filterDegree').value = '';
      document.getElementById('filterUniversity').value = '';
      showAllRows();
    }

    function showAllRows() {
      ['pendingTable', 'submittedTable'].forEach(tableId => {
        const rows = document.querySelectorAll(`#${tableId} tbody tr`);
        rows.forEach(row => row.style.display = '');
      });
    }
</script>

<script>
    // Get History
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