<?php
session_start();
require 'databaseconnection.php'; // Database connection


// Debug session data (remove after testing)
//echo "<pre>";
//print_r($_SESSION);
//echo "</pre>";



// Allow roles that include "Dean"
//if (strpos($_SESSION['role'], 'Dean') === false) {
   // die("Access Denied. You do not have permission.");
//}

$role = $_SESSION['role'];
$username = $_SESSION['username'];
$user_id = $_SESSION['id']; // Fixed: Using 'id' 

//  Validate that proposal_id exists
if (!isset($_POST['proposal_id']) || empty($_POST['proposal_id'])) {
    die("Error: Proposal ID is missing.");
}

$proposal_id = $_POST['proposal_id'];
$dean_comment = isset($_POST['dean_comment']) ? trim($_POST['dean_comment']) : '';
$proposal_status = '';

//  Check if the role is Dean, VC, or CQA Director and assign the correct status
if (isset($_POST['approve'])) {
    if (
        strpos($role, "Dean/Rector/Director") !== false ||
        strcasecmp(trim($role), "CQA Director") === 0
    ) {
        $proposal_status = (strpos($role, "Dean/Rector/Director") !== false) ? 'approvedbydean' : 'approvedbycqa';
        // Skip file requirement for these two roles
        $seal_and_sign = null;
    } else {
        // Require file for others
        if (empty($_FILES['signature_file']['name'])) {
          echo "<script>alert('Signature file is required for this role.'); window.history.back();</script>";
            exit;

        }

    if (strpos($role, "Vice Chancellor") !== false || strpos($role, "vc") !== false) {
        $proposal_status = 'approvedbyvc'; // VC approves
    } elseif (strcasecmp(trim($role), "Head of the qac-ugc Department") === 0) { //  Case-insensitive check for CQA
        $proposal_status = 'approvedbyqachead'; // UGC-HEAD approves
    }elseif (strcasecmp(trim($role), "UGC - Finance Department") === 0) { //  Case-insensitive check for Finance
        $proposal_status = 'approvedbyugcfinance'; // UGC-Finance approves
    }elseif (strcasecmp(trim($role), "UGC - HR Department") === 0) { //  Case-insensitive check for HR
        $proposal_status = 'approvedbyugchr'; // UGC-HR approves
    }elseif (strcasecmp(trim($role), "UGC - IDD Department") === 0) { //  Case-insensitive check for IDD
        $proposal_status = 'approvedbyugcidd'; // UGC-IDD approves
    }elseif (strcasecmp(trim($role), "UGC - Legal Department") === 0) { //  Case-insensitive check for Legal
        $proposal_status = 'approvedbyugclegal'; // UGC-Legal approves
    }elseif (strcasecmp(trim($role), "UGC - Academic Department") === 0) { //  Case-insensitive check for Academic
        $proposal_status = 'approvedbyugcacademic'; // UGC-Academic approves
    }elseif (strcasecmp(trim($role), "UGC - Admission Department") === 0) { //  Case-insensitive check for Admission
        $proposal_status = 'approvedbyugcadmission'; // UGC-Admission approves
    } else {
        die("Access Denied: Unauthorized role.");
    }
    }
}

elseif (isset($_POST['reject'])) {
    if (strpos($role, "Dean/Rector/Director") !== false) {
        $proposal_status = 'rejectedbydean'; // Dean rejects
    } elseif (strpos($role, "Vice Chancellor") !== false || strpos($role, "vc") !== false) {
        $proposal_status = 'rejectedbyvc'; // VC rejects
    } elseif (strcasecmp(trim($role), "CQA Director") === 0) { //  CQA Director rejection
        $proposal_status = 'rejectedbycqa'; // CQA rejects
    } elseif (strcasecmp(trim($role), "Head of the qac-ugc Department") === 0) { //  Case-insensitive check for CQA
        $proposal_status = 'rejectedbyqachead'; // UGC-HEAD approves
    }elseif (strcasecmp(trim($role), "UGC - Finance Department") === 0) { //  Case-insensitive check for Finance
        $proposal_status = 'rejectedbyugcfinance'; // UGC-Finance approves
    }elseif (strcasecmp(trim($role), "UGC - HR Department") === 0) { //  Case-insensitive check for HR
        $proposal_status = 'rejectedbyugchr'; // UGC-HR approves
    }elseif (strcasecmp(trim($role), "UGC - IDD Department") === 0) { //  Case-insensitive check for IDD
        $proposal_status = 'rejectedbyugcidd'; // UGC-IDD approves
    }elseif (strcasecmp(trim($role), "UGC - Legal Department") === 0) { //  Case-insensitive check for Legal
        $proposal_status = 'rejectedbyugclegal'; // UGC-Legal approves
    }elseif (strcasecmp(trim($role), "UGC - Academic Department") === 0) { //  Case-insensitive check for Academic
        $proposal_status = 'rejectedbyugcacademic'; // UGC-Academic approves
    }elseif (strcasecmp(trim($role), "UGC - Admission Department") === 0) { //  Case-insensitive check for Admission
        $proposal_status = 'rejectedbyugcadmission'; // UGC-Admission approves
    } else {
        die("Access Denied: Unauthorized role.");
    }
} else {
    echo "<script>alert('Invalid action. Please check whether signature file uploaded or not'); window.history.back();</script>";
  
    
}


//  Handle file upload (if provided)
$seal_and_sign = NULL;
if (!is_null($seal_and_sign) || !empty($_FILES['signature_file']['name'])) {
    
    $upload_dir = $_SERVER['DOCUMENT_ROOT'] . "/qac_ugc/Proposal_sections/uploads/"; // Physical path
    $file_name = time() . "_" . basename($_FILES['signature_file']['name']);
    $target_path = $upload_dir . $file_name;

    $file_url = "http://localhost/qac_ugc/Proposal_sections/uploads/" . $file_name; // Public URL

    //  Allow only PDF
    $allowed_extensions = ['pdf'];
    $file_ext = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));

    if (!in_array($file_ext, $allowed_extensions)) {
        die("Invalid file type. Only PDF files are allowed.");
    }

    //  Move the uploaded file
    if (move_uploaded_file($_FILES['signature_file']['tmp_name'], $target_path)) {
        $seal_and_sign = $file_url; // Store full URL in database
    } else {
        die("Error uploading file.");
    }

    //  Enforce signature file upload when approving
    if (isset($_POST['approve']) && empty($seal_and_sign)) {
        die("Error: Signature file (PDF) is required for approval.");
    }

}

//echo "<pre>DEBUG: Updated By User ID = " . ($_SESSION['id'] ?? 'NULL') . "</pre>";
$updated_by = $_SESSION['id']; // Assign logged-in user ID

 // Fetch previous status before updating
 $stmt = $connection->prepare("SELECT status FROM proposals WHERE proposal_id = ?");
 $stmt->bind_param("i", $proposal_id);
 $stmt->execute();
 $stmt->bind_result($previous_status);
 $stmt->fetch();
 $stmt->close();


 // Log status change in proposal_history table
 $stmt = $connection->prepare("
     INSERT INTO proposal_status_history (proposal_id, updated_by, previous_status, new_status) 
     VALUES (?, ?, ?, ?)
 ");
 $stmt->bind_param("isss", $proposal_id, $updated_by, $previous_status, $proposal_status);
 $stmt->execute();
 $stmt->close();

//  Start database transaction
$connection->begin_transaction();
//require 'email_function.php';
try {
    //  Update proposals table status
        $updateProposalQuery = "UPDATE proposals SET status = ? WHERE proposal_id = ?";
        $stmt = $connection->prepare($updateProposalQuery);
        $stmt->bind_param("si", $proposal_status, $proposal_id);
        $stmt->execute();
             
        

    //  Check if a comment already exists for this proposal
        $checkCommentQuery = "SELECT comment_id FROM proposal_comments WHERE proposal_id = ?";
        $stmt = $connection->prepare($checkCommentQuery);
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $existingComment = $result->fetch_assoc();

    
        //  If no record exists, insert a new one
        $insertCommentQuery = "INSERT INTO proposal_comments (proposal_id, comment, seal_and_sign, proposal_status, id) 
                               VALUES (?, ?, ?, ?, ?)";
        $stmt = $connection->prepare($insertCommentQuery);
        $stmt->bind_param("isssi", $proposal_id, $dean_comment, $seal_and_sign, $proposal_status, $user_id);
        $stmt->execute();
    
        

    //  Commit transaction
    $connection->commit();

    // Redirect based on action
if (isset($_POST['approve'])) {
    if (in_array($proposal_status, ['approvedbydean', 'approvedbycqa', 'approvedbyvc'])) {
        echo "<script>alert('Proposal Application Approved successfully.'); window.location.href='approved_proposals.php';</script>";
    } elseif (in_array($proposal_status, [
        'approvedbyqachead',
        'approvedbyugcfinance',
        'approvedbyugchr',
        'approvedbyugcidd',
        'approvedbyugclegal',
        'approvedbyugcacademic',
        'approvedbyugcadmission'
    ])) {
        echo "<script>alert('Proposal Application Approved successfully.'); window.location.href='approved_proposals_ugc.php';</script>";
    } else {
        echo "<script>alert('Unauthorized Role.'); window.history.back();</script>";
    }
}

elseif (isset($_POST['reject'])) {
    if (in_array($proposal_status, ['rejectedbydean', 'rejectedbycqa', 'rejectedbyvc'])) {
        echo "<script>alert('Proposal Application Rejected.'); window.location.href='rejected_proposals.php';</script>";
    } elseif (in_array($proposal_status, [
        'rejectedbyqachead',
        'rejectedbyugcfinance',
        'rejectedbyugchr',
        'rejectedbyugcidd',
        'rejectedbyugclegal',
        'rejectedbyugcacademic',
        'rejectedbyugcadmission'
    ])) {
        echo "<script>alert('Proposal Application Rejected.'); window.location.href='rejected_proposals_ugc.php';</script>";
    } else {
        echo "<script>alert('Unauthorized Role.'); window.history.back();</script>";
    }
}

exit();


    } catch (Exception $e) {
     $connection->rollback();
    die("Error processing request: " . $e->getMessage());
}



    // Check if final approval is reached
if ($proposal_status == "approvedbyugcacademic") {

    // Generate Final PDF (Call a script to create a full PDF)
    exec("php generate_final_proposal.php $proposal_id");
    }



?>
