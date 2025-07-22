<?php
session_start();

require 'databaseconnection.php';

// INITIALIZE ALL VARIABLES
// This prevents "undefined variable" errors in all cases.

$proposal_status = '';
$show_revision_summary = false;
$summary_data_for_view = [];
$_SESSION['is_draft_revision_mode'] = false; // Default to not being a revision

// --- MASTER FUNCTION is for summary sheet locking feature for selected draft versions---
function isDraftRevisionMode($proposal_id, $current_status, $connection) {
    // RULE 1: If the current status is an explicit rejection, it's a revision.
    $rejection_statuses = ['rejectedbyqachead', 'rejectedbyTA', 'rejectedbysecretary','rejectedbyStandardCommittee'];
    if (in_array($current_status, $rejection_statuses)) {
        return true;
    }

    // RULE 2: If the current status is 'draft', we must check its history.
    if ($current_status === 'draft') {
        // Find the most recent, non-draft status for this proposal in its history.
        $stmt = $connection->prepare(
            "SELECT new_status 
             FROM proposal_status_history 
             WHERE proposal_id = ? 
             ORDER BY updated_at DESC 
             LIMIT 1"
        );
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($row = $result->fetch_assoc()) {
            $last_meaningful_status = $row['new_status'];
            // If the last real action was a rejection, then this draft is a revision.
            if (in_array($last_meaningful_status, $rejection_statuses)) {
                return true;
            }
        }
    }

    // If neither of the above conditions are met, it's not a revision.
    return false;
}


$isEditing = isset($_GET['edit']) ||  false;
$initialFetch = isset($_GET['initial']);


if (isset($_GET['order_id'])) {
    $orderID = $_GET['order_id'];
    $status = 'completed';
    $stmt = $connection->prepare("UPDATE proposal_payments SET status = ? WHERE order_id = ?");
    $stmt->bind_param("ss", $status, $orderID);
    $stmt->execute();

    if ($stmt->execute()) {
        echo "<script>alert('Payment has been successfull. Submit Again!');</script>";
    } else {
        echo "<script>alert('Payment Failed. Try Again.');</script>";
    }
}

// Define the upload directory
$uploadDir = __DIR__ . '/../uploads/';  // Adjust path if necessary
$uploadUrl = '/qac_ugc/Proposal_sections/uploads/';

function deleteUploadedFiles($section) {
    global $uploadDir, $uploadUrl;

    if (!empty($_SESSION[$section])) {
        foreach ($_SESSION[$section] as $key => $fileUrl) {
            if (is_string($fileUrl) && strpos($fileUrl, $uploadUrl) === 0) { // Ensure it's a file path
                $filePath = str_replace($uploadUrl, $uploadDir, $fileUrl); // Convert URL to file path
                if (file_exists($filePath)) {
                    unlink($filePath); // Delete the file
                }
            }
        }
    }
}



// --- MODIFICATION START ---
// This block handles session setup for editing vs. new proposals.
if ($isEditing) {
    // We are editing an existing proposal.
    $_SESSION['proposal_id'] = $_GET['proposal_id'];
    $_SESSION['is_editing'] = 1;
    $_SESSION['editing_proposal_id'] = $_GET['proposal_id'];

    if ($initialFetch) {
        // ... your code to unset and delete files for a fresh edit ...
        unset($_SESSION['summary_data']); // Also clear old summary data on initial fetch
    }
} else {
    // THIS IS FOR A NEW PROPOSAL. CLEAR EVERYTHING.
    unset($_SESSION['is_editing']);
    unset($_SESSION['editing_proposal_id']);
    // CRUCIAL FIX: Clear the summary data from any previous session.
    unset($_SESSION['summary_data']); 
    
    // Also clear other proposal section data if it exists
    // $sections = ['general_info', 'program_entity', ...];
    // foreach ($sections as $section) { unset($_SESSION[$section]); }
}
// --- MODIFICATION END ---

//COMMENTED FOR WARNING - START



if($isEditing && isset($_GET['proposal_id'])) {
    $_SESSION['proposal_id'] = $_GET['proposal_id'];
    $_SESSION['is_editing'] = 1;
    $_SESSION['editing_proposal_id'] = $_GET['proposal_id'];

    if($initialFetch) {
        $sections = [
            'general_info', 'program_entity', 'assessment_rules', 'compliance_check',
            'degree_details', 'panel_of_teachers', 'program_content', 'program_delivery',
            'program_structure', 'resource_requirements', 'reviewers_report'
        ];
    
        foreach ($sections as $section) {
            deleteUploadedFiles($section);
        }
    
        foreach ($sections as $section) {
            unset($_SESSION[$section]);  
            unset($_SESSION["status_$section"]);  
        }
    }
    
    } else {
        unset($_SESSION['is_editing']);
        unset($_SESSION['editing_proposal_id']);
};






// Check if editing an existing proposal
if (isset($_GET['proposal_id']) && $isEditing && $initialFetch) {
    $proposal_id = $_GET['proposal_id'];
    $_SESSION['proposal_id'] = $proposal_id;

// // Fetch FULL QAC Summary Sheet Data ---

// $summary_data_for_view = []; // Use this variable name consistently
// $proposal_status = '';

// if ($isEditing && isset($_SESSION['proposal_id'])) {
//     $proposal_id = $_SESSION['proposal_id'];

//     // Fetch the proposal's current status
//     $stmt = $connection->prepare("SELECT status FROM proposals WHERE proposal_id = ?");
//     $stmt->bind_param("i", $proposal_id);
//     $stmt->execute();
//     $result = $stmt->get_result();
//     if ($proposal_row = $result->fetch_assoc()) {
//         $proposal_status = $proposal_row['status'];
//     }
//     $stmt->close();
// }
// }

// 1. Fetch the current status (this is needed for the master function)
    $stmt = $connection->prepare("SELECT status FROM proposals WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($proposal_row = $result->fetch_assoc()) {
        $proposal_status = $proposal_row['status'];
    } else {
        $proposal_status = ''; // Default if not found
    }
    $stmt->close();
    
    // 2. Use the master function to determine the mode and set the session flag
    $_SESSION['is_draft_revision_mode'] = isDraftRevisionMode($proposal_id, $proposal_status, $connection);

    // 3. If in revision mode, fetch the summary data and prepare view variables
    if ($_SESSION['is_draft_revision_mode']) {
        $show_revision_summary = true;
        
        $summaryQuery = "SELECT section_identifier, compliance_status, comment FROM proposal_summary_sheet WHERE proposal_id = ?";
        $stmt_summary = $connection->prepare($summaryQuery);
        $stmt_summary->bind_param("i", $proposal_id);
        $stmt_summary->execute();
        $result_summary = $stmt_summary->get_result();
        while ($row = $result_summary->fetch_assoc()) {
            $summary_data_for_view[$row['section_identifier']] = [
                'status' => $row['compliance_status'],
                'comment' => $row['comment']
            ];
        }
        $stmt_summary->close();
        $_SESSION['summary_data'] = $summary_data_for_view;
    }
}

//COMMENTED FOR WARNING - END 

    // If status requires revision, fetch the full summary sheet
        if (in_array($proposal_status, ['rejectedbyqachead', 'rejectedbyTA', 'rejectedbysecretary'])) {
        $show_revision_summary = true;
        
        $summaryQuery = "SELECT section_identifier, compliance_status, comment FROM proposal_summary_sheet WHERE proposal_id = ?";
        $stmt_summary = $connection->prepare($summaryQuery);
        $stmt_summary->bind_param("i", $proposal_id);
        $stmt_summary->execute();
        $result_summary = $stmt_summary->get_result();
        while ($row = $result_summary->fetch_assoc()) {
            $summary_data_for_view[$row['section_identifier']] = [
                'status' => $row['compliance_status'],
                'comment' => $row['comment']
            ];
        }
        $stmt_summary->close();
        $_SESSION['summary_data'] = $summary_data_for_view;
    }
    

    // Fetch proposal data from database
    $stmt = $connection->prepare("SELECT status FROM proposals WHERE proposal_id = ?");
    $stmt->bind_param("i", $proposal_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $proposal = $result->fetch_assoc();

    // Load section statuses from database
    $sections = [
        'general_info', 'program_entity', 'degree_details', 'program_structure',
        'program_content', 'program_delivery', 'assessment_rules', 'resource_requirements',
        'panel_of_teachers', 'reviewers_report', 'compliance_check'
    ];

    foreach ($sections as $section) {
        $section_table = "proposal_$section";
        $stmt = $connection->prepare("SELECT COUNT(*) FROM $section_table WHERE proposal_id = ?");
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();

        if($count !== 0) {
        $query = "SELECT * FROM proposal_" . $section . " WHERE proposal_id = ?";
        $stmt = $connection->prepare($query);
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $result = $stmt->get_result();
        
        // Handle sections that can have multiple records
        if ($section === 'program_structure' || $section === 'program_content' || $section === 'panel_of_teachers') {
            $_SESSION[$section] = [];
            while ($row = $result->fetch_assoc()) {
                $_SESSION[$section][] = $row;
            }
            if (count($_SESSION[$section]) > 0) {
                $_SESSION['status_' . $section] = 'Completed';
            }
        } else {
            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                
                // Convert comma-separated strings to arrays for specific fields
                foreach ($row as $key => $value) {
                    // Fields that should be treated as arrays
                    $array_fields = ['medium_of_instruction', 'slqf_level', 'slqf_filled', 'fallback_qualification'];
                    
                    // If the field name is in our list of array fields
                    if (in_array($key, $array_fields)) {
                        if (is_string($value)) {
                            if (strpos($value, ',') !== false) {
                                // Convert comma-separated string to array
                                $row[$key] = array_map('trim', explode(',', $value));
                            } else {
                                // Wrap single value in array
                                $row[$key] = [$value];
                            }
                        }
                    }
                }
                
                $_SESSION[$section] = $row;
                $_SESSION['status_' . $section] = 'Completed';
            }
        }
        }

        
    }

     // Fetch Data for Program Entity
     $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_program_entity WHERE proposal_id = ?");
     $stmt->bind_param("i", $proposal_id);
     $stmt->execute();
     $stmt->bind_result($count);
     $stmt->fetch();
     $stmt->close();

     if($count !== 0) {
        $stmt = $connection->prepare("SELECT program_entity_id FROM proposal_program_entity WHERE proposal_id = ?");
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $program_entity_id = $row['program_entity_id'];
        $stmt->close();
    
        // Fetch mandate availability records
        $mandate_types = [
            'corporate_plan' => 'Corporate / Strategic Plan of the University',
            'action_plan' => 'Action Plan of the Faculty/Institute/Center/Unit',
            'faculty_approval' => 'Faculty Approval',
            'senate_approval' => 'Senate Approval',
            'council_approval' => 'Council Approval'
        ];
    
        foreach ($mandate_types as $key => $type) {
            $stmt = $connection->prepare("SELECT reference_no, date_of_approval, evidence 
                FROM proposal_mandate_availability 
                WHERE proposal_id = ? AND mandate_availability_type = ?");
            $stmt->bind_param("is", $proposal_id, $type);
            $stmt->execute();
            $result = $stmt->get_result();
            
            if ($row = $result->fetch_assoc()) {
                $_SESSION['program_entity']["ref_{$key}"] = $row['reference_no'];
                $_SESSION['program_entity']["date_{$key}"] = $row['date_of_approval'];
                //$_SESSION['program_entity']["evidence_{$key}"] = '/qac_ugc/' . $row['evidence'];
                 
                    $db_path = $row['evidence'];
                    $base_prefix = '/qac_ugc/';
                    
                    // Check if the path already starts with the prefix.
                    if (strpos($db_path, $base_prefix) === 0) {
                        // If it does, use the path as is.
                        $final_url = $db_path;
                    } else {
                        // If it doesn't, add the prefix.
                        $final_url = $base_prefix . $db_path;
                    }

                    // Clean up any double slashes just in case.
                    $_SESSION['program_entity']["evidence_{$key}"] = str_replace('//', '/', $final_url);
                
            }
            $stmt->close();
        }
     }
     


        // Fetch Data for Degree Details
        // Get degree_id
        $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_degree_details WHERE proposal_id = ?");
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();
   
        if($count !== 0) {
            $stmt = $connection->prepare("SELECT degree_id FROM proposal_degree_details WHERE proposal_id = ?");
            $stmt->bind_param("i", $proposal_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            $degree_id = $row['degree_id'] ?? "";
            $stmt->close();

            // Fetch program reviews
            $stmt = $connection->prepare("SELECT * FROM proposal_grades_received WHERE proposal_id = ? AND degree_id = ?");
            $stmt->bind_param("ii", $proposal_id,$degree_id);
            $stmt->execute();
            $result = $stmt->get_result();
            
            $program_reviews = [];
            while ($row = $result->fetch_assoc()) {
                $program_reviews[] = [
                    'program_name' => $row['program_name'],
                    'program_year' => $row['program_year'],
                    'program_grade' => $row['grade']
                ];
            }
            $stmt->close();
            
            $_SESSION['degree_details']['program_reviews'] = $program_reviews;
        }

        // Fetch Data for resource requirements
        // Get resource_requirement_id
        $stmt = $connection->prepare("SELECT COUNT(*) FROM proposal_resource_requirements WHERE proposal_id = ?");
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();
   
        if($count !== 0) {
            $stmt = $connection->prepare("SELECT resource_requirement_id FROM proposal_resource_requirements WHERE proposal_id = ?");
            $stmt->bind_param("i", $proposal_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            $resource_requirement_id = $row['resource_requirement_id'];
            $stmt->close();
    
            // Fetch physical resources
            $stmt = $connection->prepare("SELECT physical_type, existing_amount, year1, year2, year3, year4 FROM proposal_physical_resource WHERE proposal_id = ?");
            $stmt->bind_param("i", $proposal_id);
            $stmt->execute();
            $result = $stmt->get_result();
            
            while ($row = $result->fetch_assoc()) {
                $key = strtolower(str_replace([' ', '/', '.'], '_', $row['physical_type']));
                $resourceRequirements[$key.'_existing'] = $row['existing_amount'];
                $resourceRequirements[$key.'_year1'] = $row['year1'];
                $resourceRequirements[$key.'_year2'] = $row['year2'];
                $resourceRequirements[$key.'_year3'] = $row['year3'];
                $resourceRequirements[$key.'_year4'] = $row['year4'];
            }
            $stmt->close();

            // Fetch human resources
            $stmt = $connection->prepare("SELECT staff_type, year1, year2, year3, year4 FROM proposal_human_resource WHERE proposal_id = ?");
            $stmt->bind_param("i", $proposal_id);
            $stmt->execute();
            $result = $stmt->get_result();
            
            while ($row = $result->fetch_assoc()) {
                $key = strtolower(str_replace([' ', '/'], '_', $row['staff_type']));
                $resourceRequirements[$key.'_year1'] = $row['year1'];
                $resourceRequirements[$key.'_year2'] = $row['year2'];
                $resourceRequirements[$key.'_year3'] = $row['year3'];
                $resourceRequirements[$key.'_year4'] = $row['year4'];
            }
            $stmt->close();

            // Fetch financial resources
            $stmt = $connection->prepare("SELECT financial_type, year1, year2, year3, year4 FROM proposal_financial_resource WHERE proposal_id = ?");
            $stmt->bind_param("i", $proposal_id);
            $stmt->execute();
            $result = $stmt->get_result();
            
            while ($row = $result->fetch_assoc()) {
                $key = strtolower(str_replace(' ', '_', $row['financial_type']));
                $resourceRequirements[$key.'_year1'] = $row['year1'];
                $resourceRequirements[$key.'_year2'] = $row['year2'];
                $resourceRequirements[$key.'_year3'] = $row['year3'];
                $resourceRequirements[$key.'_year4'] = $row['year4'];
            }
            $stmt->close();

            $_SESSION['resource_requirements'] = $resourceRequirements ?? "";
        }
        


        // Fetch Data for reviwers report
        $stmt = $connection->prepare("SELECT aspect, main_proposal_comment, fallback_qualification_comment FROM proposal_reviewers_report WHERE proposal_id = ?");
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $result = $stmt->get_result();

        // Define aspect mapping (reverse of what's in draft_save_submit.php)
        $aspect_mapping = array_flip([
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
        ]);

        while ($row = $result->fetch_assoc()) {
            $aspect_key = $aspect_mapping[$row['aspect']] ?? '';
            if ($aspect_key) {
                $_SESSION['reviewers_report']['main_' . $aspect_key] = $row['main_proposal_comment'];
                $_SESSION['reviewers_report']['fallback_' . $aspect_key] = $row['fallback_qualification_comment'];
            }
        }
        $stmt->close();

        // Fetch reviewer details
        $stmt = $connection->prepare("SELECT * FROM proposal_reviewer_details WHERE proposal_id = ? LIMIT 2");
        $stmt->bind_param("i", $proposal_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $reviewer_count = 1;
        while ($row = $result->fetch_assoc()) {
            $_SESSION['reviewers_report']['reviewer' . $reviewer_count . '_name'] = $row['name'];
            $_SESSION['reviewers_report']['reviewer' . $reviewer_count . '_designation'] = $row['designation'];
            $_SESSION['reviewers_report']['reviewer' . $reviewer_count . '_qualification'] = $row['qualification'];
            $_SESSION['reviewers_report']['reviewer' . $reviewer_count . '_signature'] = $row['signature'];
            $_SESSION['reviewers_report']['reviewer' . $reviewer_count . '_date'] = $row['date'];
            $reviewer_count++;
        }
        $stmt->close();
    


// Retrieve the status of the General Information section
$statusGeneralInfo = $_SESSION['status_general_info'] ?? 'Not Started';
$badgeClass1 = $statusGeneralInfo === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the program dentity
$statusprogramentity = $_SESSION['status_program_entity'] ?? 'Not Started';
$badgeClass2 = $statusprogramentity === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the degree details section
$statusdegreeDetails = $_SESSION['status_degree_details'] ?? 'Not Started';
$badgeClass3 = $statusdegreeDetails === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the program structure
$statusprogramStructure = $_SESSION['status_program_structure'] ?? 'Not Started';
$badgeClass4 = $statusprogramStructure === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the program content
$statusprogramContent = $_SESSION['status_program_content'] ?? 'Not Started';
$badgeClass5 = $statusprogramContent === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the program delivery
$statusprogramDelivery = $_SESSION['status_program_delivery'] ?? 'Not Started';
$badgeClass6 = $statusprogramDelivery === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the Assessment Rules section
$statusAssessmentRules = $_SESSION['status_assessment_rules'] ?? 'Not Started';
$badgeClass7 = $statusAssessmentRules === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the resource requirements
$statusresourceRequirements = $_SESSION['status_resource_requirements'] ?? 'Not Started';
$badgeClass8 = $statusresourceRequirements === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the panel of teachers section
$statuspanelofTeachers = $_SESSION['status_panel_of_teachers'] ?? 'Not Started';
$badgeClass9 = $statuspanelofTeachers === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the reviewers report
$statusreviewersReport = $_SESSION['status_reviewers_report'] ?? 'Not Started';
$badgeClass10 = $statusreviewersReport === 'Completed' ? 'bg-success' : 'bg-secondary';

// Retrieve the status of the Compliance Check section
$statusComplianceCheck = $_SESSION['status_compliance_check'] ?? 'Not Started';
$badgeClass11 = $statusComplianceCheck === 'Completed' ? 'bg-success' : 'bg-secondary';

//Handle block compliance fields from Edit. 
function is_section_Compliance($section_name) {
    // Read the full summary data that was fetched and stored in the session
    $summary_data = $_SESSION['summary_data'] ?? [];
    
    // If there is no summary data (e.g., this is not a revision), no sections should be locked.
    if (empty($summary_data)) {
        return false;
    }

    // This map correctly defines all section types, including hybrid/multi-part ones as arrays.
    $section_identifier_map = [
        'general_info'          => 'general_information.',
        'program_entity'        => ['program_entity.', 'table.mandate_availability'], 
        'degree_details'        => ['degree_details.','table.program_grades'],
        'program_structure'     => 'table.program_structure',
        'program_content'       => 'table.program_content',
        'program_delivery'      => 'program_delivery_and_learner_support_system.',
        'assessment_rules'      => 'program_assessment_rules_and_precodures.',
        'resource_requirements' => ['table.human_resources', 'table.physical_resources', 'table.financial_resources'],
        'panel_of_teachers'     => 'table.panel_of_teachers',
        'reviewers_report'      => ['table.reviewers_report','table.reviewer_details'],
        'compliance_check'      => 'compliance_check.'
    ];

    if (!isset($section_identifier_map[$section_name])) {
        return false; // Section not in our map, default to unlocked.
    }

    $identifiers_for_section = $section_identifier_map[$section_name];

    // The rule: A section is considered UNLOCKED if any of its parts are 'non_compliance'.
    // It is LOCKED by default during a revision unless a non-compliance is found.

    // To simplify the loop, we always treat the identifiers as an array.
    if (!is_array($identifiers_for_section)) {
        $identifiers_for_section = [$identifiers_for_section];
    }

    // Loop through each identifier/prefix that defines this section (e.g., ['program_entity.', 'table.mandate_availability'])
    foreach ($identifiers_for_section as $identifier_prefix) {
        
        // Loop through the actual review data from the summary sheet
        foreach ($summary_data as $review_identifier => $details) {
            
            // Check if the reviewed item belongs to the current part of the section we're checking
            if (strpos($review_identifier, $identifier_prefix) === 0) {
                
                // Check the 'status' key within the $details array.
                if (isset($details['status']) && $details['status'] === 'non_compliance') {
                    // We found a non-compliant item. This whole section is NOT compliant. UNLOCK IT.
                    return false; 
                }
            }
        }
    }

    // If we finished checking all parts of this section and never found a 'non_compliance' status,
    // it means the section is considered compliant. LOCK IT.
    return true;
}

// ... after all your other PHP logic ...

// --- REPLACEMENT BLOCK: HANDLES BUTTON AND MODAL DATA ---
$show_summary_button = false; // Default to hiding the button
$summary_data_for_view = [];  // Default to empty data for the modal

if ($isEditing && isset($_SESSION['proposal_id'])) {
    $proposal_id_for_logic = $_SESSION['proposal_id'];
    $current_status_for_logic = '';

    // A quick, separate query just for this page's display logic
    $stmt_logic = $connection->prepare("SELECT status FROM proposals WHERE proposal_id = ?");
    $stmt_logic->bind_param("i", $proposal_id_for_logic);
    $stmt_logic->execute();
    $result_logic = $stmt_logic->get_result();
    if ($row_logic = $result_logic->fetch_assoc()) {
        $current_status_for_logic = $row_logic['status'];
    }
    $stmt_logic->close();
    
    // Use the master function to decide if we are in revision mode
    $is_revision = isDraftRevisionMode($proposal_id_for_logic, $current_status_for_logic, $connection);

    if ($is_revision) {
        // If it's a revision, we need to do TWO things:
        
        // 1. Set the flag to show the button.
        $show_summary_button = true;

        // 2. Fetch the summary data for the modal.
        // This ensures the data is always available on every "Back" button visit.
        $summaryQuery = "SELECT section_identifier, compliance_status, comment FROM proposal_summary_sheet WHERE proposal_id = ?";
        $stmt_summary = $connection->prepare($summaryQuery);
        $stmt_summary->bind_param("i", $proposal_id_for_logic);
        $stmt_summary->execute();
        $result_summary = $stmt_summary->get_result();
        while ($row = $result_summary->fetch_assoc()) {
            $summary_data_for_view[$row['section_identifier']] = [
                'status' => $row['compliance_status'],
                'comment' => $row['comment']
            ];
        }
        $stmt_summary->close();
    }
}
// --- END OF REPLACEMENT BLOCK ---


?>

<!DOCTYPE html> 
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proposal Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .section-list {
            list-style: none;
            padding: 0;
        }
        .section-list li {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background: white;
            border: 1px solid #ddd;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        .btn-section {
            border-radius: 5px;
        }

        .badge {
            display: <?php echo $isEditing ? 'none' : 'inline-block' ?>;
        }

        .section-list .badge {
            visibility: <?php echo $isEditing ? 'hidden' : 'visible' ?>;
            display: inline-block;
        }

        .status-label {
            padding: 3px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-block;
        }

        .status-label.compliance {
            color: #155724;
            background-color: #d4edda;
        }

        .status-label.non-compliance {
            color: #721c24;
            background-color: #f8d7da;
        }

        .status-label.other {
            color: #383d41;
            background-color: #e2e3e5;
        }

        footer {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            color: #7f8c8d;
        }

        
    </style>
</head>
<body>
    <div class="container mt-5">

               <?php
        // Use the flag that is now reliably set in all scenarios.
        if ($show_summary_button):
        ?>
            <!-- View Summary Sheet Button -->
            <div class="d-flex justify-content-end mb-3">
                <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#summarySheetModal">
                    📄 View Summary Sheet
                </button>
            </div>
        <?php 
        endif; 
        ?>

        
        <h3><?php echo $isEditing ? 'Edit Proposal: #' : 'New Proposal: #'; echo $_SESSION['proposal_id'] ?></h3>
        <p>Please complete all sections before submitting the proposal.</p>
            <ul class="section-list">
            <li>
                <span>1. General Information</span>
                <span>
                    
                    <span class="badge <?php echo $badgeClass1; ?>"><?php echo $statusGeneralInfo; ?></span>
                     <?php if ($isEditing && is_section_Compliance('general_info', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?> 
                        <a href="Proposal_sections/general_info.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?> 
                </span>
            </li>
            <li>
                <span>2. Program Offering Entity</span>
                <span>
                    <span class="badge <?php echo $badgeClass2; ?>"><?php echo $statusprogramentity; ?></span>
                    <?php if ($isEditing && is_section_Compliance('program_entity', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/program_entity.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
            <li>
                <span>3. Details of the Degree Program</span>
                <span>
                    <span class="badge <?php echo $badgeClass3; ?>"><?php echo $statusdegreeDetails; ?></span>
                     <?php if ($isEditing && is_section_Compliance('degree_details', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/degree_details.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                    <?php endif; ?>
                </span>
            </li>
            <li>
                <span>4. Program Structure</span>
                <span>
                <span class="badge <?php echo $badgeClass4; ?>"><?php echo $statusprogramStructure; ?></span>
                <?php if ($isEditing && is_section_Compliance('program_structure', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/program_structure.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
            <li>
                <span>5. Program Content</span>
                <span>
                    <span class="badge <?php echo $badgeClass5; ?>"><?php echo $statusprogramContent; ?></span>
                    <?php if ($isEditing && is_section_Compliance('program_content', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/program_content.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
            <li>
                <span>6. Program Delivery and Learner Support System</span>
                <span>
                    <span class="badge <?php echo $badgeClass6; ?>"><?php echo $statusprogramDelivery; ?></span>
                    <?php if ($isEditing && is_section_Compliance('program_delivery', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/program_delivery.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
            <li>
                <span>7. Program Assessment Procedure/Rules</span>
                <span>
                    <span class="badge <?php echo $badgeClass7; ?>"><?php echo $statusAssessmentRules; ?></span>
                    <?php if ($isEditing && is_section_Compliance('assessment_rules', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/assessment_rules.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
            <li>
                <span>8. Resource Requirements</span>
                <span>
                    <span class="badge <?php echo $badgeClass8; ?>"><?php echo $statusresourceRequirements; ?></span>
                     <?php if ($isEditing && is_section_Compliance('resource_requirements', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/resource_requirements.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
            <li>
                <span>9. Panel of Teachers</span>
                <span>
                    <span class="badge <?php echo $badgeClass9; ?>"><?php echo $statuspanelofTeachers; ?></span>
                    <?php if ($isEditing && is_section_Compliance('panel_of_teachers', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/panel_of_teachers.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
            <li>
                <span>10. Reviewers Report</span>
                <span>
                    <span class="badge <?php echo $badgeClass10; ?>"><?php echo $statusreviewersReport; ?></span>
                    <?php if ($isEditing && is_section_Compliance('reviewers_report', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/reviewers_report.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
            <li>
                <span>11. Compliance Check </span>
                <span>
                <span class="badge <?php echo $badgeClass11; ?>"><?php echo $statusComplianceCheck; ?></span>
                <?php if ($isEditing && is_section_Compliance('compliance_check', $summary_data_for_view)): ?>
                        <button class="btn btn-success btn-sm btn-section" disabled>Compliance</button>
                    <?php else: ?>
                        <a href="Proposal_sections/compliance_check.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                     <?php endif; ?>
                </span>
            </li>
        </ul>

        <div class="d-flex gap-2 align-items-center">
            <form action="/qac_ugc/Proposal_sections/database_handling/draft_save_submit.php" method="post">
                <button class="btn btn-success" id="submitProposal" name="submitProposal" disabled>Submit Proposal</button>
                <button class="btn btn-success" id="saveDraft" name="saveDraft">Save Draft</button>
            </form>
        <button class="btn btn-success" id="downloadApplication" disabled onclick="downloadApplication()">Download Application</button>
        <a href="new_proposal.php" class="btn btn-secondary">Back</a>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
        const statuses = document.querySelectorAll('.badge');
        const submitBtn = document.getElementById('submitProposal');
        const downloadappBtn = document.getElementById('downloadApplication');

    // Check if all sections are completed
         const allCompleted = Array.from(statuses).every(status => status.classList.contains('bg-success'));
        
        console.log("All Completed:", allCompleted); // Debug output
     // Enable/Disable buttons
        submitBtn.disabled = !allCompleted;
        downloadappBtn.disabled = !allCompleted;
    });

    // Function to handle application download
        function downloadApplication() {
            window.location.href = '/qac_ugc/Proposal_sections/generate_sections_pdf.php'; 
}
   
    </script>

 <footer>
        Copyright © 2024 University Grants Commission. Developed by UGC.
</footer>


<!-- Summary Sheet Modal -->
<div class="modal fade" id="summarySheetModal" tabindex="-1" aria-labelledby="summarySheetModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
       
        <h5 class="modal-title" id="summarySheetModalLabel">QAC Summary Sheet - Proposal: #<?php echo htmlspecialchars($_SESSION['proposal_id'] ?? 'N/A'); ?></h5>
        <div>
            <!-- The Download button comes first -->
            <a href="generate_summary_pdf.php?id=<?php echo htmlspecialchars($_SESSION['proposal_id'] ?? ''); ?>" 
               class="btn btn-success me-2" 
               target="_blank">
               <i class="bi bi-download"></i> Download 
            </a>

            <!-- The standard close button comes last -->
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>
       
      <div class="modal-body">

        <?php if (!empty($summary_data_for_view)): ?>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Section</th>
                        <th>Status</th>
                        <th>Comment</th>
                    </tr>
                </thead>
                
                <!-- <tbody>
                <?php 
                    // Use the summary data stored in the session for consistency
                    $summary_data_modal = $_SESSION['summary_data'] ?? [];
                    foreach ($summary_data_modal as $identifier => $details): 
                ?>
                    <?php 
                        // Get status and comment from the details array
                        $status = $details['status'] ?? 'not_reviewed';
                        $statusClass = strtolower(str_replace('_', '-', $status));
                    ?>
                    <tr>
                        <td><?php echo htmlspecialchars($identifier); ?></td>
                        <td>
                            <span class="status-label <?php echo htmlspecialchars($statusClass); ?>">
                                <?php echo htmlspecialchars(ucwords(str_replace('_', ' ', $status))); ?>
                            </span>
                        </td>
                        <td>
                            <?php $comment = $details['comment'] ?? ''; ?>
                            <?php if (!empty($comment)): ?>
                                <br><small class="text-muted"><em>Comment: <?php echo htmlspecialchars($comment); ?></em></small>
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody> -->
                            <tbody>
                    <?php 
                    // Read directly from the variable populated at the top of the page.
                    if (!empty($summary_data_for_view)):
                        foreach ($summary_data_for_view as $identifier => $details): 
                    ?>
                        <?php 
                            $status = $details['status'] ?? 'not_reviewed';
                            $comment = $details['comment'] ?? '';
                            $statusClass = strtolower(str_replace('_', '-', $status));
                        ?>
                        <tr>
                            <td><?php echo htmlspecialchars($identifier); ?></td>
                            <td>
                                <span class="status-label <?php echo htmlspecialchars($statusClass); ?>">
                                    <?php echo htmlspecialchars(ucwords(str_replace('_', ' ', $status))); ?>
                                </span>
                            </td>
                            <td>
                                <?php echo htmlspecialchars($comment); ?>
                            </td>
                        </tr>
                    <?php 
                        endforeach;
                    else:
                    ?>
                        <tr>
                            <td colspan="3">No summary data available.</td>
                        </tr>
                    <?php
                    endif;
                    ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No summary sheet data available.</p>
        <?php endif; ?>

      </div>
      <div class="modal-footer">
        
       
    </div>
  </div>
</div>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</html>
