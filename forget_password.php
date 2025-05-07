<?php
session_start();
include 'databaseconnection.php'; // Include database connection

$step = 1; // Step control (1 = username/email input, 2 = reset password form)

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['verify_user'])) { // Step 1: Verify username/email
        $user_input = trim($_POST['user_input']);

        $stmt = $connection->prepare("SELECT id FROM users WHERE username = ? OR email = ?");
        $stmt->bind_param("ss", $user_input, $user_input);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows == 1) {
            $user = $result->fetch_assoc();
            $_SESSION['reset_user_id'] = $user['id']; // Store user ID for password reset
            $step = 2; // Move to the password reset step
        } else {
            $_SESSION['error'] = "No account found with that Username or Email.";
        }
    } elseif (isset($_POST['reset_password'])) { // Step 2: Reset Password
        if (!isset($_SESSION['reset_user_id'])) {
            die("Unauthorized access.");
        }

        $password = $_POST['password'];
        $confirm_password = $_POST['confirm_password'];

        if ($password !== $confirm_password) {
            $_SESSION['error'] = "Passwords do not match.";
            $step = 2; // Keep user on password reset step
        } else {
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);
            $user_id = $_SESSION['reset_user_id'];

            $stmt = $connection->prepare("UPDATE users SET password = ? WHERE id = ?");
            $stmt->bind_param("si", $hashed_password, $user_id);

            if ($stmt->execute()) {
                session_destroy(); // Clear session to prevent repeated resets
                session_start();
                $_SESSION['success'] = "Password successfully updated. You can now login.";
                header("Location: login.php"); // Redirect to login page
                exit();
            } else {
                $_SESSION['error'] = "Failed to update password.";
                $step = 2; // Keep user on password reset step
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 400px;
            margin-top: 50px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .btn-custom {
            width: 100%;
            background-color: #007bff;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .alert {
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Forgot Password</h2>

    <?php if (isset($_SESSION['error'])): ?>
        <div class="alert alert-danger"><?php echo $_SESSION['error']; unset($_SESSION['error']); ?></div>
    <?php endif; ?>

    <?php if (isset($_SESSION['success'])): ?>
        <div class="alert alert-success"><?php echo $_SESSION['success']; unset($_SESSION['success']); ?></div>
    <?php endif; ?>

    <?php if ($step === 1) : ?>
        <!-- Step 1: Username/Email Input -->
        <form action="" method="POST">
            <div class="mb-3">
                <label for="user_input" class="form-label">Enter your Username or Email</label>
                <input type="text" name="user_input" class="form-control" required>
            </div>
            <button type="submit" name="verify_user" class="btn btn-custom">Proceed</button>
        </form>

    <?php elseif ($step === 2) : ?>
        <!-- Step 2: Password Reset Form -->
        <form action="" method="POST">
            <div class="mb-3">
                <label for="password" class="form-label">New Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="confirm_password" class="form-label">Confirm Password</label>
                <input type="password" name="confirm_password" class="form-control" required>
            </div>
            <button type="submit" name="reset_password" class="btn btn-custom">Reset Password</button>
        </form>
    <?php endif; ?>
</div>