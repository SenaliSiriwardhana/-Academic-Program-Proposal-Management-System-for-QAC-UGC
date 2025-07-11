<!-- Once you see a wrong status for university_visible_status , you cam fix status using this file -->
<?php 
// require 'databaseconnection.php';
// echo "<h1>Starting University Status Cleanup (V2)...</h1>";
// echo "<pre>"; // For clean output formatting

// // 1. Define the internal department statuses we need to find and replace.
// $internal_department_statuses = [
//     'approvedbyugcfinance', 'rejectedbyugcfinance', 'approvedbyugchr', 'rejectedbyugchr',
//     'approvedbyugcidd', 'rejectedbyugcidd', 'approvedbyugcacademic', 'rejectedbyugcacademic',
//     'approvedbyugcadmission', 'rejectedbyugcadmission', 'approvedbyalldepartments',
//     'approvedbyugclegal' // Added based on your example
// ];
// $placeholders = implode(',', array_fill(0, count($internal_department_statuses), '?'));

// // 2. Select all proposals that currently have a "wrong" university_visible_status.
// $find_query = "SELECT proposal_id, university_visible_status, proposal_type FROM proposals WHERE university_visible_status IN ($placeholders)";
// $stmt_find = $connection->prepare($find_query);
// $stmt_find->bind_param(str_repeat('s', count($internal_department_statuses)), ...$internal_department_statuses);
// $stmt_find->execute();
// $proposals_to_fix = $stmt_find->get_result()->fetch_all(MYSQLI_ASSOC);
// $stmt_find->close();

// if (empty($proposals_to_fix)) {
//     echo "No proposals found with internal department statuses. Nothing to fix!\n";
//     exit;
// }

// echo "Found " . count($proposals_to_fix) . " proposals to fix.\n\n";
// $fixed_count = 0;

// // 3. Define the "hand-off" statuses. This is what the university should see.
// $handoff_statuses = [
//     'approvedbyqachead',
//     'approvedbyqachead_revised',
//     're-signed_vc'
// ];
// $handoff_placeholders = implode(',', array_fill(0, count($handoff_statuses), '?'));


// // 4. Loop through each proposal that needs fixing.
// foreach ($proposals_to_fix as $proposal) {
//     $proposal_id = $proposal['proposal_id'];
//     $wrong_status = $proposal['university_visible_status'];

//     echo "Processing Proposal ID #{$proposal_id} (current wrong status: {$wrong_status})...\n";

//     // 5. For each proposal, find the MOST RECENT "hand-off" status from its history.
//     $history_query = "
//         SELECT proposal_status 
//         FROM proposal_comments 
//         WHERE proposal_id = ? AND proposal_status IN ($handoff_placeholders)
//         ORDER BY `Date` DESC, comment_id DESC
//         LIMIT 1
//     ";
//     $stmt_history = $connection->prepare($history_query);
//     $params = array_merge([$proposal_id], $handoff_statuses);
//     $types = 'i' . str_repeat('s', count($handoff_statuses));
//     $stmt_history->bind_param($types, ...$params);
//     $stmt_history->execute();
//     $history_result = $stmt_history->get_result()->fetch_assoc();
//     $stmt_history->close();

//     $correct_status = $history_result['proposal_status'] ?? null;

//     // --- FALLBACK LOGIC ---
//     // If we couldn't find a hand-off status (e.g., incomplete history),
//     // use the proposal type to make an intelligent guess.
//     if (!$correct_status) {
//         echo "   -> No hand-off status found in history. Using fallback based on proposal type...\n";
//         $proposal_type = $proposal['proposal_type'];
//         if (strpos($proposal_type, 'revised') !== false) {
//              $correct_status = 'approvedbyqachead_revised';
//         } else {
//              $correct_status = 'approvedbyqachead';
//         }
//     }


//     if ($correct_status) {
//         // 6. We found the correct status! Now, update the database.
//         echo "   -> Found correct status: '{$correct_status}'. Updating database...\n";
        
//         $update_query = "UPDATE proposals SET university_visible_status = ? WHERE proposal_id = ?";
//         $stmt_update = $connection->prepare($update_query);
//         $stmt_update->bind_param("si", $correct_status, $proposal_id);
//         if ($stmt_update->execute()) {
//             echo "   -> SUCCESS!\n\n";
//             $fixed_count++;
//         } else {
//             echo "   -> ERROR: Could not update proposal.\n\n";
//         }
//         $stmt_update->close();
        
//     } else {
//         // This case should be rare now with the fallback.
//         echo "   -> CRITICAL WARNING: Could not determine a correct status for this proposal. Skipping.\n\n";
//     }
// }

// echo "</pre>";
// echo "<h2>Cleanup Complete (V2). Fixed {$fixed_count} proposals.</h2>";
// echo "<p>Please verify the data. Once confirmed, you can delete this file (`fix_uni_status_v2.php`).</p>";

?>