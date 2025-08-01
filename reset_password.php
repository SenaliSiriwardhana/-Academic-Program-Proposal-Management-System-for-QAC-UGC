<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f7f8fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            width: 400px;
            padding: 30px;
            border: none;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        

        .btn-success {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }

        .form-control {
            border-radius: 5px;
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
        }

       footer {
            position: absolute;
            bottom: 10px;
            width: 100%;
            text-align: center;
            font-size: 14px;
            color: #7f8c8d;
        }


      
    </style>
</head>
<body>
    <?php
    // Include database connection
    include 'databaseconnection.php';

    // Backend logic for resetting the password
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $username = trim($_POST['uname']); // Username field
        $currentPassword = trim($_POST['current_password']); // Current password field
        $newPassword = trim($_POST['new_password']); // New password field
        $confirmPassword = trim($_POST['confirm_password']); // Confirm password field

        // Validate all fields are filled
        if (empty($username) || empty($currentPassword) || empty($newPassword) || empty($confirmPassword)) {
            echo "<div class='alert alert-danger'>All fields are required.</div>";
        } else {
            // Validate if new passwords match
            if ($newPassword === $confirmPassword) {
                // Fetch the current password hash for the username
                $stmt = $connection->prepare("SELECT password FROM users WHERE username = ?");
                $stmt->bind_param("s", $username);
                $stmt->execute();
                $stmt->store_result();

                if ($stmt->num_rows > 0) {
                    $stmt->bind_result($password);
                    $stmt->fetch();

                    // Verify the current password
                    if (password_verify($currentPassword, $password)) {
                        // Hash the new password
                        //$newHashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);

                        // Update the password in the database
                        $updateStmt = $connection->prepare("UPDATE users SET password = ? WHERE username = ?");
                        $updateStmt->bind_param("ss", $newPassword, $username);

                        if ($updateStmt->execute()) {
                            echo "<script>
                                alert('Password reset successfully.');
                                window.location.href = 'login.php';
                            </script>";
                        } else {
                            echo "<div class='alert alert-danger'>Error updating password. Please try again.</div>";
                        }

                        $updateStmt->close();
                    } else {
                        echo "<div class='alert alert-danger'>Current password is incorrect. Please try again.</div>";
                    }
                } else {
                    echo "<div class='alert alert-danger'>No account found with the provided username.</div>";
                }

                $stmt->close();
            } else {
                echo "<div class='alert alert-danger'>New passwords do not match. Please try again.</div>";
            }
        }
    }

    $connection->close();
    ?>

    <div class="card text-center">
        <h4 class="mb-2">Reset Password</h4>
        <p class="text-muted mb-4">Please fill in all fields to reset your password</p>

        <form method="POST" action="">
            <!-- Username -->
            <div class="mb-3 position-relative">
                <input type="text" class="form-control" id="uname" name="uname" placeholder="Username" required>
            </div>

            <!-- Current Password -->
            <div class="mb-3 position-relative">
                <input type="password" class="form-control" id="currentPassword" name="current_password" placeholder="Current Password" required>
                <i class="fas fa-eye toggle-password" onclick="togglePassword('currentPassword')"></i>
            </div>

            <!-- New Password -->
            <div class="mb-3 position-relative">
                <input type="password" class="form-control" id="newPassword" name="new_password" placeholder="New Password" required>
                <i class="fas fa-eye toggle-password" onclick="togglePassword('newPassword')"></i>
            </div>

            <!-- Confirm Password -->
            <div class="mb-3 position-relative">
                <input type="password" class="form-control" id="confirmPassword" name="confirm_password" placeholder="Confirm Password" required>
                <i class="fas fa-eye toggle-password" onclick="togglePassword('confirmPassword')"></i>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-success w-100">Reset Password</button>
        </form>
    </div>

    <script>
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const icon = input.nextElementSibling;
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }
    </script>

    <footer>
        Copyright © 2024 University Grants Commission. Developed by UGC.
    </footer>
</body>
</html>
