<?php
session_start();
require 'databaseconnection.php'; // Database connection

// echo "<pre>";
// print_r($_POST['summary'] ?? 'summary not set');
// exit();



if (!isset($_SESSION['id'])) {
    die("Access Denied. You are not logged in.");
}

$role = strtolower(trim($_SESSION['role']));
$username = $_SESSION['username'];
$user_id = $_SESSION['id'];

if (!isset($_POST['proposal_id']) || empty($_POST['proposal_id'])) {
    die("Error: Proposal ID is missing.");
}

$proposal_id = $_POST['proposal_id'];
$comment_text = isset($_POST['dean_comment']) ? trim($_POST['dean_comment']) : '';
$new_proposal_status = ''; // This will be the NEW status for the main proposals table
$comment_status = ''; // This is the status we will log in the comments table for this specific action


// START: NEW LOGIC - DEFINE WHO CAN EDIT THE SUMMARY
$can_edit_summary = in_array($role, ["ugc - technical assistant", "ugc - secretary", "head of the qac-ugc department","Standing committee"]);
// END: NEW LOGIC

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
    "standing committee"
];

// Define the 5 parallel review departments and their specific approval statuses
$parallel_review_roles = [
    "ugc - finance department" => "approvedbyugcfinance",
    "ugc - hr department" => "approvedbyugchr",
    "ugc - idd department" => "approvedbyugcidd",
    "ugc - academic department" => "approvedbyugcacademic",
    "ugc - admission department" => "approvedbyugcadmission"
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

// STEP 1: Handle Director's unique actions
if (isset($_POST['director_action'])) {
    $action = $_POST['director_action'];
    $allowed_actions = ['approvedbyqachead', 'approvedbyqachead_revised', 'rejectedbyqachead', 'resignature_request_from_university'];
    if (in_array($action, $allowed_actions)) {
        $new_proposal_status = $comment_status = $action;
    } else {
        die("Invalid director action.");
    }
}
// STEP 2: Handle standard rejections
elseif (isset($_POST['reject'])) {
    // This logic is complex and can be simplified. Using a map is cleaner.
    $rejection_map = [
        "dean" => 'rejectedbydean',
        "cqa director" => 'rejectedbycqa',
        "vice chancellor" => 'rejectedbyvc',
        "ugc - technical assistant" => 'rejectedbyTA',
        "ugc - secretary" => 'rejectedbysecretary',
        "head of the qac-ugc department" => 'rejectedbyqachead', // Already handled above but good for fallback
        "ugc - finance department" => 'rejectedbyugcfinance',
        "ugc - hr department" => 'rejectedbyugchr',
        "ugc - idd department" => 'rejectedbyugcidd',
        "ugc - academic department" => 'rejectedbyugcacademic',
        "ugc - admission department" => 'rejectedbyugcadmission',
        "standing committee" => 'rejectedbyStandardCommittee'
    ];
    $new_proposal_status = $comment_status = $rejection_map[$role] ?? null;
    if (!$new_proposal_status) {
         die("Access Denied: Unauthorized role for rejection.");
    }
}
// STEP 3: Handle all "Approve" clicks
elseif (isset($_POST['approve'])) {

    // --- NEW CODE START: VALIDATION FOR SUMMARY SHEET COMPLETENESS ---
    // This check only applies to users who can edit the summary (TA, Secretary, QAC Head).
    $can_edit_summary = in_array($role, ["ugc - technical assistant", "ugc - secretary", "head of the qac-ugc department","standing committee"]);

    if ($can_edit_summary) {
        // Get the total number of items that should have been reviewed from the hidden input.
        $total_review_items = isset($_POST['total_review_items']) ? (int)$_POST['total_review_items'] : 0;

        // Count how many items were actually submitted with a 'compliance' or 'non_compliance' status.
        $reviewed_items_count = 0;
        if (isset($_POST['summary']) && is_array($_POST['summary'])) {
            foreach ($_POST['summary'] as $item) {
                if (isset($item['status']) && in_array($item['status'], ['compliance', 'non_compliance'])) {
                    $reviewed_items_count++;
                }
            }
        }

        // If the counts don't match, the review is incomplete. Block the approval.
        // We only block if there were items to review in the first place.
        if ($total_review_items > 0 && $reviewed_items_count < $total_review_items) {
            die("<script>alert('Approval Failed: You must review all items in the Summary Sheet (mark as Compliance or Non-compliance) before approving.'); window.history.back();</script>");
        }
    }
    // --- NEW CODE END ---
    
    // Validation for signature and checkbox
    if (!isset($_POST['recommend']) || $_POST['recommend'] !== 'on' || empty($_POST['signature_image'])) {
        die("<script>alert('Please provide your signature and check the check box to approve.'); window.history.back();</script>");
    }

    $stmt_current = $connection->prepare("SELECT status, proposal_type FROM proposals WHERE proposal_id = ?");
    $stmt_current->bind_param("i", $proposal_id);
    $stmt_current->execute();
    $proposal_data = $stmt_current->get_result()->fetch_assoc();
    $current_status = $proposal_data['status'];
    $proposal_type = $proposal_data['proposal_type'];
    $stmt_current->close();

    // --- NEW LOGIC FOR PARALLEL REVIEW ---
    // If the proposal is in the parallel review stage and the user is one of the 5 departments...
    $parallel_queue_statuses = ['approvedbyqachead', 'approvedbyqachead_revised', 're-signed_vc'];
    if (in_array($current_status, $parallel_queue_statuses) && array_key_exists($role, $parallel_review_roles)) {
        
        // The comment status is specific to this department.
        $comment_status = $parallel_review_roles[$role];
        
        // The MAIN proposal status does NOT change yet. We will check for completion later.
        $new_proposal_status = null; // Set to null to indicate no change to proposals table yet

    } else {
        // --- EXISTING STANDARD WORKFLOW LOGIC ---
        switch ($current_status) {
            case 'resignature_request_from_university': if (stripos($role, "dean") !== false) $new_proposal_status = 're-signed_dean'; break;
            case 're-signed_dean': if (stripos($role, "cqa director") !== false) $new_proposal_status = 're-signed_cqa'; break;
            case 're-signed_cqa': if (stripos($role, "vice chancellor") !== false) $new_proposal_status = 're-signed_vc'; break;
            case 'submitted': if (stripos($role, "dean") !== false) $new_proposal_status = 'approvedbydean'; break;
            case 'approvedbydean': if (stripos($role, "cqa director") !== false) $new_proposal_status = 'approvedbycqa'; break;
            case 'approvedbycqa':
                if ($proposal_type === 'initial_proposal' && stripos($role, "vice chancellor") !== false) $new_proposal_status = 'approvedbyvc';
                elseif (strpos($proposal_type, 'revised_') === 0 && strcasecmp($role, "ugc - technical assistant") === 0) $new_proposal_status = 'approvedbyTA';
                break;
            case 'approvedbyvc': if (strcasecmp($role, "ugc - technical assistant") === 0) $new_proposal_status = 'approvedbyTA'; break;
            case 'approvedbyTA': if (strcasecmp($role, "ugc - secretary") === 0) $new_proposal_status = 'approvedbysecretary'; break;
            
            // This is the new status for the Standing Committee to see the proposal
            case 'approvedbyalldepartments': 
                if (strcasecmp($role, "standing committee") === 0) $new_proposal_status = 'approvedbyStandardCommittee';
                break;

            default:
                // Check if the status is one of the "under review by TA" types
                if (strpos($current_status, 'under_review_by_') === 0 && strcasecmp($role, "ugc - technical assistant") === 0) {
                    $new_proposal_status = 'approvedbyTA';
                }
                break;
        }
        $comment_status = $new_proposal_status; // In standard flow, comment status matches the new proposal status
    }

    if (empty($comment_status)) {
        die("Access Denied: Your role ('" . htmlspecialchars($role) . "') cannot approve this proposal in its current state ('" . htmlspecialchars($current_status) . "').");
    }

} else {
    die("<script>alert('Invalid action submitted.'); window.history.back();</script>");
}

// =========================================================================
//  DATABASE TRANSACTION
// =========================================================================

 // Fetch previous status before updating
 $stmt = $connection->prepare("SELECT status FROM proposals WHERE proposal_id = ?");
 $stmt->bind_param("i", $proposal_id);
 $stmt->execute();
 $stmt->bind_result($previous_status);
 $stmt->fetch();
 $stmt->close();

 
//echo "<pre>DEBUG: Updated By User ID = " . ($_SESSION['id'] ?? 'NULL') . "</pre>";
$updated_by = $_SESSION['id']; // Assign logged-in user ID
//$status_for_history = $comment_status;

    // If the main status is null (it's a parallel review), use your default string instead.
    if ($status_for_history === null && $comment_status) {
    $status_for_history = $comment_status;;
    }

 // Log status change in proposal_history table
 $stmt = $connection->prepare("
     INSERT INTO proposal_status_history (proposal_id, updated_by, previous_status, new_status) 
     VALUES (?, ?, ?, ?)
 ");
 $stmt->bind_param("isss", $proposal_id, $updated_by, $previous_status, $status_for_history);
 $stmt->execute();
 $stmt->close();

//  Start database transaction
$connection->begin_transaction();
try {
      // --- NEW CODE BLOCK START: Save Summary Sheet Data ---
    $can_edit_summary = in_array($role, ["ugc - technical assistant", "ugc - secretary", "head of the qac-ugc department","standing committee"]);


       
    // This runs for any valid action (approve/reject) by an authorized user.
    if ($can_edit_summary && isset($_POST['summary']) && is_array($_POST['summary'])) {

       
        
        //Step 1: Delete all old summary records for this proposal to ensure a fresh save.
         $stmt_delete = $connection->prepare("DELETE FROM proposal_summary_sheet WHERE proposal_id = ?");
         $stmt_delete->bind_param("i", $proposal_id);
         $stmt_delete->execute();
         $stmt_delete->close();

       

        // Step 2: Prepare a single insert statement for efficiency.
        $stmt_insert = $connection->prepare(
            "INSERT INTO proposal_summary_sheet (proposal_id, section_identifier, compliance_status, comment, last_updated_by)
            VALUES (?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE 
                compliance_status = VALUES(compliance_status),
                comment = VALUES(comment),
                last_updated_by = VALUES(last_updated_by)"
        );


        // Step 3: Loop through the submitted summary data and insert each item.
        foreach ($_POST['summary'] as $identifier => $data) {
            $status = $data['status'] ?? 'not_reviewed';
            $item_comment = $data['comment'] ?? '';

            // Only save items that have been reviewed (have a status).
            if ($status !== 'not_reviewed') {
                $id_var = $identifier;
                $status_var = $status;
                $comment_var = $item_comment;
                $stmt_insert->bind_param("isssi", $proposal_id, $id_var, $status_var, $comment_var, $user_id);
                $stmt_insert->execute();
            }
        }
        $stmt_insert->close();
    }
    // --- NEW CODE BLOCK END ---


    // --- Save Signature ---
    $signature_image = null;
    if (!empty($_POST['signature_image'])) {
        $image_data = base64_decode(preg_replace('#^data:image/\w+;base64,#i', '', $_POST['signature_image']));
        $signature_file_name = 'signature_' . $user_id . '_' . time() . '.png';
        $signature_file_path = $_SERVER['DOCUMENT_ROOT'] . "/qac_ugc/Proposal_sections/uploads/" . $signature_file_name;
        file_put_contents($signature_file_path, $image_data);
        $signature_image = "http://localhost/qac_ugc/Proposal_sections/uploads/" . $signature_file_name;
    }

    // --- Log the Action in `proposal_comments` ---
    $stmt = $connection->prepare("INSERT INTO proposal_comments (proposal_id, comment, seal_and_sign, proposal_status, id, Time) VALUES (?, ?, ?, ?, ?,NOW())");
    $stmt->bind_param("isssi", $proposal_id, $comment_text, $signature_image, $comment_status, $user_id);
    $stmt->execute();
    $stmt->close();

    // //  Check if a comment already exists for this proposal
    //     $checkCommentQuery = "SELECT comment_id FROM proposal_comments WHERE proposal_id = ?";
    //     $stmt = $connection->prepare($checkCommentQuery);
    //     $stmt->bind_param("i", $proposal_id);
    //     $stmt->execute();
    //     $result = $stmt->get_result();
    //     $existingComment = $result->fetch_assoc();

    
        
    //     //  If no record exists, insert a new one
    //     $insertCommentQuery = "INSERT INTO proposal_comments (proposal_id, comment, seal_and_sign, proposal_status, id) 
    //                            VALUES (?, ?, ?, ?, ?)";
    //     $stmt = $connection->prepare($insertCommentQuery);
    //     $stmt->bind_param("isssi", $proposal_id, $comment_text, $signature_image, $new_proposal_status, $user_id);
	
	//         //  If no record exists, insert a new one
    //     $insertCommentQuery = "INSERT INTO proposal_comments (proposal_id, comment, seal_and_sign, proposal_status, id) 
    //                            VALUES (?, ?, ?, ?, ?)";
    //     $stmt = $connection->prepare($insertCommentQuery);
    //     $stmt->bind_param("isssi", $proposal_id, $comment_text, $signature_image, $new_proposal_status, $user_id);
    //     $stmt->execute();

    // // --- Update the Main `proposals` Table (if needed) --- COMMENTED 12.07.2025 
    // if ($new_proposal_status) {
    //     $stmt = $connection->prepare("UPDATE proposals SET status = ? WHERE proposal_id = ?");
    //     $stmt->bind_param("si", $new_proposal_status, $proposal_id);
    //     $stmt->execute();
    //     $stmt->close();
    // }
    // // COMMENTED 12.07.2025 - CODE BLOCK

    // Define the list of internal UGC department statuses
    $internal_department_statuses = [
        'approvedbyugcfinance', 'rejectedbyugcfinance',
        'approvedbyugchr', 'rejectedbyugchr',
        'approvedbyugcidd', 'rejectedbyugcidd',
        'approvedbyugcacademic', 'rejectedbyugcacademic',
        'approvedbyugcadmission', 'rejectedbyugcadmission',
        'approvedbyalldepartments' // This is the trigger for the next stage
    ];
    
    // This logic only runs if a main status change is happening
    if ($new_proposal_status) {
        
        // Check if the new REAL status is an internal department one
        if (in_array($new_proposal_status, $internal_department_statuses)) {
            // YES, it's internal.
            // The real 'status' gets updated, but 'university_visible_status' stays the same as it was before.
            $stmt_update = $connection->prepare("UPDATE proposals SET status = ?, university_visible_status = ? WHERE proposal_id = ?");
            $stmt_update->bind_param("ssi", $new_proposal_status, $current_uni_status, $proposal_id);

        } else {
            // NO, it's a public status (e.g., approvedbydean, approvedbyStandardCommittee).
            // Both columns are updated to be the same.
            $stmt_update = $connection->prepare("UPDATE proposals SET status = ?, university_visible_status = ? WHERE proposal_id = ?");
            $stmt_update->bind_param("ssi", $new_proposal_status, $new_proposal_status, $proposal_id);
        }
        
        $stmt_update->execute();
        $stmt_update->close();
    }

    


    // // --- CHECK FOR PARALLEL REVIEW COMPLETION ---
    // if ($new_proposal_status === null) { // This means a parallel review action just happened
    //     $dept_statuses = array_values($parallel_review_roles);
    //     $placeholders = implode(',', array_fill(0, count($dept_statuses), '?'));
        
    //     $check_stmt = $connection->prepare(
    //         "SELECT COUNT(DISTINCT proposal_status) FROM proposal_comments 
    //          WHERE proposal_id = ? AND proposal_status IN ($placeholders)"
    //     );
    //     $types = "i" . str_repeat('s', count($dept_statuses));
    //     $check_stmt->bind_param($types, $proposal_id, ...$dept_statuses);
    //     $check_stmt->execute();
    //     $count = $check_stmt->get_result()->fetch_row()[0];
    //     $check_stmt->close();

    //     // If all 5 departments have approved, update the main status
    //     if ($count >= 5) {
    //         $final_status = 'approvedbyalldepartments';
    //         $stmt = $connection->prepare("UPDATE proposals SET status = ? WHERE proposal_id = ?");
    //         $stmt->bind_param("si", $final_status, $proposal_id);
    //         $stmt->execute();
    //         $stmt->close();
    //     }
    // }

    // --- HANDLE PARALLEL REVIEW COMPLETION ---
    // if ($new_proposal_status === null) { 
    //     $dept_statuses = array_values($parallel_review_roles);
    //     $placeholders = implode(',', array_fill(0, count($dept_statuses), '?'));
        
    //     $check_stmt = $connection->prepare(
    //         "SELECT COUNT(DISTINCT proposal_status) FROM proposal_comments 
    //          WHERE proposal_id = ? AND proposal_status IN ($placeholders)"
    //     );
        // --- NEW, CORRECTED LOGIC FOR PARALLEL REVIEW COMPLETION ---
        $final_real_status = $new_proposal_status; 
        if ($new_proposal_status === null && $comment_status) { // A department just acted

            // 1. First, find the timestamp of the most recent "send to departments" trigger event.
            $trigger_statuses = ['approvedbyqachead', 'approvedbyqachead_revised', 're-signed_vc'];
            $trigger_placeholders = implode(',', array_fill(0, count($trigger_statuses), '?'));

            $stmt_trigger_time = $connection->prepare(
                "SELECT MAX(Time) as last_trigger_time 
                FROM proposal_comments 
                WHERE proposal_id = ? AND proposal_status IN ($trigger_placeholders)"
            );
            $params_trigger = array_merge([$proposal_id], $trigger_statuses);
            $types_trigger = 'i' . str_repeat('s', count($trigger_statuses));
            $stmt_trigger_time->bind_param($types_trigger, ...$params_trigger);
            $stmt_trigger_time->execute();
            $trigger_result = $stmt_trigger_time->get_result()->fetch_assoc();
            $last_trigger_time = $trigger_result['last_trigger_time'] ?? '1970-01-01 00:00:00'; // Use a very old date if not found
            $stmt_trigger_time->close();

            // 2. Now, count only the department approvals that happened *after* that timestamp.
            $dept_statuses = array_values($parallel_review_roles);
            $dept_placeholders = implode(',', array_fill(0, count($dept_statuses), '?'));
            
            $check_stmt = $connection->prepare(
                "SELECT COUNT(DISTINCT proposal_status) 
                FROM proposal_comments 
                WHERE proposal_id = ? 
                AND proposal_status IN ($dept_placeholders)
                AND Time >= ?" // The crucial new condition
            );
            
            $params_count = array_merge([$proposal_id], $dept_statuses, [$last_trigger_time]);
            $types_count = 'i' . str_repeat('s', count($dept_statuses)) . 's';
            $check_stmt->bind_param($types_count, ...$params_count);
            $check_stmt->execute();
            $count = $check_stmt->get_result()->fetch_row()[0];
            $check_stmt->close();

            // 3. Set the final status if the count is 5 or more (no change to this part)
            if ($count >= 5) {
                $final_real_status = 'approvedbyalldepartments';
            }
        }
        // --- END OF CORRECTED LOGIC ---

    //     $types = "i" . str_repeat('s', count($dept_statuses));
    //     $check_stmt->bind_param($types, $proposal_id, ...$dept_statuses);
    //     $check_stmt->execute();
    //     $count = $check_stmt->get_result()->fetch_row()[0];
    //     $check_stmt->close();

    //     //$final_real_status = $internal_department_statuses;

    //     if ($count >= 5) {
    //         // The 5th department has approved. Update the REAL status to 'approvedbyalldepartments'.
    //         // The university_visible_status remains what it was before ($current_uni_status).
    //         $final_real_status = 'approvedbyalldepartments';
    //         //$stmt_final_update = $connection->prepare("UPDATE proposals SET status = ?, university_visible_status = ? WHERE proposal_id = ?");
    //         //$stmt_final_update->bind_param("ssi", $final_real_status, $current_uni_status, $proposal_id);
    //         //$stmt_final_update->execute();
    //         //$stmt_final_update->close();
    //     }
    // }
         // --- Step 3: If there is a new real status, update the proposal ---
    if ($final_real_status) {
        
        // Define the list of statuses that are internal to UGC
        $internal_ugc_statuses = [
            'approvedbyugcfinance', 'rejectedbyugcfinance', 'approvedbyugchr', 'rejectedbyugchr',
            'approvedbyugcidd', 'rejectedbyugcidd', 'approvedbyugcacademic', 'rejectedbyugcacademic',
            'approvedbyugcadmission', 'rejectedbyugcadmission', 'approvedbyalldepartments'
        ];

        // Determine the value for 'university_visible_status'
        $university_status_to_set = $final_real_status; // By default, it's the same as the real status

        if (in_array($final_real_status, $internal_ugc_statuses)) {
            // IF the new real status is internal, we must preserve the OLD university status.
            // So, we fetch it from the database before updating.
            $stmt_get_uni_status = $connection->prepare("SELECT university_visible_status FROM proposals WHERE proposal_id = ?");
            $stmt_get_uni_status->bind_param("i", $proposal_id);
            $stmt_get_uni_status->execute();
            $university_status_to_set = $stmt_get_uni_status->get_result()->fetch_assoc()['university_visible_status'];
            $stmt_get_uni_status->close();
        }

        // Now, perform the single, final update with the correct values
        $stmt_update = $connection->prepare("UPDATE proposals SET status = ?, university_visible_status = ? WHERE proposal_id = ?");
        $stmt_update->bind_param("ssi", $final_real_status, $university_status_to_set, $proposal_id);
        $stmt_update->execute();
        $stmt_update->close();
    }

   


    // Commit transaction
    $connection->commit();
    


    $final_status = $new_proposal_status; 

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

//     // Check if final approval is reached
// if ($proposal_status == "approvedbyugcacademic") {

//     // Generate Final PDF (Call a script to create a full PDF)
//     exec("php generate_final_proposal.php $proposal_id");
//     }
?>