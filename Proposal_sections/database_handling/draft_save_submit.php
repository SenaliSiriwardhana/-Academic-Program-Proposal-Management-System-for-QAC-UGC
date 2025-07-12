<?php
session_start();
ob_start();
include __DIR__ . '/../../databaseconnection.php';

// Enable Error Reporting
//error_reporting(E_ALL);
//ini_set('display_errors', 1);

// Get user ID from session
$user_id = $_SESSION['id'] ?? null;
if (!$user_id) {
    die("User not authenticated.");
}

//echo "<pre>DEBUG: User ID = $user_id</pre>";
$proposal_id = $_SESSION['proposal_id'];

// Debugging output
//echo "<pre>DEBUG: User ID = $user_id</pre>";
//echo "<pre>DEBUG: Proposal ID = $proposal_id</pre>";


// Check if the user clicked "Draft Save" or "Submit Final"
$is_draft_save = isset($_POST['saveDraft']);
$is_final_submit = isset($_POST['submitProposal']);

// Retrieve the latest proposal for this user
$stmt = $connection->prepare("SELECT proposal_id, status FROM proposals WHERE proposal_id = ?");
$stmt->bind_param("i", $_SESSION['proposal_id']);
if ($stmt->execute()) {
            //echo "<pre> Draft saved successfully.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
$result = $stmt->get_result();
$proposal = $result->fetch_assoc();
$stmt->close();

// Check if the proposal exists
if (!$proposal) {
    die("No proposal found for the given ID.");
}

// Debugging output
//echo "<pre>DEBUG: Proposal Status = " . $proposal['status'] . "</pre>";

// Find rejected count 
$rejected_statuses = [
    'rejectedbyugcfinance', 
    'rejectedbyugchr',
    'rejectedbyugcidd',
    //'rejectedbyugclegal',
    'rejectedbyugcacademic',
    'rejectedbyugcadmission',
    'rejectedbyqachead',
    'rejectedbyTA',
    'rejectedbysecretary',
    'rejectedbyStandardCommittee'
];

// Count total rejections for this proposal from history
$rejection_count_query = "SELECT COUNT(*) as reject_count 
                         FROM proposal_status_history 
                         WHERE proposal_id = ? 
                         AND new_status IN (" . str_repeat('?,', count($rejected_statuses) - 1) . '?)'; 

$stmt = $connection->prepare($rejection_count_query);
$bind_params = array_merge([$proposal_id], $rejected_statuses);
$stmt->bind_param(str_repeat('s', count($bind_params)), ...$bind_params);
$stmt->execute();
$result = $stmt->get_result();
$rejection_data = $result->fetch_assoc();
$total_rejections = $rejection_data['reject_count'];

$stmt->close();

// Debugging output
//echo "<pre>DEBUG: Total Rejections = $total_rejections</pre>";


    //if ($total_rejections > 3 && $is_final_submit && $_SESSION['is_editing']) {

    if ($total_rejections > 3 && $is_final_submit && $_SESSION['is_editing']) {
            // Check the latest payment record
            $stmt = $connection->prepare("SELECT status, payment_id FROM proposal_payments 
                                          WHERE proposal_id = ? ORDER BY created_at DESC LIMIT 1");
            $stmt->bind_param("i", $proposal_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $payment_status = $result->fetch_assoc();
            $stmt->close();
        
            // Debugging output
            //echo "<pre>DEBUG: Payment Status = ";
            //print_r($payment_status);
            //echo "</pre>";
        
            // If no payment exists, or if it's not 'completed', redirect to payment page
            if (!$payment_status || $payment_status['status'] !== 'completed') {
                echo "<pre>DEBUG: Redirecting to payment page due to missing or pending payment...</pre>";
                header("Location: /qac_ugc/process_payment.php");
                exit();
            }
        
            // If payment is completed but not yet used, mark it as used
            if ($payment_status['status'] === 'completed') {
                $payment_id = $payment_status['payment_id'];
                $stmt = $connection->prepare("UPDATE proposal_payments SET status='completed_used' WHERE payment_id = ?");
                $stmt->bind_param("i", $payment_id);
                if ($stmt->execute()) {
                    //echo "<pre>DEBUG: Payment status updated to 'completed_used'.</pre>";
                } else {
                    //echo "<pre>ERROR: Failed to update payment status. SQL Error: " . $stmt->error . "</pre>";
                }
                $stmt->close();
            }
        }
        
    

if ($proposal) {
    $status = $proposal['status'];

    //echo "<pre>DEBUG: Found Proposal ID = $proposal_id, Status = $status</pre>";

    if ($is_draft_save) {
        // Update status from "Fresh" to "Draft"
        $stmt = $connection->prepare("UPDATE proposals SET status = 'draft', university_visible_status = 'draft' WHERE proposal_id = ?");
        $stmt->bind_param("i", $proposal_id);
        if ($stmt->execute()) {
           //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
           echo "<script>alert('Draft Save Successfully.');window.location.href='/qac_ugc/new_proposal.php';</script>";
        } else {
           //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
           echo "<script>alert('Draft save failed.');</script>";
        };
        $stmt->close();

    } elseif ($is_final_submit /*&& $status === "draft"|| $status === "fresh"*/) {
        // Final submission: Only allow if all sections are complete

        //  START: LOGIC TO DETERMINE AND SET PROPOSAL_TYPE
        // =================================================================================

        //echo "<h3>--- DEBUGGING PROPOSAL TYPE LOGIC ---</h3>";

        // 1. Fetch the entire rejection history from the proposal_status_history table.
        $history_query = "SELECT new_status FROM proposal_status_history WHERE proposal_id = ? ORDER BY history_id ASC";
        $stmt_history = $connection->prepare($history_query);
        $stmt_history->bind_param("i", $proposal_id);
        $stmt_history->execute();
        $history_result = $stmt_history->get_result();

        $has_st_rejection = false;
        $has_qac_rejection = false;

        $qac_rejection_statuses = ['rejectedbyqachead', 'rejectedbystandardcommittee']; // Initializing the array correctly

            // echo "<b>Checking for these QAC rejection statuses:</b><pre>";
            // print_r($qac_rejection_statuses);
            // echo "</pre>";

            // echo "<b>Proposal's Status History from Database:</b><ul>";

        while ($row = $history_result->fetch_assoc()) {
            $status_in_history = $row['new_status'];
            //  echo "<li>Found status: '{$status_in_history}'</li>";

            // Check if it was ever rejected by the Standard Committee
            if ($status_in_history === 'rejectedbyStandardCommittee') {
                $has_st_rejection = true;
            }

            // Check if it was ever rejected by any other UGC entity (using the list from payment logic)
            if (in_array($status_in_history, $qac_rejection_statuses)) {
                $has_qac_rejection = true;
            }
        }
        // echo "</ul>";
        $stmt_history->close();

        // echo "<b>Result of history check:</b><br>";
        // echo "Has QAC Rejection? " . ($has_qac_rejection ? '<b>YES</b>' : 'NO') . "<br>";
        // echo "Has ST Rejection? " . ($has_st_rejection ? '<b>YES</b>' : 'NO') . "<br><hr>";


        // 2. Fetch the CURRENT proposal_type from the `proposals` table.
        $current_type_query = "SELECT proposal_type FROM proposals WHERE proposal_id = ?";
        $stmt_current_type = $connection->prepare($current_type_query);
        $stmt_current_type->bind_param("i", $proposal_id);
        $stmt_current_type->execute();
        $current_type_result = $stmt_current_type->get_result()->fetch_assoc();
        $current_type = $current_type_result['proposal_type'] ?? 'initial_proposal';
        $stmt_current_type->close();

          //echo "<b>Current proposal_type from DB is:</b> '{$current_type}'<br><hr>";

        // 3. Determine the NEW proposal_type based on the rejection history.
        $new_proposal_type = 'initial_proposal'; // Default

        // This logic triggers on RESUBMISSION after a rejection.
        if ($has_qac_rejection) {
            if ($has_st_rejection) {
                // If the standing committee ever rejected it, this resubmission is of type 'revised_ST'.
                $new_proposal_type = 'revised_ST';
            } else {
                // It was rejected by another UGC entity...
                if ($current_type === 'initial_proposal' || $current_type === 'revised_ST') {
                    // This is the first revision after an initial submission or an ST revision.
                    $new_proposal_type = 'revised_1';
                } elseif (strpos($current_type, 'revised_') === 0) {
                    // It was already a numbered revision, so we increment it.
                    $number = (int) str_replace('revised_', '', $current_type);
                    $new_proposal_type = 'revised_' . ($number + 1);
                }
            }
        }

        // echo "<b>Final Calculated proposal_type will be:</b> <b style='color:red; font-size: 1.2em;'>'{$new_proposal_type}'</b><br><hr>";
        // echo "<p>If the final type is 'initial_proposal' but you expected 'revised_1', it means 'Has QAC Rejection?' was NO. Check for typos between the history statuses and the QAC rejection list.</p>";

        // If there are no UGC rejections in its history, it remains 'initial_proposal'.

        // =================================================================================
        //  END: LOGIC TO DETERMINE AND SET PROPOSAL_TYPE
        // =================================================================================


            // Get current timestamp
            $submitted_at = date('Y-m-d H:i:s');
        
            $stmt = $connection->prepare("UPDATE proposals SET status = 'submitted', university_visible_status = 'submitted', proposal_type = ?, submitted_at = ? WHERE proposal_id = ?");
            $stmt->bind_param("ssi",$new_proposal_type, $submitted_at, $proposal_id,);
            if ($stmt->execute()) {
           //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully submitted.</pre>";
           echo "<script>alert('Proposal successfully submitted.');
           window.location.href='/qac_ugc/submitted_proposals.php';</script>";
        } else {
           //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
           echo "<script>alert('Proposal submission failed.');</script>";
        };
            $stmt->close();
        } else {
            //echo "<pre>ERROR: Please complete all sections before submitting.</pre>";
            echo "<script>alert('Please complete all sections before submitting.');</script>";
        }
        
   

// Ensure section records exist before updating
function ensure_section_exists($connection, $proposal_id, $section_table) {
    $stmt = $connection->prepare("SELECT COUNT(*) FROM $section_table WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $count = 0;
    $stmt->bind_result($count);
    $stmt->fetch();
    $stmt->close();

    
    if ($count == 0) {
        $stmt = $connection->prepare("INSERT INTO $section_table (proposal_id) VALUES (?)");
        $stmt->bind_param("i", $proposal_id);
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }
}



// Define sections array
$sections = [
    'general_info', 'program_entity', 'degree_details', 'program_structure', 
    'program_content', 'program_delivery', 'assessment_rules', 'panel_of_teachers', 
    'reviewers_report', 'compliance_check', 'resource_requirements'
];

// Create section records if missing
foreach ($sections as $section) {

    if(isset($_SESSION[$section]) && is_array($_SESSION[$section])) {
        ensure_section_exists($connection, $proposal_id, "proposal_$section");
    }
}

// Handle general info section from session data
if (isset($_SESSION['general_info'])) {
    $stmt = $connection->prepare("UPDATE proposal_general_info SET 
        degree_name_english = ?, 
        degree_name_sinhala = ?, 
        degree_name_tamil = ?, 
        qualification_name_english = ?, 
        qualification_name_sinhala = ?, 
        qualification_name_tamil = ?, 
        abbreviated_qualification = ? 
        WHERE proposal_id = ?");
    
    $stmt->bind_param("sssssssi", 
        $_SESSION['general_info']['degree_name_english'],
        $_SESSION['general_info']['degree_name_sinhala'],
        $_SESSION['general_info']['degree_name_tamil'],
        $_SESSION['general_info']['qualification_name_english'],
        $_SESSION['general_info']['qualification_name_sinhala'],
        $_SESSION['general_info']['qualification_name_tamil'],
        $_SESSION['general_info']['abbreviated_qualification'],
        $proposal_id
    );
    if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $stmt->close();
}

// Handle program entity section
if (isset($_SESSION['program_entity'])) {
    // First update the program entity table
    $stmt = $connection->prepare("UPDATE proposal_program_entity SET 
        university = ?,
        faculty = ?,
        department = ?
        WHERE proposal_id = ?");
    
    $stmt->bind_param("sssi", 
        $_SESSION['program_entity']['university'],
        $_SESSION['program_entity']['faculty'],
        $_SESSION['program_entity']['department'],
        $proposal_id
    );
    if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $stmt->close();

    // Get the program_entity_id
    $stmt = $connection->prepare("SELECT program_entity_id FROM proposal_program_entity WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $program_entity_id = $row['program_entity_id'];
    $stmt->close();

    // Handle mandate availability records
    $mandate_types = [
        'corporate_plan' => 'Corporate / Strategic Plan of the University',
        'action_plan' => 'Action Plan of the Faculty/Institute/Center/Unit',
        'faculty_approval' => 'Faculty Approval',
        'senate_approval' => 'Senate Approval',
        'council_approval' => 'Council Approval'
    ];

    foreach ($mandate_types as $key => $type) {
        // Check if record exists
        $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_mandate_availability 
            WHERE proposal_id = ? AND mandate_availability_type = ?");
        $stmt->bind_param("is", $proposal_id, $type);
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();

        if ($count == 0) {
            // Insert new record if it doesn't exist
            $stmt = $connection->prepare("INSERT INTO proposal_mandate_availability 
                (proposal_id, program_entity_id, mandate_availability_type, reference_no, date_of_approval, evidence) 
                VALUES (?, ?, ?, ?, ?, ?)");
            
            $evidence_path = $_SESSION['program_entity']["evidence_{$key}"] ?? '';
            //$evidence_path = str_replace('/qac_ugc/uploads/', 'uploads/', $evidence_path);
            // Ensure the path is correctly formatted
            $evidence_path = str_replace('//', '/', $evidence_path); // Remove accidental double slashes
            if (strpos($evidence_path, "/qac_ugc/uploads/") === 0) {
                $evidence_path = str_replace('/qac_ugc/uploads/', 'uploads/', $evidence_path);
            }
        

            $stmt->bind_param("iissss", 
                $proposal_id, 
                $program_entity_id, 
                $type,
                $_SESSION['program_entity']["ref_{$key}"],
                $_SESSION['program_entity']["date_{$key}"],
                $evidence_path
            );
        } else {

            // Retrieve the existing evidence path from session
            $evidence_path = $_SESSION['program_entity']["evidence_{$key}"] ?? '';

            // Step 1: Trim unnecessary slashes
            $evidence_path = str_replace('//', '/', $evidence_path);

            // Step 2: Prevent multiple '/qac_ugc/' occurrences
            // This ensures '/qac_ugc/' appears only once at the beginning
            $evidence_path = preg_replace("#(/qac_ugc/)+#", "/qac_ugc/", $evidence_path);

            // Step 3: Ensure the correct base path
        if (strpos($evidence_path, "/qac_ugc/uploads/") !== false) {
            // Convert '/qac_ugc/uploads/' to 'uploads/' ONLY if it's wrongly formatted
            $evidence_path = str_replace("/qac_ugc/uploads/", "uploads/", $evidence_path);
        }

            // Final check to prevent double base path insertion
        if (substr_count($evidence_path, "/qac_ugc/") > 1) {
            // Keep only the last correct part
            $evidence_path = preg_replace("#^(.*?/qac_ugc/)(qac_ugc/)+#", "/qac_ugc/", $evidence_path);
        }
            
            // Update existing record
            $stmt = $connection->prepare("UPDATE proposal_mandate_availability SET 
                reference_no = ?,
                date_of_approval = ?,
                evidence = COALESCE(?, evidence)
                WHERE proposal_id = ? AND mandate_availability_type = ?");
            
            
            $stmt->bind_param("sssss", 
                $_SESSION['program_entity']["ref_{$key}"],
                $_SESSION['program_entity']["date_{$key}"],
                $evidence_path,
                $proposal_id,
                $type
            );
        }
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }
}
// Handle degree details section
if (isset($_SESSION['degree_details'])) {
    // Convert values to appropriate types
    $medium_instruction = isset($_SESSION['degree_details']['medium_of_instruction']) ? 
        implode(',', array_filter($_SESSION['degree_details']['medium_of_instruction'])) : '';
    
    $slqf_level = isset($_SESSION['degree_details']['slqf_level'])?
        implode(',', array_filter($_SESSION['degree_details']['slqf_level'])) : '';

    $slqf_filled = isset($_SESSION['degree_details']['slqf_filled'])?
        implode(',', array_filter($_SESSION['degree_details']['slqf_filled'])) : '';

    // Handle subject benchmark file path
    $subject_benchmark_path = $_SESSION['degree_details']['subject_benchmark'] ?? '';
    if (!empty($subject_benchmark_path)) {
        $subject_benchmark_path = str_replace('/qac_ugc/uploads/', 'uploads/', $subject_benchmark_path);
    }


    // Handle degree details justification file path
    $degree_details_justification_path = $_SESSION['degree_details']['degree_details_justification'] ?? '';
    if (!empty($degree_details_justification_path)) {
        $degree_details_justification_path = str_replace('/qac_ugc/uploads/', 'uploads/', $degree_details_justification_path);
    }

    // Handle degree details objective file path
    $degree_details_objective_path = $_SESSION['degree_details']['degree_details_objective'] ?? '';
    if (!empty($degree_details_objective_path)) {
        $degree_details_objective_path = str_replace('/qac_ugc/uploads/', 'uploads/', $degree_details_objective_path);
    }

    $stmt = $connection->prepare("UPDATE proposal_degree_details SET 
        background_to_program = ?,
        mandate_faculty = ?,
        faculty_status = ?,
        student_intake = ?,
        staff_cadres = ?,
        educational_facilities = ?,
        common_facilities = ?,
        program_benefits = ?,
        eligibility_req = ?,
        indicate_program = ?,
        admission_process = ?,
        other_criteria = ?,
        intake = ?,
        degree_type = ?,
        duration = ?,
        coursework_credits = ?,
        thesis_credits = ?,
        total_credits = ?,
        medium_of_instruction = ?,
        subject_benchmark = CASE WHEN ? != '' THEN ? ELSE subject_benchmark END,
        slqf_level = ?,
        slqf_filled = ?,
        rec_in_review_report = ?,
        degree_details_justification = CASE WHEN ? != '' THEN ? ELSE degree_details_justification END,
        degree_details_objective = CASE WHEN ? != '' THEN ? ELSE degree_details_objective END
        WHERE proposal_id = ?");
    
    $stmt->bind_param("ssssssssssssssssssssssssssssi", 
        $_SESSION['degree_details']['background_to_program'],
        $_SESSION['degree_details']['mandate_faculty'],
        $_SESSION['degree_details']['faculty_status'],
        $_SESSION['degree_details']['student_intake'],
        $_SESSION['degree_details']['staff_cadres'],
        $_SESSION['degree_details']['educational_facilities'],
        $_SESSION['degree_details']['common_facilities'],
        $_SESSION['degree_details']['program_benefits'],
        $_SESSION['degree_details']['eligibility_req'],
        $_SESSION['degree_details']['indicate_program'],
        $_SESSION['degree_details']['admission_process'],
        $_SESSION['degree_details']['other_criteria'],
        $_SESSION['degree_details']['intake'],
        $_SESSION['degree_details']['degree_type'],
        $_SESSION['degree_details']['duration'],
        $_SESSION['degree_details']['coursework_credits'],
        $_SESSION['degree_details']['thesis_credits'],
        $_SESSION['degree_details']['total_credits'],
        $medium_instruction,
        $subject_benchmark_path,
        $subject_benchmark_path,
        $slqf_level,
        $slqf_filled,
        $_SESSION['degree_details']['rec_in_review_report'],
        $degree_details_justification_path,
        $degree_details_justification_path,
        $degree_details_objective_path,
        $degree_details_objective_path,
        $proposal_id
    );
    if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $stmt->close();
    //Handle grades received table
    
        if (isset($_SESSION['degree_details']['program_reviews']) && is_array($_SESSION['degree_details']['program_reviews'])) {
            // First, get the degree_id from proposal_degree_details
            $stmt = $connection->prepare("SELECT degree_id FROM proposal_degree_details WHERE proposal_id = ?");
            $stmt->bind_param("i", $proposal_id);
            if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            $degree_id = $row['degree_id'];
            $stmt->close();
    
            // Delete existing records
            $stmt = $connection->prepare("DELETE FROM proposal_grades_received WHERE degree_id = ?");
            $stmt->bind_param("i", $degree_id);
            if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
            $stmt->close();
    
            // Insert new records for each program review
            $stmt = $connection->prepare("INSERT INTO proposal_grades_received 
                (proposal_id, degree_id, program_name, program_year, grade) VALUES (?, ?, ?, ?, ?)");
            
            foreach ($_SESSION['degree_details']['program_reviews'] as $program) {
                if (!empty($program['program_name'])) {
                    $stmt->bind_param("iisss", 
                        $proposal_id,
                        $degree_id,
                        $program['program_name'],
                        $program['program_year'],
                        $program['program_grade']
                    );
                    if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
                }
            }
            $stmt->close();
        }
    }
    // Handle program structure section
    if (isset($_SESSION['program_structure']) && is_array($_SESSION['program_structure'])) {
        ensure_section_exists($connection, $proposal_id, "proposal_program_structure");

        
        // Add debug output at the start
        //echo "<pre>";
        //echo "Session Program Structure Data:\n";
        //print_r($_SESSION['program_structure']);
        //echo "</pre>";

        // Fetch existing records from the database for the current proposal
            $existingModules = [];
            $stmt = $connection->prepare("SELECT module_code FROM proposal_program_structure WHERE proposal_id = ?");
            $stmt->bind_param("i", $proposal_id);
            if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
            $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $existingModules[] = $row['module_code'];
        }
            $stmt->close();

        // Get module codes from the UI session data
            $sessionModules = array_column($_SESSION['program_structure'], 'module_code');

        // Find modules that exist in DB but are missing in the session (meaning they were deleted)
            $modulesToDelete = array_diff($existingModules, $sessionModules);

        // Debug Output
       // echo "<pre>";
       //echo "Existing Modules in DB: ";
        //print_r($existingModules);
        //echo "Modules in UI Session: ";
        //print_r($sessionModules);
        //echo "Modules to Delete: ";
        //print_r($modulesToDelete);
        //echo "</pre>";

        // Delete removed modules from the database
        if (!empty($modulesToDelete)) {
            $placeholders = implode(",", array_fill(0, count($modulesToDelete), "?"));
            $query = "DELETE FROM proposal_program_structure WHERE proposal_id = ? AND module_code IN ($placeholders)";
            $stmt = $connection->prepare($query);

            // Create an array with proposal_id first, followed by module codes
            $types = str_repeat("s", count($modulesToDelete)); // All are strings
            $stmt->bind_param("i" . $types, $proposal_id, ...$modulesToDelete);
            
            if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
            $stmt->close();
        }

    
        foreach ($_SESSION['program_structure'] as $module) {
            if (!empty($module['module_code'])) {
                //Debug module data
                //echo "<pre>";
                //echo "Processing Module:\n";
                //print_r($module);
                //echo "Module Type: " . (isset($module['module_type']) ? $module['module_type'] : 'not set') . "\n";
                //echo "</pre>";
                
                // Fix checkbox and select values
                $qualifier1 = isset($module['qualifier1_related']) && $module['qualifier1_related'] === 'Yes' ? 'Yes' : 'No';
                $qualifier2 = isset($module['qualifier2_related']) && $module['qualifier2_related'] === 'Yes' ? 'Yes' : 'No';
                $module_status = $module['module_status'] ?? 'Compulsory';
                
                // Update to use the new field name 'module_type'
                //$module_type = $module['module_type'] ?? 'Existing';

                // Convert module_type (array) to a comma-separated string
                // Fix: Ensure `module_type` is properly retrieved
            if (isset($module['module_type'])) {
                if (is_array($module['module_type'])) {
                    $module_type = implode(", ", array_map('trim', $module['module_type'])); // Ensure clean format
                } else {
                    $module_type = trim($module['module_type']); // Trim any spaces
                }
            } else {
                    $module_type = 'Existing'; // Default value if not set
            }


               // echo "<pre>";
                //echo "Final module_type value being used: " . $module_type . "\n";
                //echo "</pre>";
                
                // Check if module exists
                $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_program_structure 
                    WHERE proposal_id = ? AND module_code = ?");
                $stmt->bind_param("is", $proposal_id, $module['module_code']);
                if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
                $stmt->bind_result($count);
                $stmt->fetch();
                $stmt->close();

              

                //echo "<pre>";
                //echo "Module exists check - Count: " . $count . "\n";
                //echo "Proposal ID: " . $proposal_id . "\n";
                //echo "Module Code: " . $module['module_code'] . "\n";
                //echo "</pre>";

                if ($count == 0) {
                    // Insert new module
                    $query = "INSERT INTO proposal_program_structure 
                        (proposal_id, semester, module_code, module_name, credit_value, module_status, module_type, qualifier1_related, qualifier2_related) 
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    
                    //echo "<pre>";
                    //echo "Executing INSERT query for module_code: " . $module['module_code'] . "\n";
                    //echo "</pre>";
                    
                    $stmt = $connection->prepare($query);
                    $stmt->bind_param("ssssissss", 
                        $proposal_id,
                        $module['semester'],
                        $module['module_code'],
                        $module['module_name'],
                        $module['credit_value'],
                        $module_status,
                        $module_type,
                        $qualifier1,
                        $qualifier2
                    );
                } else {
                    // Update existing module
                    $query = "UPDATE proposal_program_structure SET 
                        semester = ?,
                        module_name = ?,
                        credit_value = ?,
                        module_status = ?,
                        module_type = ?,
                        qualifier1_related = ?,
                        qualifier2_related = ?
                        WHERE proposal_id = ? AND module_code = ?";
                    
                    //echo "<pre>";
                    //echo "Executing UPDATE query for module_code: " . $module['module_code'] . "\n";
                    //echo "Values being bound:\n";
                    //echo "semester: " . $module['semester'] . "\n";
                    //echo "module_name: " . $module['module_name'] . "\n";
                    //echo "credit_value: " . $module['credit_value'] . "\n";
                    //echo "module_status: " . $module_status . "\n";
                    //echo "module_type: " . $module_type . "\n";
                    //echo "qualifier1: " . $qualifier1 . "\n";
                    //echo "qualifier2: " . $qualifier2 . "\n";
                    //echo "proposal_id: " . $proposal_id . "\n";
                    //echo "module_code: " . $module['module_code'] . "\n";
                    //echo "</pre>";
                    
                    $stmt = $connection->prepare($query);
                    $stmt->bind_param("ssissssss", 
                        $module['semester'],
                        $module['module_name'],
                        $module['credit_value'],
                        $module_status,
                        $module_type,
                        $qualifier1,
                        $qualifier2,
                        $proposal_id,
                        $module['module_code']
                    );
                }
                
                if ($stmt->execute()) {
           //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
                $stmt->close();
            }
        }
    }
   
    
    
    

    // Handle program delivery section
    if (isset($_SESSION['program_delivery'])) {
        ensure_section_exists($connection, $proposal_id, "proposal_program_delivery");
    
        $stmt = $connection->prepare("UPDATE proposal_program_delivery SET 
            program_delivery_description = ?
            WHERE proposal_id = ?");
    
        $stmt->bind_param("si", 
            $_SESSION['program_delivery']['program_delivery_description'],
            $proposal_id
        );
    
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }

    // Handle assessment rules section
    if (isset($_SESSION['assessment_rules'])) {
        ensure_section_exists($connection, $proposal_id, "proposal_assessment_rules");
    
        $stmt = $connection->prepare("UPDATE proposal_assessment_rules SET
            formative_summative = ?,
            grading_scheme = ?, 
            gpa_calculation = ?, 
            semester_contribution = ?, 
            inplant_training = ?, 
            repeat_exams = ?, 
            degree_requirements = ?, 
            class_requirements = ?
            WHERE proposal_id = ?");

        $stmt->bind_param("ssssssssi", 
            $_SESSION['assessment_rules']['formative_summative'],
            $_SESSION['assessment_rules']['grading_scheme'],
            $_SESSION['assessment_rules']['gpa_calculation'],
            $_SESSION['assessment_rules']['semester_contribution'],
            $_SESSION['assessment_rules']['inplant_training'],
            $_SESSION['assessment_rules']['repeat_exams'],
            $_SESSION['assessment_rules']['degree_requirements'],
            $_SESSION['assessment_rules']['class_requirements'],
            $proposal_id
        );
        if ($stmt->execute()) {
           //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }

    


// Handle reviewers report section
if (isset($_SESSION['reviewers_report'])) {
    // Define aspects
    $aspects = [
        'acceptability' => 'Acceptability of the Background and the Justification',
        'relevance' => 'Relevance of proposed degree program to Society',
        'entry_qualification' => 'Entry Qualification and Admission Process',
        'structure' => 'Program Structure',
        'content' => 'Program Content',
        'methods' => 'Teaching Learning Methods',
        'procedure' => 'Assessment Strategy/Procedure',
        'availability' => 'Resource Availability - Physical',
        'qualifications' => 'Qualifications of Panel of Teachers (Internal & External)',
        'recommended_reading' => 'Recommended Reading',
        'recommendation' => 'Recommendation (a, b, or c)'
    ];

    foreach ($aspects as $key => $aspect) {
        $main_key = "main_{$key}";
        $fallback_key = "fallback_{$key}";

        $main_comment = $_SESSION['reviewers_report'][$main_key] ?? "";
        $fallback_comment = $_SESSION['reviewers_report'][$fallback_key] ?? "";

        // Check if report exists
        $stmt = $connection->prepare("SELECT report_id FROM proposal_reviewers_report WHERE proposal_id = ? AND aspect = ?");
        $stmt->bind_param("is", $proposal_id, $aspect);
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $stmt->close();

        $report_id = $row['report_id'] ?? null;

        if ($report_id) {
            // Update existing record
            $stmt = $connection->prepare("UPDATE proposal_reviewers_report SET 
                main_proposal_comment = ?, 
                fallback_qualification_comment = ? 
                WHERE proposal_id = ? AND aspect = ?");
            $stmt->bind_param("ssis", $main_comment, $fallback_comment, $proposal_id, $aspect);
            if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        } else {
            // Insert new record and get generated report_id
            $stmt = $connection->prepare("INSERT INTO proposal_reviewers_report 
                (proposal_id, aspect, main_proposal_comment, fallback_qualification_comment) 
                VALUES (?, ?, ?, ?)");
            $stmt->bind_param("isss", $proposal_id, $aspect, $main_comment, $fallback_comment);
            if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
            $report_id = $stmt->insert_id; // Auto-generated report_id
        }
        $stmt->close();
    }

    // Handle reviewers details (Ensuring both reviewers are inserted)
    for ($i = 1; $i <= 2; $i++) {
        $name = $_SESSION['reviewers_report']["reviewer{$i}_name"] ?? "";
        $designation = $_SESSION['reviewers_report']["reviewer{$i}_designation"] ?? "";
        $qualification = $_SESSION['reviewers_report']["reviewer{$i}_qualification"] ?? "";
        $signature = $_SESSION['reviewers_report']["reviewer{$i}_signature"] ?? "";
        $date = $_SESSION['reviewers_report']["reviewer{$i}_date"] ?? "";

        // Skip empty reviewer entries
        if (empty($name) && empty($designation) && empty($qualification) && empty($signature) && empty($date)) {
            continue;
        }

        // Check if reviewer already exists
        $stmt = $connection->prepare("SELECT reviewer_id FROM proposal_reviewer_details 
            WHERE proposal_id = ? AND report_id = ? AND name = ?");
        $stmt->bind_param("iis", $proposal_id, $report_id, $name);
        if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $stmt->close();

        if ($row) {
            // Update existing reviewer
            $stmt = $connection->prepare("UPDATE proposal_reviewer_details SET 
                designation = ?, 
                qualification = ?, 
                signature = ?, 
                date = ? 
                WHERE proposal_id = ? AND report_id = ? AND reviewer_id = ?");
            $stmt->bind_param("ssssiii", $designation, $qualification, $signature, $date, $proposal_id, $report_id, $row['reviewer_id']);
        } else {
            // Insert new reviewer (NO `reviewer_id`, let MySQL auto-generate)
            $stmt = $connection->prepare("INSERT INTO proposal_reviewer_details 
                (proposal_id, report_id, name, designation, qualification, signature, date) 
                VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("iisssss", $proposal_id, $report_id, $name, $designation, $qualification, $signature, $date);
        }
        if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }
}





if (isset($_SESSION['compliance_check'])) {
    // Retrieve session data safely
    $resources_commence = $_SESSION['compliance_check']['resources_commence'] ?? "";
    $fallback_options = $_SESSION['compliance_check']['fallback_options'] ?? "";
    
    // Convert fallback_qualification (array) to a comma-separated string
    $fallback_qualification = $_SESSION['compliance_check']['fallback_qualification'] ?? [];
    if (is_array($fallback_qualification)) {
        $fallback_qualification = implode(", ", $fallback_qualification);
    } else {
        $fallback_qualification = "";
    }

    $collaboration = $_SESSION['compliance_check']['collaboration'] ?? "";
    $collaboration_details = $_SESSION['compliance_check']['collaboration_details'] ?? "";
    $access_facilities = $_SESSION['compliance_check']['access_facilities'] ?? "";
    $professional_membership = $_SESSION['compliance_check']['professional_membership'] ?? "";

    // Handle attachments (convert paths)
    $fallback_qualification_path = $_SESSION['compliance_check']['fallback_attachment'] ?? "";
    $collaboration_details_path = $_SESSION['compliance_check']['collaboration_attachment'] ?? "";
    $access_details_path = $_SESSION['compliance_check']['access_facilities_attachment'] ?? "";
    $membership_path = $_SESSION['compliance_check']['membership_attachment'] ?? "";

    // Check if a record already exists
    $stmt = $connection->prepare("SELECT compliance_check_id FROM proposal_compliance_check WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $stmt->close();

    $compliance_check_id = $row['compliance_check_id'] ?? null;

    if ($compliance_check_id) {
        // Update existing record
        $stmt = $connection->prepare("UPDATE proposal_compliance_check SET 
            resources_commence = ?, 
            fallback_options = ?, 
            fallback_qualification = ?, 
            fallback_attachment = ?, 
            collaboration = ?, 
            collaboration_details = ?, 
            collaboration_attachment = ?, 
            access_facilities = ?, 
            access_facilities_attachment = ?, 
            professional_membership = ?, 
            membership_attachment = ?
            WHERE proposal_id = ?");

        $stmt->bind_param("sssssssssssi", 
            $resources_commence, 
            $fallback_options, 
            $fallback_qualification, 
            $fallback_qualification_path, 
            $collaboration, 
            $collaboration_details, 
            $collaboration_details_path, 
            $access_facilities, 
            $access_details_path,
            $professional_membership, 
            $membership_path,
            $proposal_id
        );
    } else {
        // Insert new record
        $stmt = $connection->prepare("INSERT INTO proposal_compliance_check 
            (proposal_id, resources_commence, fallback_options, fallback_qualification, fallback_attachment, collaboration, collaboration_details, collaboration_attachment, access_facilities, access_facilities_attachment, professional_membership, membership_attachment) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

        $stmt->bind_param("isssssssssss", 
            $proposal_id, 
            $resources_commence, 
            $fallback_options, 
            $fallback_qualification, 
            $fallback_qualification_path, 
            $collaboration, 
            $collaboration_details, 
            $collaboration_details_path, 
            $access_facilities, 
            $access_details_path,
            $professional_membership,
            $membership_path
        );
    }
    if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    
    $stmt->close();
}


// Handle program content section
if (isset($_SESSION['program_content']) && is_array($_SESSION['program_content'])) {
    ensure_section_exists($connection, $proposal_id, "proposal_program_content");

    // Fetch existing records from the database for the current proposal
    $existingModules = [];
    $stmt = $connection->prepare("SELECT module_code FROM proposal_program_content WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $existingModules[] = $row['module_code'];
    }
    $stmt->close();

    // Get module codes from the session
    $sessionModules = array_column($_SESSION['program_content'], 'module_code');

    // Find modules to delete
    $modulesToDelete = array_diff($existingModules, $sessionModules);

    // Delete removed modules
    if (!empty($modulesToDelete)) {
        $placeholders = implode(",", array_fill(0, count($modulesToDelete), "?"));
        $query = "DELETE FROM proposal_program_content WHERE proposal_id = ? AND module_code IN ($placeholders)";
        $stmt = $connection->prepare($query);
        $types = str_repeat("s", count($modulesToDelete));
        $stmt->bind_param("i" . $types, $proposal_id, ...$modulesToDelete);
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }

    // Process each module
    foreach ($_SESSION['program_content'] as $content) {
        if (!empty($content['module_code'])) {
            // Validate and set default values
            $module_code = $content['module_code'];
            $semester = $content['semester'] ?? '';
            $module_name = $content['module_name'] ?? '';
            $credit_value = $content['credit_value'] ?? 0;
            $core_optional = $content['core_optional'] ?? 'Core';
            $lecture_hours = $content['lecture_hours'] ?? 0;
            $practical_hours = $content['practical_hours'] ?? 0;
            $independent_hours = $content['independent_hours'] ?? 0;
            $learning_outcomes = $content['learning_outcomes'] ?? '';
            $module_content = $content['module_content'] ?? '';
            $teaching_methods = $content['teaching_methods'] ?? '';
            $continuous_assessment_percentage = $content['continuous_assessment_percentage'] ?? 0;
            $final_assessment_percentage = $content['final_assessment_percentage'] ?? 0;
            $recommended_reading = $content['recommended_reading'] ?? '';

            // Check if module exists
            $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_program_content 
                WHERE proposal_id = ? AND module_code = ?");
            $stmt->bind_param("is", $proposal_id, $module_code);
            if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
            $stmt->bind_result($count);
            $stmt->fetch();
            $stmt->close();

            if ($count > 0) {
                // Update existing module
                $stmt = $connection->prepare("UPDATE proposal_program_content SET 
                    semester = ?, module_name = ?, credit_value = ?, core_optional = ?,
                    lecture_hours = ?, practical_hours = ?, independent_hours = ?,
                    learning_outcomes = ?, module_content = ?, teaching_methods = ?,
                    continuous_assessment_percentage = ?, final_assessment_percentage = ?,
                    recommended_reading = ?
                    WHERE proposal_id = ? AND module_code = ?");

                $stmt->bind_param("ssissssssssssis",
                    $semester, $module_name, $credit_value, $core_optional,
                    $lecture_hours, $practical_hours, $independent_hours,
                    $learning_outcomes, $module_content, $teaching_methods,
                    $continuous_assessment_percentage, $final_assessment_percentage,
                    $recommended_reading, $proposal_id, $module_code
                );
            } else {
                // Insert new module
                $stmt = $connection->prepare("INSERT INTO proposal_program_content 
                    (proposal_id, semester, module_code, module_name, credit_value, core_optional,
                    lecture_hours, practical_hours, independent_hours, learning_outcomes,
                    module_content, teaching_methods, continuous_assessment_percentage,
                    final_assessment_percentage, recommended_reading)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                $stmt->bind_param("isssississsssss",
                    $proposal_id, $semester, $module_code, $module_name, $credit_value,
                    $core_optional, $lecture_hours, $practical_hours, $independent_hours,
                    $learning_outcomes, $module_content, $teaching_methods,
                    $continuous_assessment_percentage, $final_assessment_percentage,
                    $recommended_reading
                );
            }
            if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
            $stmt->close();
        }
    }
}





    // Handle panel_of_teachers section
if (isset($_SESSION['panel_of_teachers']) && is_array($_SESSION['panel_of_teachers'])) {
    ensure_section_exists($connection, $proposal_id, "proposal_panel_of_teachers");

    


    // Fetch existing records from the database for the current proposal
    $existingModules = [];
    $stmt = $connection->prepare("SELECT teacher_id FROM proposal_panel_of_teachers WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $existingModules[] = $row['teacher_id'];
    }
    $stmt->close();

    // Get module codes from the UI session data
    $sessionModules = array_column($_SESSION['panel_of_teachers'], 'teacher_id');

    // Find modules that exist in DB but are missing in the session (meaning they were deleted)
    $modulesToDelete = array_diff($existingModules, $sessionModules);

    // Delete removed rows from the database
    if (!empty($modulesToDelete)) {
        // Generate the correct number of placeholders for SQL query
        $placeholders = implode(",", array_fill(0, count($modulesToDelete), "?"));
        $query = "DELETE FROM proposal_panel_of_teachers WHERE proposal_id = ? AND teacher_id IN ($placeholders)";
        $stmt = $connection->prepare($query);

        // Dynamically build the parameter types string
        $types = str_repeat("i", count($modulesToDelete)); // All are integers
        $params = array_merge([$proposal_id], $modulesToDelete);

        // Use call_user_func_array for dynamic parameters
        $stmt->bind_param("i" . $types, ...$params);
        if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }

    // Delete removed modules from the database
    if (!empty($modulesToDelete)) {
        $placeholders = implode(",", array_fill(0, count($modulesToDelete), "?"));
        $query = "DELETE FROM proposal_panel_of_teachers WHERE proposal_id = ? AND teacher_id IN ($placeholders)";
        $stmt = $connection->prepare($query);

        // Create an array with proposal_id first, followed by module codes
        $types = str_repeat("s", count($modulesToDelete)); // All are strings
        $stmt->bind_param("i" . $types, $proposal_id, ...$modulesToDelete);
        
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }

    // Clear all existing panel_of_teachers records for this proposal to avoid duplicates
        $stmt = $connection->prepare("DELETE FROM proposal_panel_of_teachers WHERE proposal_id = ?");
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $stmt->close();

    foreach ($_SESSION['panel_of_teachers'] as $module) {
        // Ensure required fields are properly accessed
        $lecturer_name = !empty($module['lecturer_name']) ? $module['lecturer_name'] : 'UNKNOWN'; 
        $designation = !empty($module['designation']) ? $module['designation'] : 'Unnamed Module';  
        $internal_ug_hours = isset($module['internal_ug_hours']) && is_numeric($module['internal_ug_hours']) ? $module['internal_ug_hours'] : 0;  // Fixed field name
        $internal_pg_hours = isset($module['internal_pg_hours']) && is_numeric($module['internal_pg_hours']) ? $module['internal_pg_hours'] : 0;
        $external_ug_hours = isset($module['external_ug_hours']) && is_numeric($module['external_ug_hours']) ? $module['external_ug_hours'] : 0;  // Fixed field name
        $external_pg_hours = isset($module['external_pg_hours']) && is_numeric($module['external_pg_hours']) ? $module['external_pg_hours'] : 0;
        $proposed_program_hours = isset($module['proposed_program_hours']) && is_numeric($module['proposed_program_hours']) ? $module['proposed_program_hours'] : 0;  // Fixed field name
        $total_hours = isset($module['total_hours']) && is_numeric($module['total_hours']) ? $module['total_hours'] : 0;
        
   
        // Debugging: Check validated values
        //echo "<pre>";
        //echo "Validated Data for Module:\n";
        //echo "Module Code: " . $lecturer_name . "\n";
       // echo "Module Name: " . $designation . "\n";
        //echo "Lecture Hours: " . $internal_ug_hours . "\n";
        //echo "Practical Hours: " . $internal_pg_hours . "\n";
        //echo "Independent Hours: " . $external_ug_hours . "\n";
       // echo "Learning Outcomes: " . $external_pg_hours . "\n";
        //echo "" .$proposed_program_hours . "\n";
        //echo "" .$total_hours . "\n";
        
       // echo "</pre>";
    
        // Check if module exists
        $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_panel_of_teachers
        WHERE proposal_id = ? AND teacher_id= ?");
        $stmt->bind_param("ii", $proposal_id, $teacher_id);
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();

        if ($count > 0) {
            // Update existing module
            $stmt = $connection->prepare("UPDATE proposal_panel_of_teachers SET 
                lecturer_name =?, designation =?, internal_ug_hours =?, internal_pg_hours =?, 
                external_ug_hours =?, external_pg_hours =?, proposed_program_hours =?, total_hours =?
                WHERE proposal_id = ? and teacher_id = ?");

            $stmt->bind_param("ssiiiiiii", 
            $lecturer_name,
            $designation,
            $internal_ug_hours,
            $internal_pg_hours,
            $external_ug_hours,
            $external_pg_hours,
            $proposed_program_hours,
            $total_hours,
            $proposal_id,
            
        );
            
        } else {
    
            $stmt = $connection->prepare("INSERT INTO proposal_panel_of_teachers 
            (proposal_id, lecturer_name, designation, internal_ug_hours, internal_pg_hours, external_ug_hours, external_pg_hours, proposed_program_hours, total_hours) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

            $stmt->bind_param("issiiiiii", 
                $proposal_id,
                $lecturer_name,
                $designation,
                $internal_ug_hours,
                $internal_pg_hours,
                $external_ug_hours,
                $external_pg_hours,
                $proposed_program_hours,
                $total_hours,
);

        
        // Debugging: Show final query and bound values before executing
        //echo "<pre>";

        //echo "Validated Data for Module:\n";
        //echo "Module Code: " . $lecturer_name . "\n";
        //echo "Module Name: " . $designation . "\n";
        //echo "Lecture Hours: " . $internal_ug_hours . "\n";
        //echo "Practical Hours: " . $internal_pg_hours . "\n";
        //echo "Independent Hours: " . $external_ug_hours . "\n";
        //echo "Learning Outcomes: " . $external_pg_hours . "\n";
        //echo "" .$proposed_program_hours . "\n";
        //echo "" .$total_hours . "\n";
        
        //echo "</pre>";
    
        if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }
    
}

// Handle Physical Resources
if (isset($_SESSION['resource_requirements'])) {

    // Debug: Print session data
    //echo "<pre>Session Data:\n";
    //print_r($_SESSION['resource_requirements']);
    //echo "</pre>";

    // First, ensure we have a record in proposal_resource_requirements
    $stmt = $connection->prepare("SELECT resource_requirement_id FROM proposal_resource_requirements WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $stmt->close();

    if (!$row) {
        // Create a new resource requirements record if it doesn't exist
        $stmt = $connection->prepare("INSERT INTO proposal_resource_requirements (proposal_id) VALUES (?)");
        $stmt->bind_param("i", $proposal_id);
        if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $resource_requirement_id = $stmt->insert_id;
        $stmt->close();
    } else {
        $resource_requirement_id = $row['resource_requirement_id'];
    }

    // Verify if the resource_requirement_id exists in proposal_resource_requirements
    $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_resource_requirements WHERE resource_requirement_id = ?");
    $stmt->bind_param("i", $resource_requirement_id);
    if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
    $stmt->bind_result($exists);
    $stmt->fetch();
    $stmt->close();

    if ($exists == 0) {
        echo "<pre>ERROR: The resource_requirement_id $resource_requirement_id does not exist in proposal_resource_requirements!</pre>";
        exit; // Stop execution if resource_requirement_id is invalid
    }

    //echo "<pre>Resource Requirement ID: $resource_requirement_id</pre>";

    // Define physical resource types
    $physical_resources = [
        "Land extent (Acre/Hectare)", "Office Space", "No. of Lecture Theatres",
        "No. of Laboratories", "No. of Computers with Internet Facilities",
        "Reading Rooms/Halls", "Staff Common Rooms/Amenities",
        "Student Common Rooms/Amenities", "Other"
    ];

    foreach ($physical_resources as $resource) {
        $key = strtolower(str_replace([' ', '/', '.'], '_', $resource));

        $existing = $_SESSION['resource_requirements'][$key.'_existing'] ?? '';
        $year1 = $_SESSION['resource_requirements'][$key.'_year1'] ?? '';
        $year2 = $_SESSION['resource_requirements'][$key.'_year2'] ?? '';
        $year3 = $_SESSION['resource_requirements'][$key.'_year3'] ?? '';
        $year4 = $_SESSION['resource_requirements'][$key.'_year4'] ?? '';

        // Check if record exists
        $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_physical_resource WHERE proposal_id = ? AND physical_type = ?");
        $stmt->bind_param("is", $proposal_id, $resource);
        if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();

        if ($count > 0) {
            // Update existing record
            $stmt = $connection->prepare("UPDATE proposal_physical_resource SET 
                existing_amount = ?, year1 = ?, year2 = ?, year3 = ?, year4 = ?
                WHERE proposal_id = ? AND physical_type = ?");
            $stmt->bind_param("sssssis", 
                $existing, $year1, $year2, $year3, $year4, $proposal_id, $resource);
        } else {
            // Insert new record
            $stmt = $connection->prepare("INSERT INTO proposal_physical_resource 
                (proposal_id, resource_requirement_id, physical_type, existing_amount, year1, year2, year3, year4) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("iissssss", 
                $proposal_id, $resource_requirement_id, $resource, $existing, $year1, $year2, $year3, $year4);
        }
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }

    // Define human resource types
    $human_resources = ["Lecturers", "Instructors/Demonstrators", "Technical Grades",
        "Management Assistants", "Minor Staff"];

    foreach ($human_resources as $staff_type) {
        $key = strtolower(str_replace([' ', '/'], '_', $staff_type));
        
        $year1 = $_SESSION['resource_requirements'][$key.'_year1'] ?? '';
        $year2 = $_SESSION['resource_requirements'][$key.'_year2'] ?? '';
        $year3 = $_SESSION['resource_requirements'][$key.'_year3'] ?? '';
        $year4 = $_SESSION['resource_requirements'][$key.'_year4'] ?? '';

        // Check if record exists
        $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_human_resource WHERE proposal_id = ? AND staff_type = ?");
        $stmt->bind_param("is", $proposal_id, $staff_type);
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
            //echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();

        if ($count > 0) {
            // Update existing record
            $stmt = $connection->prepare("UPDATE proposal_human_resource SET 
                year1 = ?, year2 = ?, year3 = ?, year4 = ?, resource_requirement_id = ?
                WHERE proposal_id = ? AND staff_type = ?");
            $stmt->bind_param("sssssis", 
                $year1, $year2, $year3, $year4, $resource_requirement_id, $proposal_id, $staff_type);
        } else {
            // Insert new record
            $stmt = $connection->prepare("INSERT INTO proposal_human_resource 
                (proposal_id, staff_type, year1, year2, year3, year4, resource_requirement_id) 
                VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("isssssi", 
                $proposal_id, $staff_type, $year1, $year2, $year3, $year4, $resource_requirement_id);
        }
        if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }

    // Step 4: Insert Financial Resources (Fixing Foreign Key Issue)
    $financial_types = ["Capital Expenditure", "Recurrent Expenditure"];

    foreach ($financial_types as $financial_type) {
        $key = strtolower(str_replace(' ', '_', $financial_type));
        
        $year1 = $_SESSION['resource_requirements'][$key.'_year1'] ?? '';
        $year2 = $_SESSION['resource_requirements'][$key.'_year2'] ?? '';
        $year3 = $_SESSION['resource_requirements'][$key.'_year3'] ?? '';
        $year4 = $_SESSION['resource_requirements'][$key.'_year4'] ?? '';

        // Check if record exists
        $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_financial_resource WHERE proposal_id = ? AND financial_type = ?");
        $stmt->bind_param("is", $proposal_id, $financial_type);
        if ($stmt->execute()) {
            //echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();

        if ($count > 0) {
            $stmt = $connection->prepare("UPDATE proposal_financial_resource SET 
                year1 = ?, year2 = ?, year3 = ?, year4 = ?, resource_requirement_id = ?
                WHERE proposal_id = ? AND financial_type = ?");
            $stmt->bind_param("sssssis", 
                $year1, $year2, $year3, $year4, $resource_requirement_id, $proposal_id, $financial_type);
        } else {
            $stmt = $connection->prepare("INSERT INTO proposal_financial_resource 
                (proposal_id, financial_type, year1, year2, year3, year4, resource_requirement_id) 
                VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("isssssi", 
                $proposal_id, $financial_type, $year1, $year2, $year3, $year4, $resource_requirement_id);
        }
        if ($stmt->execute()) {
           // echo "<pre>DEBUG: Proposal ID $proposal_id status successfully updated to Draft.</pre>";
        } else {
           // echo "<pre>ERROR: Failed to update status. SQL Error: " . $stmt->error . "</pre>";
        };
        $stmt->close();
    }
}
}
}

?>

    


