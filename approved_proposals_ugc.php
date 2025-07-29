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
$query = "SELECT first_name, last_name, role FROM users WHERE username = ?";
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


// (This replaces the entire PHP logic section in approved_proposals_ugc.php)

$role = $_SESSION['role'];

// Define the statuses that mean a proposal is "in the parallel review pool"
$department_pool_statuses = ['approvedbyqachead', 'approvedbyqachead_revised', 're-signed_vc'];

// Define UGC roles with corresponding dashboard titles & status filters
$ugc_settings = [
    "ugc - technical assistant" => ["title" => "Approved by Technical Assistant", "status_list" => ["approvedbyTA"]],
    "ugc - secretary" => ["title" => "Approved by Secretary", "status_list" => ["approvedbysecretary"]],
    "head of the qac-ugc department" => ["title" => "Approved by Head of QAC", "status_list" => $department_pool_statuses],
    "ugc - finance department" => ["title" => "Finance - Approved Proposals", "comment_status" => "approvedbyugcfinance"],
    "ugc - hr department" => ["title" => "HR - Approved Proposals", "comment_status" => "approvedbyugchr"],
    "ugc - idd department" => ["title" => "IDD - Approved Proposals", "comment_status" => "approvedbyugcidd"],
    "ugc - academic department" => ["title" => "Academic - Approved Proposals", "comment_status" => "approvedbyugcacademic"],
    "ugc - admission department" => ["title" => "Admission - Approved Proposals", "comment_status" => "approvedbyugcadmission"],
    "standing committee" => ["title" => "Standing Committee - Approved Proposals", "status_list" => ["approvedbyStandardCommittee"]]
];

// Validate user role and get settings
if (!array_key_exists($role, $ugc_settings)) {
    die("<pre>Error: Unauthorized access. Role detected: " . htmlspecialchars($role) . "</pre>");
}

$dashboardTitle = $ugc_settings[$role]['title'];
$role_settings = $ugc_settings[$role];

// --- NEW UNIFIED QUERY LOGIC ---

$approved_proposals = []; // Initialize the array

$base_query = "SELECT p.proposal_id, p.proposal_code, p.submitted_at, p.status AS status, 
                      u.first_name, u.last_name, gi.degree_name_english
               FROM proposals p
               JOIN users u ON p.created_by = u.id
               LEFT JOIN proposal_general_info gi ON p.proposal_id = gi.proposal_id";

// Check if this role uses the 'comment_status' method (for the 5 parallel departments)
if (isset($role_settings['comment_status'])) {
    
    // This is a department user.
    // Show proposals they approved AND that are still in the department review pool.
    $comment_status = $role_settings['comment_status'];
    
    $placeholders = implode(',', array_fill(0, count($department_pool_statuses), '?'));

    $query = "$base_query
              WHERE p.status IN ($placeholders) -- Fix for Problem 2
                AND EXISTS (
                  SELECT 1 FROM proposal_comments pc
                  WHERE pc.proposal_id = p.proposal_id AND pc.proposal_status = ?
              )
              ORDER BY p.submitted_at DESC";
              
    $stmt = $connection->prepare($query);
    // Bind all the pool statuses, and then the specific comment status
    $params_to_bind = array_merge($department_pool_statuses, [$comment_status]);
    $types = str_repeat('s', count($department_pool_statuses)) . 's';
    $stmt->bind_param($types, ...$params_to_bind);

} 
// Check if this role uses the 'status_list' method (for everyone else)
elseif (isset($role_settings['status_list'])) {
    
    // This is a standard role (like QAC Head, Secretary, Standard Committee, etc.).
    $status_list = $role_settings['status_list'];
    
    $placeholders = implode(',', array_fill(0, count($status_list), '?'));

    $query = "$base_query
              WHERE p.status IN ($placeholders) -- Fix for Problem 1
              ORDER BY p.submitted_at DESC";
              
    $stmt = $connection->prepare($query);
    // Bind all statuses from the list
    $types = str_repeat('s', count($status_list));
    $stmt->bind_param($types, ...$status_list);
}

// Execute the query only if a statement was prepared
if (isset($stmt)) {
    $stmt->execute();
    $result = $stmt->get_result();
    // The loop to fetch results will be in your HTML part
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
    </style>
</head>
<body>

<!-- Sidebar -->
<div id="sidebar" class="sidebar">
    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
    <div class="user-info">
        <h6><?php echo htmlspecialchars($_SESSION['full_name']); ?></h6>
        <p><?php echo htmlspecialchars($_SESSION['role']); ?></p>
        
    </div>
    <ul class="nav flex-column">
        <li class="nav-item"><a class="nav-link" href="ugc_dashboards.php"><i class="fas fa-home"></i> Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="approved_proposals_ugc.php"><i class="fas fa-check-circle"></i> Approved Proposals</a></li>
        <li class="nav-item"><a class="nav-link" href="rejected_proposals_ugc.php"><i class="fas fa-times-circle"></i> Rejected Proposals</a></li>
        <li class="nav-item"><a class="nav-link" href="login.php"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</div>

<!-- Main Content -->
<div id="main-content" class="main-content">
    <h3><?php echo $dashboardTitle; ?></h3>

    <div class="card">
        <div class="card-header bg-warning">Approved Proposals</div>
        <div class="card-body">
            <table class="table">
                <tr>
                    
                    <th>Proposal Code</th>
                    <th>Degree Name </th>
                    <th>Submitted Date</th>
                    <th>Submitted By</th>
                   
                </tr>
                <?php while ($row = $result->fetch_assoc()) { ?>
                    <tr>
                        
                        <td><?php echo $row['proposal_code']; ?></td>
                        <td><?php echo $row['degree_name_english']; ?></td>
                        <td><?php echo $row['submitted_at']; ?></td>
                        <td><?php echo $row['first_name'] . " " . $row['last_name']; ?></td>
                        
                    </tr>
                <?php } ?>
            </table>
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
</body>
</html>
