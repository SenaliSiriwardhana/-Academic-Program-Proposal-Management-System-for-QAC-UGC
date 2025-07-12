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
$role = trim(strtolower($_SESSION['role'])); // Normalize role
$university = $_SESSION['university'];
$statusFilter = [];

if (strpos($role, "dean") !== false)  {
    $dashboardTitle = "Dean - Approved Proposals";
    $statusFilter = ['approvedbydean', 're-signed_dean']; // Dean sees proposals approved by them]]
    $dashboardPage = "uni_dashboards.php";
    $approvedPage = "approved_proposals.php";
    $rejectedPage = "rejected_proposals.php";

} elseif (strpos($role, "vice chancellor") !== false || strpos($role, "vc") !== false) {
    $dashboardTitle = "VC - Approved Proposals";
    $statusFilter = ['approvedbyvc', 're-signed_vc']; // VC sees proposals approved by them
    $dashboardPage = "uni_dashboards.php";
    $approvedPage = "approved_proposals.php";
    $rejectedPage = "rejected_proposals.php";

} elseif (strpos($role, "CQA Director") !== false || strpos($role, "cqa") !== false) {
    $dashboardTitle = "CQA Director - Approved Proposals";
    $statusFilter = ['approvedbycqa', 're-signed_cqa']; // CQA sees proposals approved by them
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

$placeholders = implode(',', array_fill(0, count($statusFilter), '?'));

// Fetch proposals based on role
$query = "SELECT p.proposal_id,p.proposal_code, p.submitted_at, u.first_name, u.last_name, gi.degree_name_english
          FROM proposals p
          JOIN users u ON p.created_by = u.id
          LEFT JOIN proposal_general_info gi 
          ON p.proposal_id = gi.proposal_id -- Join with general info to get degree name
          WHERE p.status IN ($placeholders)  
          AND u.university_id = ? 
          ORDER BY p.submitted_at DESC";

// 3. Prepare the parameters for binding.
// The array of statuses needs to be combined with the university_id.
$params_to_bind = array_merge($statusFilter, [$university_id]);

// 4. Define the data types for each parameter. 's' for each status string, 'i' for the integer university_id.
$types = str_repeat('s', count($statusFilter)) . 'i';

// 5. Prepare, bind, and execute the statement.
$stmt = $connection->prepare($query);
$stmt->bind_param($types, ...$params_to_bind);
$stmt->execute();
$result = $stmt->get_result();


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
        <p><?php echo htmlspecialchars($_SESSION['university']); ?></p>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item"><a class="nav-link" href="uni_dashboards.php"><i class="fas fa-home"></i> Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="approved_proposals.php"><i class="fas fa-check-circle"></i> Approved Proposals</a></li>
        <li class="nav-item"><a class="nav-link" href="rejected_proposals.php"><i class="fas fa-times-circle"></i> Rejected Proposals</a></li>
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
