<?php

// Start session
session_start();

// Define the upload directory
$uploadDir = __DIR__ . '/../uploads/';  // Adjust path if necessary
$uploadUrl = '/qac_ugc/Proposal_sections/uploads/';

// Function to delete uploaded files from session data
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


// Check if a section is provided
if (isset($_GET['section'])) {
    $section = $_GET['section'];

// Delete files associated with this section
deleteUploadedFiles($section);

// Clear the session data for the given section
    switch ($section) {
        case 'general_info':
            unset($_SESSION['general_info']);
            unset($_SESSION['status_general_info']);
            break;

        case 'program_entity':
            unset($_SESSION['program_entity']);
            unset($_SESSION['status_program_entity']);
            break;

        case 'assessment_rules':
            unset($_SESSION['assessment_rules']);
            unset($_SESSION['status_assessment_rules']);
            break;

        case 'compliance_check':
            unset($_SESSION['compliance_check']);
            unset($_SESSION['status_compliance_check']);
            break;

        case 'degree_details':
            unset($_SESSION['degree_details']);
            unset($_SESSION['status_degree_details']);
            break;

        case 'panel_of_teachers':
            unset($_SESSION['panel_of_teachers']);
            unset($_SESSION['status_panel_of_teachers']);
            break;

        case 'program_content':
            unset($_SESSION['program_content']);
            unset($_SESSION['status_program_content']);
            break;

        case 'program_delivery':
            unset($_SESSION['program_delivery']);
            unset($_SESSION['status_program_delivery']);
            break;

        case 'program_structure':
            unset($_SESSION['program_structure']);
            unset($_SESSION['status_program_structure']);
            break;

        case 'resource_requirements':
            unset($_SESSION['resource_requirements']);
            unset($_SESSION['status_resource_requirements']);
            break;

        case 'reviewers_report':
            unset($_SESSION['reviewers_report']);
            unset($_SESSION['status_reviewers_report']);
            break;

        default:
            echo "Invalid section specified.";
            exit();
    }

// Redirect back to the appropriate form
    header("Location: /qac_ugc/Proposal_sections/$section.php");
    exit();

} else {
    echo "No section specified.";
    exit();
}
?>
