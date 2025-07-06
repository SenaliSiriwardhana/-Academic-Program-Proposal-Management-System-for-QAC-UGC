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


$role = strtolower(trim($_SESSION['role'])); // Get user role

// Check if user is from UGC (including Standard Committee)
$ugc_roles = [
    "ugc - technical assistant",
    "ugc - secretary",
    "head of the qac-ugc department",
    "ugc - finance department",
    "ugc - hr department",
    "ugc - idd department",
    "ugc - academic department",
    "ugc - admission department",
    "standard committee"
];

// If the user's role is in the UGC list, set the UGC pages for redirection
if (in_array($role, $ugc_roles)) {
    $approved_page = 'approved_proposals_ugc.php';
    $rejected_page = 'rejected_proposals_ugc.php';
} else {
    // If the user is from a university (non-UGC roles), use standard pages
    $approved_page = 'approved_proposals.php';
    $rejected_page = 'rejected_proposals.php';
}

//  Check if the role is Dean, VC, or CQA Director and assign the correct status
if (isset($_POST['approve'])) {
    // Ensure the checkbox is checked for approval
    if (!isset($_POST['recommend']) || $_POST['recommend'] !== 'on') {
        die("<script>alert('Please mark the checkbox to confirm your recommendation and correctness of the proposal information.'); window.history.back();</script>");
    }

    // Ensure the digital signature checkbox is checked for approval
    if (empty($_POST['signature_image'])) {
        echo "<script>alert('Please provide your digital signature to approve the proposal.'); window.history.back();</script>";
        exit();
    }

    if (strpos($role, "dean/rector/director") !== false) {
        $proposal_status = 'approvedbydean'; // Dean approves
    } elseif (strpos($role, "vice chancellor") !== false || strpos($role, "vc") !== false) {
        $proposal_status = 'approvedbyvc'; // VC approves
    } elseif (strcasecmp(trim($role), "CQA Director") === 0) { //  Case-insensitive check for CQA
        $proposal_status = 'approvedbycqa'; // CQA approves
    } elseif (strcasecmp(trim($role), "UGC - Technical Assistant") === 0) { //  Case-insensitive check for TA
        $proposal_status = 'approvedbyTA'; // TA approves
    } elseif (strcasecmp(trim($role), "Secretary") === 0) { //  Case-insensitive check for Secretary
        $proposal_status = 'approvedbysecretary'; // Secretary approves
    } elseif (strcasecmp(trim($role), "Head of the qac-ugc Department") === 0) { //  Case-insensitive check for CQA
        $proposal_status = 'approvedbyqachead'; // UGC-HEAD approves
    }elseif (strcasecmp(trim($role), "UGC - Finance Department") === 0) { //  Case-insensitive check for Finance
        $proposal_status = 'approvedbyugcfinance'; // UGC-Finance approves
    }elseif (strcasecmp(trim($role), "UGC - HR Department") === 0) { //  Case-insensitive check for HR
        $proposal_status = 'approvedbyugchr'; // UGC-HR approves
    }elseif (strcasecmp(trim($role), "UGC - IDD Department") === 0) { //  Case-insensitive check for IDD
        $proposal_status = 'approvedbyugcidd'; // UGC-IDD approves
    //}elseif (strcasecmp(trim($role), "UGC - Legal Department") === 0) { //  Case-insensitive check for Legal
        //$proposal_status = 'approvedbyugclegal'; // UGC-Legal approves
    }elseif (strcasecmp(trim($role), "UGC - Academic Department") === 0) { //  Case-insensitive check for Academic
        $proposal_status = 'approvedbyugcacademic'; // UGC-Academic approves
    }elseif (strcasecmp(trim($role), "UGC - Admission Department") === 0) { //  Case-insensitive check for Admission
        $proposal_status = 'approvedbyugcadmission'; // UGC-Admission approves
    }elseif (strcasecmp(trim($role), "Standard Committee") === 0) { //  Case-insensitive check for Standard Committee
        $proposal_status = 'approvedbyStandardCommittee'; // Standard Committee approves
    
    } else {
        die("Access Denied: Unauthorized role.");
    }
} elseif (isset($_POST['reject'])) {
    if (strpos($role, "dean/rector/director") !== false) {
        $proposal_status = 'rejectedbydean'; // Dean rejects
    } elseif (strpos($role, "vice chancellor") !== false || strpos($role, "vc") !== false) {
        $proposal_status = 'rejectedbyvc'; // VC rejects
    } elseif (strcasecmp(trim($role), "CQA Director") === 0) { //  CQA Director rejection
        $proposal_status = 'rejectedbycqa'; // CQA rejects
    } elseif (strcasecmp(trim($role), "UGC - Technical Assistant") === 0) { //  Case-insensitive check for TA
        $proposal_status = 'rejectedbyTA'; // TA rejects
    } elseif (strcasecmp(trim($role), "Secretary") === 0) { //  Case-insensitive check for Secretary
        $proposal_status = 'rejectedbysecretary'; // Secretary rejects
    } elseif (strcasecmp(trim($role), "Head of the qac-ugc Department") === 0) { //  Case-insensitive check for CQA
        $proposal_status = 'rejectedbyqachead'; // UGC-HEAD rejectss
    }elseif (strcasecmp(trim($role), "UGC - Finance Department") === 0) { //  Case-insensitive check for Finance
        $proposal_status = 'rejectedbyugcfinance'; // UGC-Finance rejects
    }elseif (strcasecmp(trim($role), "UGC - HR Department") === 0) { //  Case-insensitive check for HR
        $proposal_status = 'rejectedbyugchr'; // UGC-HR rejects
    }elseif (strcasecmp(trim($role), "UGC - IDD Department") === 0) { //  Case-insensitive check for IDD
        $proposal_status = 'rejectedbyugcidd'; // UGC-IDD rejects
    //}elseif (strcasecmp(trim($role), "UGC - Legal Department") === 0) { //  Case-insensitive check for Legal
        //$proposal_status = 'rejectedbyugclegal'; // UGC-Legal rejects
    }elseif (strcasecmp(trim($role), "UGC - Academic Department") === 0) { //  Case-insensitive check for Academic
        $proposal_status = 'rejectedbyugcacademic'; // UGC-Academic rejects
    }elseif (strcasecmp(trim($role), "UGC - Admission Department") === 0) { //  Case-insensitive check for Admission
        $proposal_status = 'rejectedbyugcadmission'; // UGC-Admission rejects
     }elseif (strcasecmp(trim($role), "Standard Committee") === 0) { //  Case-insensitive check for Standard Committee
        $proposal_status = 'rejectedbyStandardCommittee'; // Standard Committee rejects
    } else {
        die("Access Denied: Unauthorized role.");
    }
} else {
    echo "<script>alert('Invalid action. Please check the proposal information or try again.'); window.history.back();</script>";
  
    
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

    // Save the signature image (base64 to image)
        $signature_data = $_POST['signature_image'];
        $signature_image = null;

    // Check if base64 data is provided
    if (!empty($signature_data)) {
        // Remove the base64 prefix
        $image_data = base64_decode(str_replace('data:image/png;base64,', '', $signature_data));

        // Save the image to the server
        $signature_file_name = 'signature_' . time() . '.png';
        $signature_file_path = $_SERVER['DOCUMENT_ROOT'] . "/qac_ugc/Proposal_sections/uploads/" . $signature_file_name;

        // Save the image
        file_put_contents($signature_file_path, $image_data);

        // Store the image URL in the database
        $signature_image = "http://localhost/qac_ugc/Proposal_sections/uploads/" . $signature_file_name;
    }

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
        $stmt->bind_param("isssi", $proposal_id, $dean_comment, $signature_image, $proposal_status, $user_id);
        $stmt->execute();
    
        

    //  Commit transaction
    $connection->commit();

    // Redirect based on action
        // Redirect based on action
    if (isset($_POST['approve'])) {
        echo "<script>alert('Proposal Application Approved successfully.'); window.location.href='$approved_page';</script>";
    } elseif (isset($_POST['reject'])) {
        echo "<script>alert('Proposal Application Rejected.'); window.location.href='$rejected_page';</script>";
    }

    
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
