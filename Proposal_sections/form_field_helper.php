<?php
/**
 * This file provides helper functions to lock form elements based on the UGC review summary.
 */

// Load summary data once to be used by all functions in this file
$summary_data = $_SESSION['summary_data'] ?? [];

// ===================================================================
// ==          FUNCTIONS FOR INDIVIDUAL FIELDS (like <input>)       ==
// ===================================================================

/**
 * Generates the 'readonly' attribute string if a single field should be locked.
 * A field is UNLOCKED only if it is 'non_compliance'. It is LOCKED otherwise.
 *
 * @param string $identifier The unique identifier for the field.
 * @return string 'readonly style="background-color: #e9ecef;"' or an empty string.
 */
function get_lock_status_attr($identifier) {
    global $summary_data;
    if (empty($summary_data)) return ''; // Not a revision.
    
    if (isset($summary_data[$identifier]) && $summary_data[$identifier]['status'] === 'non_compliance') {
        return ''; // UNLOCK: Return empty string.
    }
    
    return 'readonly style="background-color: #e9ecef;"'; // LOCK: Return attributes.
}

/**
 * Renders the feedback message (UGC comment or 'compliance' status) for a single field.
 *
 * @param string $identifier The unique identifier for the field.
 */
function render_field_feedback($identifier) {
    global $summary_data;
    if (empty($summary_data)) return; // No feedback if not a revision.

    if (isset($summary_data[$identifier])) {
        if ($summary_data[$identifier]['status'] === 'non_compliance') {
            $comment = $summary_data[$identifier]['comment'] ?? '';
            if (!empty($comment)) {
                echo "<div class='form-text text-danger'><strong>UGC Comment:</strong> " . htmlspecialchars($comment) . "</div>";
            }
        } else {
            echo "<div class='form-text text-success fw-bold'>✔ compliance</div>";
        }
    }
}


// ===================================================================
// == FUNCTIONS FOR FIELD GROUPS (like <table> wrapped in <fieldset>) ==
// ===================================================================

/**
 * Generates the 'disabled' attribute string for a fieldset if a component (like a table) should be locked.
 * A component is UNLOCKED only if it is 'non_compliance'. It is LOCKED otherwise.
 *
 * @param string $identifier The unique identifier for the entire component (e.g., 'table.mandate_availability').
 * @return string Either 'disabled' or an empty string.
 */
function get_group_lock_attr($identifier) {
    global $summary_data;
    if (empty($summary_data)) return ''; // Not a revision.

    if (isset($summary_data[$identifier]) && $summary_data[$identifier]['status'] === 'non_compliance') {
        return ''; // UNLOCK: Return empty string.
    }

    return 'disabled'; // LOCK: Return 'disabled'.
}

/**
 * Renders the feedback message for an entire component (like a table).
 *
 * @param string $identifier The unique identifier for the component.
 */
function render_component_feedback($identifier) {
    global $summary_data;
    if (empty($summary_data)) return; // No feedback if not a revision.
    
    if (isset($summary_data[$identifier])) {
        if ($summary_data[$identifier]['status'] === 'non_compliance') {
            $comment = $summary_data[$identifier]['comment'] ?? '';
            if (!empty($comment)) {
                echo "<div class='alert alert-danger mt-2'><strong>This section requires revision.</strong><br>UGC Comment: " . htmlspecialchars($comment) . "</div>";
            }
        } else {
            echo "<div class='alert alert-success mt-2'><strong>✔ compliance:</strong> This section is approved and cannot be edited.</div>";
        }
    }
}


?>