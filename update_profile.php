<?php
session_start();
require 'databaseconnection.php';

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: edit_profile.php');
    exit();
}

// Get the current username from session to identify the user
$current_username = $_SESSION['username'];

// Retrieve and sanitize form data
$first_name = trim($_POST['first_name']);
$last_name = trim($_POST['last_name']);
$email = trim($_POST['email']);
$new_username = trim($_POST['username']);
$new_password = $_POST['new_password'];
$confirm_password = $_POST['confirm_password'];

// --- Validation ---
if (empty($first_name) || empty($last_name) || empty($email) || empty($new_username)) {
    $_SESSION['message'] = 'All fields except password are required.';
    $_SESSION['message_type'] = 'danger';
    header('Location: edit_profile.php');
    exit();
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $_SESSION['message'] = 'Invalid email format.';
    $_SESSION['message_type'] = 'danger';
    header('Location: edit_profile.php');
    exit();
}

// Check if the new username is already taken by ANOTHER user
if ($new_username !== $current_username) {
    $stmt = $connection->prepare("SELECT id FROM users WHERE username = ?");
    $stmt->bind_param("s", $new_username);
    $stmt->execute();
    if ($stmt->get_result()->num_rows > 0) {
        $_SESSION['message'] = 'Username is already taken. Please choose another.';
        $_SESSION['message_type'] = 'danger';
        header('Location: edit_profile.php');
        exit();
    }
    $stmt->close();
}

// --- Dynamic SQL Query Building ---
$sql_parts = [];
$params = [];
$types = "";

// Always update these fields
$sql_parts[] = "first_name = ?";
$params[] = $first_name;
$types .= "s";

$sql_parts[] = "last_name = ?";
$params[] = $last_name;
$types .= "s";

$sql_parts[] = "email = ?";
$params[] = $email;
$types .= "s";

$sql_parts[] = "username = ?";
$params[] = $new_username;
$types .= "s";

// Conditionally update password if a new one is provided
if (!empty($new_password)) {
    if ($new_password !== $confirm_password) {
        $_SESSION['message'] = 'Passwords do not match.';
        $_SESSION['message_type'] = 'danger';
        header('Location: edit_profile.php');
        exit();
    }
    $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);
    $sql_parts[] = "password = ?";
    $params[] = $hashed_password;
    $types .= "s";
}

// Construct the final query
$sql = "UPDATE users SET " . implode(', ', $sql_parts) . " WHERE username = ?";
$params[] = $current_username;
$types .= "s";

// Prepare and execute the statement
$stmt = $connection->prepare($sql);
$stmt->bind_param($types, ...$params);

if ($stmt->execute()) {
    // If the username was changed, update the session variable
    $_SESSION['username'] = $new_username;
    
    $_SESSION['message'] = 'Profile updated successfully!';
    $_SESSION['message_type'] = 'success';
} else {
    $_SESSION['message'] = 'Error updating profile: ' . $stmt->error;
    $_SESSION['message_type'] = 'danger';
}

$stmt->close();
$connection->close();

// Redirect back to the edit profile page to show the message
header('Location: edit_profile.php');
exit();
?>