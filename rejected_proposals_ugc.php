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

// Define UGC roles with corresponding dashboard titles & status filters
$ugc_settings = [
    "ugc - technical assistant" => ["title" => "Technical Assistant - Rejected Proposals","status" => "rejectedbyTA"],
    "ugc - secretary" => ["title" => "Secretary - Rejected Proposals","status" => "rejectedbysecretary"],
    "head of the qac-ugc department" => ["title" => "QAC Director - Rejected Proposals", "status" => "rejectedbyqachead"],
    "ugc - finance department" => ["title" => "Finance - Rejected Proposals", "status" => "rejectedbyugcfinance"],
    "ugc - hr department" => ["title" => "HR - Rejected Proposals", "status" => "rejectedbyugchr"],
    "ugc - idd department" => ["title" => "IDD - Rejected Proposals", "status" => "rejectedbyugcidd"],
    "ugc - academic department" => ["title" => "Academic - Rejected Proposals", "status" => "rejectedbyugcacademic"],
    "ugc - admission department" => ["title" => "Admission - Rejected Proposals", "status" => "rejectedbyugcadmission"],
    "standing committee" => ["title" => "Standing Committee - Rejected Proposals", "status" => "rejectedbyStandardCommittee"]
];

// Validate user role and set dashboard properties
if (!array_key_exists($_SESSION['role'], $ugc_settings)) {
    die("<pre>Error: Unauthorized access. Role detected: " . htmlspecialchars($_SESSION['role']) . "</pre>");
}

$dashboardTitle = $ugc_settings[$_SESSION['role']]['title'];
$statusFilter = $ugc_settings[$_SESSION['role']]['status'];

// Fetch all rejected proposals for the user's UGC department
$query = "SELECT p.proposal_id,p.proposal_code, p.submitted_at, p.status, u.first_name, u.last_name, gi.degree_name_english
          FROM proposals p
          JOIN users u ON p.created_by = u.id  --  Join users table to get creator's details
          LEFT JOIN proposal_general_info gi 
          ON p.proposal_id = gi.proposal_id -- Join with general info to get degree name
          WHERE p.status = ?
          ORDER BY p.submitted_at DESC";

$stmt = $connection->prepare($query);
$stmt->bind_param("s", $statusFilter); // Use the correct rejection status for the UGC department
$stmt->execute();
$result = $stmt->get_result();
$stmt->close();


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
        <div class="card-header bg-warning">Rejected Proposals</div>
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
