<?php
/**
 * Renders the Compliance/Non-Compliace radio buttons and comment box for a review item.
 */
function renderReviewControls($identifier, $summary_data, $can_edit,$proposal) {
    $status = $summary_data[$identifier]['status'] ?? 'not_reviewed';
    $comment = $summary_data[$identifier]['comment'] ?? '';

     // Determine if this is a revised proposal being reviewed.
    $is_revised_proposal = isset($proposal['proposal_type']) && strpos($proposal['proposal_type'], 'revised') === 0;

    // Get the user role and normalize it
    $user_role = strtolower(trim($_SESSION['role'] ?? ''));
    $is_standing_committee = ($user_role === 'standard committee');

    //    // --- NEW, FORCEFUL DEBUG BLOCK ---
    // // This will print the debug info for the FIRST item and stop everything.
    // echo "<pre style='background: #fff; color: #000; border: 2px solid red; padding: 15px; margin: 20px; font-family: monospace; font-size: 14px;'>";
    // echo "<strong>DEBUGGING REVIEW CONTROL:</strong><br><hr>";
    // echo "<strong>Identifier:</strong> " . htmlspecialchars($identifier) . "<br>";
    // echo "------------------------------------------<br>";
    // echo "1. <strong>Is Revised Proposal?</strong> : " . ($is_revised_proposal ? 'YES' : 'NO') . " (Raw Type: '" . htmlspecialchars($proposal_type) . "')<br>";
    // echo "2. <strong>Current Status?</strong>      : '" . htmlspecialchars($status) . "'<br>";
    // echo "3. <strong>Is Status 'compliance'?</strong> : " . ($status === 'compliance' ? 'YES' : 'NO') . "<br>";
    // echo "4. <strong>User Role?</strong>           : '" . htmlspecialchars($user_role) . "'<br>";
    // echo "5. <strong>Is Standing Committee?</strong> : " . ($is_standing_committee ? 'YES' : 'NO') . "<br>";
    // echo "6. <strong>Is user NOT SC?</strong>      : " . (!$is_standing_committee ? 'YES' : 'NO') . "<br>";
    // echo "------------------------------------------<br>";
    // $should_lock = ($is_revised_proposal && $status === 'compliance' && !$is_standing_committee);
    // echo "<strong>FINAL DECISION: Should Lock?</strong> : " . ($should_lock ? 'YES' : 'NO') . "<br>";
    // echo "</pre>";
    
    // // Stop the script so we can see this output clearly.
    // die("--- DEBUG HALT ---");
    // // --- END DEBUG BLOCK ---

    // VIEW-ONLY MODE (for other UGC departments)
    if (!$can_edit) {
        if ($status !== 'not_reviewed') {
            $status_class = ($status === 'compliance') ? 'text-success' : 'text-danger';
            $status_text = ucfirst(str_replace('_', ' ', $status));
            echo "<div class='p-2 border-start border-primary border-3 bg-light rounded-end'>";
            echo "<strong>Status:</strong> <span class='$status_class fw-bold'>$status_text</span><br>";
            if (!empty($comment)) {
                echo "<strong>Comment:</strong> " . htmlspecialchars($comment);
            }
            echo "</div>";
        } else {
             echo "<div class='p-2 text-muted'>Not yet reviewed.</div>";
        }
        return;
    }

    // --- EDIT MODE (for TA, Secretary, QAC Head) ---
    $should_lock = ($is_revised_proposal && $status === 'compliance' && !$is_standing_committee);
    // Prepare variables that will be used in the HTML template below.
    $lock_attr = $should_lock ? 'disabled' : '';
    $background_color = $should_lock ? '#e8f5e9' : '#f0f8ff'; // Light green for locked
    $compliance_checked = ($status === 'compliance') ? 'checked' : '';
    $non_compliance_checked = ($status === 'non_compliance') ? 'checked' : '';

    // --- 3. RENDER THE UNIFIED HTML TEMPLATE ---
    // This single block of code renders the controls in all states.
    echo "<div class='review-controls p-2 border rounded' style='background-color: {$background_color};'>";
    
    // If the controls are locked, display a clear message to the user.
    if ($should_lock) {
        echo "<div class='text-success fw-bold small mb-1'>✔ Compliance (Locked for this role)</div>";
    }

    // The radio buttons are always rendered, but are disabled if locked.
    echo "  <div class='form-check form-check-inline'>";
    echo "    <input class='form-check-input' type='radio' name='summary[{$identifier}][status]' id='{$identifier}_compliance' value='compliance' {$compliance_checked} {$lock_attr} required>";
    echo "    <label class='form-check-label' for='{$identifier}_compliance'>Compliance</label>";
    echo "  </div>";
    echo "  <div class='form-check form-check-inline'>";
    echo "    <input class='form-check-input' type='radio' name='summary[{$identifier}][status]' id='{$identifier}_noncompliance' value='non_compliance' {$non_compliance_checked} {$lock_attr}>";
    echo "    <label class='form-check-label' for='{$identifier}_noncompliance'>Non-compliance</label>";
    echo "  </div>";
    
    // The textarea is also disabled if locked.
    echo "  <textarea name='summary[{$identifier}][comment]' class='form-control mt-1' rows='2' placeholder='Comment (Optional)' {$lock_attr}>" . htmlspecialchars($comment) . "</textarea>";
    
    // CRUCIAL: Disabled inputs are NOT submitted with the form.
    // If we locked the controls, we must add hidden inputs to ensure their values are not lost on save.
    if ($should_lock) {
        echo "  <input type='hidden' name='summary[{$identifier}][status]' value='compliance'>";
        echo "  <input type='hidden' name='summary[{$identifier}][comment]' value='" . htmlspecialchars($comment) . "'>";
    }

    echo "</div>";

   

    // // ORIGINAL EDIT MODE (for TA, Secretary, QAC Head)
    // $compliance_checked = ($status === 'compliance') ? 'checked' : '';
    // $non_compliance_checked = ($status === 'non_compliance') ? 'checked' : '';
    
    // echo "<div class='review-controls p-2 border rounded' style='background-color: #f0f8ff;'>";
    // echo "  <div class='form-check form-check-inline'>";
    // echo "    <input class='form-check-input' type='radio' name='summary[{$identifier}][status]' id='{$identifier}_compliance' value='compliance' {$compliance_checked} required>";
    // echo "    <label class='form-check-label' for='{$identifier}_compliance'>compliance</label>";
    // echo "  </div>";
    // echo "  <div class='form-check form-check-inline'>";
    // echo "    <input class='form-check-input' type='radio' name='summary[{$identifier}][status]' id='{$identifier}_noncompliance' value='non_compliance' {$non_compliance_checked}>";
    // echo "    <label class='form-check-label' for='{$identifier}_noncompliance'>Non-compliance</label>";
    // echo "  </div>";
    // echo "  <textarea name='summary[{$identifier}][comment]' class='form-control mt-1' rows='2' placeholder='Comment (Required if Non-compliance)'>" . htmlspecialchars($comment) . "</textarea>";
    // echo "</div>";
}
?>