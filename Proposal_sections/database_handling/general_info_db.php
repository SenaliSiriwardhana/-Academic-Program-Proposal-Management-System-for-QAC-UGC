<?php

include __DIR__ . '/../../databaseconnection.php';

if (!isset($_SESSION['id']) && isset($_SESSION['username'])) {
    $stmt = $connection->prepare("SELECT id FROM users WHERE username = ?");
    $stmt->bind_param("s", $_SESSION['username']);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        $_SESSION['id'] = $row['id']; //  Store it in the session
    }
}

$user_id = $_SESSION['id'] ?? null;

// Ensure content_id exists or retrieve the last saved draft
if (!isset($_SESSION['proposal_id'])) {
    $stmt = $connection->prepare("SELECT proposal_id FROM proposals WHERE id = ? ORDER BY proposal_id DESC LIMIT 1");
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($row = $result->fetch_assoc()) {
        $_SESSION['proposal_id'] = $row['proposal_id'];
    }
}
$proposal_id = $_SESSION['proposal_id'] ?? null;

// Fetch saved data only if session is empty
if ($proposal_id && !isset($_SESSION['proposal_general_info'])) {
    $stmt = $connection->prepare("SELECT degree_name_english, degree_name_sinhala, degree_name_tamil, abbreviated_qualification FROM proposal_general_info WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($row = $result->fetch_assoc()) {
        $_SESSION['proposal_general_info'] = $row;
    } else {
        $_SESSION['proposal_general_info'] = ['degree_name_english' => '', 'degree_name_sinhala' => '', 'degree_name_tamil' => '', 'abbreviated_qualification' => ''];
    }
}
// Only store in session, don't save to database here
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $_SESSION['proposal_general_info'] = [
        'degree_name_english' => $_POST['degree_name_english'],
        'degree_name_sinhala' => $_POST['degree_name_sinhala'],
        'degree_name_tamil' => $_POST['degree_name_tamil'],
        'abbreviated_qualification' => $_POST['abbreviated_qualification']
    ];
    
    // Debug information
    error_log("Saving to session: " . print_r($_SESSION['proposal_general_info'], true));
    error_log("Proposal ID: " . $proposal_id);
    
    // Ensure proposal_id exists
    if (!$proposal_id) {
        // Create new proposal if none exists
        $stmt = $connection->prepare("INSERT INTO proposals (user_id, status) VALUES (?, 'draft')");
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        $proposal_id = $connection->insert_id;
        $_SESSION['proposal_id'] = $proposal_id;
    }

    // Save to database immediately
    $stmt = $connection->prepare("INSERT INTO proposal_general_info 
        (proposal_id, degree_name_english, degree_name_sinhala, degree_name_tamil, abbreviated_qualification) 
        VALUES (?, ?, ?, ?, ?) 
        ON DUPLICATE KEY UPDATE 
        degree_name_english = VALUES(degree_name_english),
        degree_name_sinhala = VALUES(degree_name_sinhala),
        degree_name_tamil = VALUES(degree_name_tamil),
        abbreviated_qualification = VALUES(abbreviated_qualification)");
    
    if ($stmt) {
        $stmt->bind_param("issss", 
            $proposal_id,
            $_POST['degree_name_english'],
            $_POST['degree_name_sinhala'],
            $_POST['degree_name_tamil'],
            $_POST['abbreviated_qualification']
        );
        
        if (!$stmt->execute()) {
            error_log("Database error: " . $stmt->error);
        }
    }
    
    header("Location: ../general_info.php");
    exit();
}
?>