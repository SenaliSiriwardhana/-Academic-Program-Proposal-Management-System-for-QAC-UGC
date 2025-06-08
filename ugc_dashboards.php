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

// Define UGC roles with corresponding dashboard titles & status filters
$ugc_settings = [
    "head of the qac-ugc department" => ["title" => "Head of QAC-UGC Dashboard", "status" => "approvedbyvc"],
    "ugc - finance department" => ["title" => "UGC - Finance Department Dashboard", "status" => "approvedbyqachead"],
    "ugc - hr department" => ["title" => "UGC - Human Resources Dashboard", "status" => "approvedbyugcfinance"],
    "ugc - idd department" => ["title" => "UGC -IDD Dashboard", "status" => "approvedbyugchr"],
    "ugc - legal department" => ["title" => "UGC - Legal Affairs Dashboard", "status" => "approvedbyugcidd"],
    "ugc - academic department" => ["title" => "UGC - Academic Affairs Dashboard", "status" => "approvedbyugcadmission"],
    "ugc - admission department" => ["title" => "UGC - Admission Department", "status" => "approvedbyugclegal"]
];

// Validate user role and set dashboard properties
if (!array_key_exists($_SESSION['role'], $ugc_settings)) {
    die("<pre>Error: Unauthorized access. Role detected: " . htmlspecialchars($_SESSION['role']) . "</pre>");
}

$dashboardTitle = $ugc_settings[$_SESSION['role']]['title'];
$statusFilter = $ugc_settings[$_SESSION['role']]['status'];


// Retrieve submitted proposals
$pendingProposals = [];
//$stmt = $connection->prepare("SELECT proposal_id, status FROM proposals WHERE status IN ('approvedbycqa') ORDER BY proposal_id ASC");
$stmt = $connection->prepare("SELECT p.proposal_id,p.proposal_code, p.submitted_at, u.first_name, u.last_name, u.university, gi.degree_name_english
    FROM proposals p
    JOIN users u ON p.created_by = u.id
    LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id
    WHERE p.status = ? 
    ORDER BY p.submitted_at ASC");

$stmt->bind_param("s", $statusFilter);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $pendingProposals[] = $row;
}
$stmt->close();

// Retrieve submitted proposals
$submittedProposals = [];
$stmt = $connection->prepare("SELECT p.proposal_id,p.proposal_code, p.status, u.university, gi.degree_name_english FROM proposals p join users u on p.created_by=u.id LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id WHERE p.status NOT IN ('draft', 'fresh','submitted','approvedbydean','rejectedbydean','approvedbyvc','rejectedbyvc','rejectedbycqa') ORDER BY proposal_id ASC");
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $submittedProposals[] = $row;
}
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
                    <th>Degree Name </th>
                    <th>Submitted Date</th>
                    <th>Submitted By</th>
                    <th>University </th>
                    <th>Action</th>
                </tr>
                <?php foreach ($pendingProposals as $pproposal) { ?>
                    <tr>
                        <td><?php echo $pproposal['proposal_code']; ?></td>
                        <td><?php echo $pproposal['degree_name_english']; ?></td>
                        <td><?php echo $pproposal['submitted_at']; ?></td>
                        <td><?php echo $pproposal['first_name'] . " " . $pproposal['last_name']; ?></td>
                        <td><?php echo $pproposal['university']?> </td>
                        <td><a href="review_proposal_ugc.php?id=<?php echo $pproposal['proposal_id']; ?>" class="btn btn-primary">Review</a></td>
                    </tr>
                <?php } ?>
            </table>
        </div>
    </div>

    <!-- Spacer -->
    <div class="mb-4"></div> <!-- Adds spacing between tables -->

    <div class="card">
        <div class="card-header bg-warning">Submitted Proposals Status</div>
            <div class="card-body">
                <table class="table">
                <tr>
                        <th>Proposal Code</th>
                        <th>Degree Name</th>
                        <th>Status</th>
                        <th>University</th>
                
                </tr>
                <?php foreach ($submittedProposals as $proposal) { ?>
                    <tr>
                        <td><?php echo $proposal['proposal_code']; ?></td>
                        <td><?php echo $proposal['degree_name_english']; ?></td>
                        <td><?php echo $proposal['status']; ?></td>
                        <td><?php echo $proposal['university']?></td>
                    
                    </tr>
                <?php } ?>
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


</body>
</html>