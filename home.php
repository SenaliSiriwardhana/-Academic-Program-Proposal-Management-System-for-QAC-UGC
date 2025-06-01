<?php
// Start session
session_start();

// Include database connection
include 'databaseconnection.php';

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();

}

// Retrieve the logged-in user's details from the database
$username = $_SESSION['username'];
$query = "SELECT first_name, last_name, role, university FROM users WHERE username = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    $full_name = $user['first_name'] . ' ' . $user['last_name'];
    $Role = str_replace(" of the university", "", $user['role']); //avoid "of the university" part
    $university = $user['university'];

    // Save university to session for use program_entity section
    $_SESSION['university'] = $university;

} else {
    $full_name = "Unknown User";
    $Role = "Unknown Role";
    $university = "Unknown University";

     // Set default for session
     $_SESSION['university'] = $university;
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Proposal Management</title>
    <!-- Bootstrap CSS -->
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
        <li><a class="nav-link sub-link" href="new_proposal.php">Undergraduate Programs</a></li>
        <li><a class="nav-link sub-link" href="new_proposal_postgraduate.php">Postgraduate Programs</a></li>
        <li><a class="nav-link sub-link" href="new_proposal_external.php">External Programs</a></li>
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


    <footer>
        Copyright © 2024 University Grants Commission. Developed by UGC.
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('collapsed');
        }
	function toggleDropdown() {
            const menu = document.getElementById('proposalDropdown');
            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
        }
    </script>
</body>
</html>
