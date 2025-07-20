<?php
/**
 * Renders the Compliance/Non-Compliace radio buttons and comment box for a review item.
 */
function renderReviewControls($identifier, $summary_data, $can_edit) {
    $status = $summary_data[$identifier]['status'] ?? 'not_reviewed';
    $comment = $summary_data[$identifier]['comment'] ?? '';

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

    // EDIT MODE (for TA, Secretary, QAC Head)
    $compliance_checked = ($status === 'compliance') ? 'checked' : '';
    $non_compliance_checked = ($status === 'non_compliance') ? 'checked' : '';
    
    echo "<div class='review-controls p-2 border rounded' style='background-color: #f0f8ff;'>";
    echo "  <div class='form-check form-check-inline'>";
    echo "    <input class='form-check-input' type='radio' name='summary[{$identifier}][status]' id='{$identifier}_compliance' value='compliance' {$compliance_checked} required>";
    echo "    <label class='form-check-label' for='{$identifier}_compliance'>compliance</label>";
    echo "  </div>";
    echo "  <div class='form-check form-check-inline'>";
    echo "    <input class='form-check-input' type='radio' name='summary[{$identifier}][status]' id='{$identifier}_noncompliance' value='non_compliance' {$non_compliance_checked}>";
    echo "    <label class='form-check-label' for='{$identifier}_noncompliance'>Non-compliance</label>";
    echo "  </div>";
    echo "  <textarea name='summary[{$identifier}][comment]' class='form-control mt-1' rows='2' placeholder='Comment (Required if Non-compliance)'>" . htmlspecialchars($comment) . "</textarea>";
    echo "</div>";
}
?>