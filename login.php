<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Include database connection
include 'databaseconnection.php';

// Start session
session_start();
session_destroy(); 
session_start();

// Initialize feedback message
$message = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = htmlspecialchars(trim($_POST['uname']));
    $password = htmlspecialchars(trim($_POST['password']));
    

    // Check if the username exists
    $stmt = $connection->prepare("SELECT id, password, first_name, last_name, university, email, role FROM users WHERE username = ?");
    if ($stmt === false) {
        die("Failed to prepare statement: " . $connection->error);
    }

    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        $stmt->bind_result($user_id, $hashed_password, $first_name, $last_name, $university, $email, $role);
        $stmt->fetch();

        // Verify the password
        if (password_verify($password, $hashed_password)) {
            
            // Successful login
            $_SESSION['id'] = $user_id;
            $_SESSION['username'] = $username;
            $_SESSION['role'] = $role; // Store user role in session
            $_SESSION['first_name'] = $first_name;
            $_SESSION['last_name'] = $last_name;
            $_SESSION['university'] = $university;
            $_SESSION['email'] = $email;

            // Role-Based Redirection
            switch ($role) {
                case 'Program Coordinator of the university':
                    header("Location: submitted_proposals.php");
                    break;
                case 'Dean/Rector/Director of the university':
                    header("Location: uni_dashboards.php");
                    break;
                case 'Vice Chancellor of the university':
                    header("Location:  uni_dashboards.php");
                    break;
                case 'CQA Director of the university':
                    header("Location:  uni_dashboards.php");
                    break;
                case 'Head of the QAC-UGC Department':
                    header("Location:  ugc_dashboards.php");
                    break;
                case 'UGC - Finance Department':
                    header("Location:  ugc_dashboards.php");
                    break;
                case 'UGC - HR Department':
                    header("Location:  ugc_dashboards.php");
                    break;
                case 'UGC - IDD Department':
                    header("Location:  ugc_dashboards.php");
                    break;
                case 'UGC - Academic Department':
                    header("Location:  ugc_dashboards.php");
                    break;
                case 'UGC - Admission Department':
                    header("Location:  ugc_dashboards.php");
                    break;
                case 'UGC - Technical Assistant':
                    header("Location:  ugc_dashboards.php");
                    break;
                case 'UGC - Secretary':
                    header("Location:  ugc_dashboards.php");
                    break;
                case 'Standard Committee':
                    header("Location:  ugc_dashboards.php");
                    break;
                default:
                    echo "<script>alert('Unauthorized role. Contact admin.');</script>";
                    session_destroy();
                    exit();
            }
            exit;
        } else {
            //Incorrect password
            echo "<script>alert('Incorrect password. Please try again.');</script>";
        }
    } else {
        //Username not found
        echo "<script>alert('No account found with that username.');</script>";
    }

    $stmt->close();
}
$connection->close();
?>


<!-- login/index.php -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - UGC Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        .login-container {
            animation: fadeIn 0.6s ease-out;
        }
        .logo-container img {
            max-width: 100px;
            height: auto;
            transition: transform 0.3s ease;
            border-radius: 15px;
        }
        .logo-container img:hover {
            transform: scale(1.05);
        }
        .card {
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .form-control {
            border: 2px solid #e1e5ea;
            padding: 12px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.15);
        }
        .btn-primary {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #344767;
        }
        .card-title {
            color: #344767;
            font-weight: 600;
            letter-spacing: -0.5px;
        }
        .links-container a {
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .links-container a:hover {
            color: #0056b3;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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
    <div class="container d-flex flex-column justify-content-center align-items-center min-vh-100">
        <div class="login-container">
            <div class="card" style="width: 420px; border-radius: 16px;">
                <div class="card-body p-4 p-md-5">
                    <div class="logo-container text-center mb-4">
                        <img src="/qac_ugc/Images/UgcLogoL.jpg" alt="UGC Logo" class="img-fluid">
                    </div>
                    <h4 class="card-title text-center mb-4">Academic Program Proposal Management System QAC-UGC</h4>
                    <form action="login.php" method="POST">
                        <div class="mb-4">
                            <label for="uname" class="form-label">Username</label>
                            <input type="text" class="form-control" id="uname" name="uname" required 
                                   placeholder="Enter your username" style="border-radius: 10px;">
                        </div>
                        <div class="mb-4">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required 
                                   placeholder="Enter your password" style="border-radius: 10px;">
                        </div>
                        <button type="submit" class="btn btn-primary w-100" style="border-radius: 10px;">Sign In</button>
                    </form>
                    <div class="links-container text-center mt-4">
                        <a href="forget_password.php" class="d-block mb-3">Forgot your password?</a>
                        <div class="text-muted">
                            Don't have an account? <a href="signup.php" class="ms-1">Create one</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

     <footer>
        Copyright © 2024 University Grants Commission. Developed by UGC.
    </footer>

</body>
</html>

