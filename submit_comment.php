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


// STEP 1: Handle Director's unique actions first.
if (isset($_POST['director_action'])) {
    $action = $_POST['director_action'];
    $allowed_actions = ['approvedbyqachead','approvedbyqachead_revised', 'rejectedbyqachead', 'resignature_request_from_university'];
    if (in_array($action, $allowed_actions)) {
        $proposal_status = $action;
    } else {
        die("Invalid director action.");
    }
} 
// STEP 2: Handle standard rejections from any role.
elseif (isset($_POST['reject'])) {
    if (stripos($role, "dean") !== false) $proposal_status = 'rejectedbydean';
    elseif (stripos($role, "cqa director") !== false) $proposal_status = 'rejectedbycqa';
    elseif (stripos($role, "vice chancellor") !== false) $proposal_status = 'rejectedbyvc';
    elseif (strcasecmp($role, "ugc - technical assistant") === 0) $proposal_status = 'rejectedbyTA';
    elseif (strcasecmp($role, "ugc - secretary") === 0) $proposal_status = 'rejectedbysecretary';
    elseif (strcasecmp($role, "ugc - finance department") === 0) $proposal_status = 'rejectedbyugcfinance';
    elseif (strcasecmp($role, "ugc - hr department") === 0) $proposal_status = 'rejectedbyugchr';
    elseif (strcasecmp($role, "ugc - idd department") === 0) $proposal_status = 'rejectedbyugcidd';
    elseif (strcasecmp($role, "ugc - academic department") === 0) $proposal_status = 'rejectedbyugcacademic';
    elseif (strcasecmp($role, "ugc - admission department") === 0) $proposal_status = 'rejectedbyugcadmission';
    elseif (strcasecmp($role, "standard committee") === 0) $proposal_status = 'rejectedbyStandardCommittee';
    else { die("Access Denied: Unauthorized role for rejection."); }
}

// STEP 3: Handle all "Approve" clicks, which are context-dependent.
elseif (isset($_POST['approve'])) {
    // Validation for signature and checkbox
    if (!isset($_POST['recommend']) || $_POST['recommend'] !== 'on') {
        die("<script>alert('Please mark the checkbox to confirm your recommendation.'); window.history.back();</script>");
    }
    if (empty($_POST['signature_image'])) {
        die("<script>alert('Please provide your digital signature to approve the proposal.'); window.history.back();</script>");
    }

    // Fetch the proposal's CURRENT status and type to make a smart decision
    $stmt_current = $connection->prepare("SELECT status, proposal_type FROM proposals WHERE proposal_id = ?");
    $stmt_current->bind_param("i", $proposal_id);
    $stmt_current->execute();
    $proposal_data = $stmt_current->get_result()->fetch_assoc();
    $current_status = $proposal_data['status'];
    $proposal_type = $proposal_data['proposal_type'];
    $stmt_current->close();

    // Use a switch statement to handle the different workflows based on the current status.
    switch ($current_status) {
        // --- Re-Signature Workflow ---
        case 'resignature_request_from_university':
            if (stripos($role, "dean") !== false) $proposal_status = 're-signed_dean';
            break;
        case 're-signed_dean':
            if (stripos($role, "cqa director") !== false) $proposal_status = 're-signed_cqa';
            break;
        case 're-signed_cqa':
            if (stripos($role, "vice chancellor") !== false) $proposal_status = 're-signed_vc';
            break;

        // --- Initial & Revised University Workflow ---
        case 'submitted':
            if (stripos($role, "dean") !== false) $proposal_status = 'approvedbydean';
            break;
        case 'approvedbydean':
            if (stripos($role, "cqa director") !== false) $proposal_status = 'approvedbycqa';
            break;
        
        // --- This case handles the split for Initial vs. Revised proposals ---
        case 'approvedbycqa':
            // If it's an initial proposal, it needs VC approval.
            if ($proposal_type === 'initial_proposal' && stripos($role, "vice chancellor") !== false) {
                 $proposal_status = 'approvedbyvc';
            } 
            // If it's a revised proposal, it needs TA approval (skipping VC).
            elseif (strpos($proposal_type, 'revised_') === 0 && strcasecmp($role, "ugc - technical assistant") === 0) {
                 $proposal_status = 'approvedbyTA';
            }
            break;

        // --- UGC Intake Workflow ---
        case 'approvedbyvc': // Can only be an initial proposal
            if (strcasecmp($role, "ugc - technical assistant") === 0) $proposal_status = 'approvedbyTA';
            break;
        case 'approvedbyTA':
             if (strcasecmp($role, "ugc - secretary") === 0) $proposal_status = 'approvedbysecretary';
             break;
        
        // --- Final Committee Parallel Review ---
        case 'approvedbyqachead': // From initial QAC approval
        case 're-signed_vc':      // From re-signature VC approval
        case 'approvedbyqachead_revised':   // From "no signature needed" revised approval

            // For parallel reviews, the main proposal 'status' does not change.
            // We just set a status for the comment itself.
            if (strcasecmp($role, "ugc - finance department") === 0) $proposal_status = 'approvedbyugcfinance';
            elseif (strcasecmp($role, "ugc - hr department") === 0) $proposal_status = 'approvedbyugchr';
            elseif (strcasecmp($role, "ugc - idd department") === 0) $proposal_status = 'approvedbyugcidd';
            elseif (strcasecmp($role, "ugc - admission department") === 0) $proposal_status = 'approvedbyugcadmission';
            elseif (strcasecmp($role, "ugc - academic department") === 0) $proposal_status = 'approvedbyugcacademic';
            break;

        // --- Final Decider ---
        case 'approvedbyugcacademic':
            if (strcasecmp($role, "standard committee") === 0) $proposal_status = 'approvedbyStandardCommittee';
            break;
    }

    if (empty($proposal_status)) {
        die("Access Denied: Your role ('" . htmlspecialchars($role) . "') cannot approve this proposal in its current state ('" . htmlspecialchars($current_status) . "').");
    }

} else {
    // No valid button was clicked.
    die("<script>alert('Invalid action submitted.'); window.history.back();</script>");
}

// =========================================================================


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

    $final_status = $proposal_status; 

if (strpos($final_status, 'approved') !== false) {
    // This handles ALL approval statuses, including 'approvedbyqachead' and 'approvedbyqachead_revised'.
    echo "<script>alert('Proposal Application Approved. The process will continue.'); window.location.href='$approved_page';</script>";
    exit();

} elseif (strpos($final_status, 'rejected') !== false) {
    // This handles ALL rejection statuses, including the Director's 'rejectedbyqachead'.
    echo "<script>alert('Proposal Rejected.'); window.location.href='$rejected_page';</script>";
    exit();

} else {
    // A fallback for any other case, though it shouldn't be reached with the current logic.
    echo "<script>alert('Action processed successfully.'); window.location.href='$approved_page';</script>";
    exit();
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
