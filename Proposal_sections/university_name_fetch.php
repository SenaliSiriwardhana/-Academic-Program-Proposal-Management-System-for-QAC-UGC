<?php
// Start session to access the university name
//session_start();

// Check if the user is logged in and the university name is available
if (!isset($_SESSION['username'])) {
    header('Location: login.php'); // Redirect if not logged in
    exit();
}

// Check if the university is available in the session
if (!isset($_SESSION['university'])) {
    header('Location: home.php'); // Redirect if university is missing
    exit();
}

// Retrieve the university name from the session
$university = $_SESSION['university'];
?>
