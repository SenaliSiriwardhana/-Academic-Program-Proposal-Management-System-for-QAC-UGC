<?php
session_start();
require 'databaseconnection.php';

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Retrieve current user details to pre-fill the form
$username = $_SESSION['username'];
$query = "SELECT first_name, last_name, email, username, role, university FROM users WHERE username = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();
$stmt->close();

if (!$user) {
    die("Error: Could not retrieve user profile.");
}

// Prepare display variables for the sidebar
$display_fullname = htmlspecialchars($user['first_name'] . ' ' . $user['last_name']);
$display_role = htmlspecialchars(str_replace(" of the university", "", $user['role']));
$display_university = htmlspecialchars($user['university']);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
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
        .sidebar.collapsed { width: 70px; }
        .sidebar .user-info { text-align: center; margin: 20px 0; }
        .sidebar .user-info h6 { margin: 0; font-size: 16px; font-weight: bold; }
        .sidebar .user-info p { margin: 0; font-size: 14px; color: #bdc3c7; }
        .sidebar .nav-item { padding: 10px 20px; }
        .sidebar .nav-link {
            color: white;
            font-size: 16px;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover { background-color: #34495e; border-radius: 4px; }
        .sidebar .nav-link i { margin-right: 10px; font-size: 18px; }
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
        .main-content.collapsed { margin-left: 70px; }
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
            font-size: 14px;
            text-align: center;
            color: #7f8c8d;
            padding: 20px 0;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div id="sidebar" class="sidebar">
    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
    <div class="user-info">
        <!-- Using variables fetched at the top for consistency -->
        <h6><?php echo $display_fullname; ?></h6>
        <p><?php echo $display_role; ?></p>
        <p><?php echo $display_university; ?></p>
    </div>
    <ul class="nav flex-column">
        <!-- Determine the correct dashboard link based on role -->
        <?php
            $dashboard_link = 'login.php'; // Default fallback
            $user_role_lower = strtolower($user['role']);
            if (strpos($user_role_lower, 'dean') !== false || strpos($user_role_lower, 'vice chancellor') !== false || strpos($user_role_lower, 'cqa director') !== false) {
                $dashboard_link = 'uni_dashboards.php';
            } elseif (strpos($user_role_lower, 'ugc') !== false || strpos($user_role_lower, 'standing committee') !== false) {
                $dashboard_link = 'ugc_dashboards.php';
            }
        ?>
        <li class="nav-item"><a class="nav-link" href="<?php echo $dashboard_link; ?>"><i class="fas fa-home"></i> Dashboard</a></li>
        <li class="nav-item"><a class="nav-link active" href="edit_profile.php"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
        <li class="nav-item"><a class="nav-link" href="login.php"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</div>

<!-- Main Content -->
<div id="main-content" class="main-content">

    <div class="card">
        <div class="card-header bg-primary text-white">
            <h4><i class="fas fa-user-edit"></i> Edit Your Profile</h4>
        </div>
        <div class="card-body p-4">
            <?php
            // Display success or error messages if they exist
            if (isset($_SESSION['message'])) {
                $alert_class = $_SESSION['message_type'] === 'success' ? 'alert-success' : 'alert-danger';
                echo "<div class='alert {$alert_class}' role='alert'>{$_SESSION['message']}</div>";
                unset($_SESSION['message']);
                unset($_SESSION['message_type']);
            }
            ?>
            <form action="update_profile.php" method="POST">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="first_name" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="first_name" name="first_name" value="<?php echo htmlspecialchars($user['first_name']); ?>" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="last_name" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="last_name" name="last_name" value="<?php echo htmlspecialchars($user['last_name']); ?>" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" required>
                </div>
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="<?php echo htmlspecialchars($user['username']); ?>" required>
                </div>
                <hr class="my-4">
                <p class="text-muted">Only fill out the password fields below if you want to change your password.</p>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="new_password" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="new_password" name="new_password" placeholder="Enter new password">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="confirm_password" class="form-label">Confirm New Password</label>
                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Confirm new password">
                    </div>
                </div>
                <div class="d-flex justify-content-end mt-3">
                    <a href="<?php echo $dashboard_link; ?>" class="btn btn-secondary me-2">Cancel</a>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <footer>
        Copyright © 2024 University Grants Commission. Developed by UGC.
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('collapsed');
        document.getElementById('main-content').classList.toggle('collapsed');
    }
</script>
</body>
</html>