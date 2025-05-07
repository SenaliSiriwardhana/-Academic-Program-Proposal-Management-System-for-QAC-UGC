<?php
ob_start(); // Start output buffering to prevent accidental output
session_start();
require_once __DIR__ . '/dompdf/autoload.inc.php';

use Dompdf\Dompdf;
use Dompdf\Options;

// Increase Memory & Execution Time
ini_set('memory_limit', '512M');
ini_set('max_execution_time', 300);

// Initialize Dompdf
$options = new Options();
$options->set('defaultFont', 'Helvetica');
$options->set('isHtml5ParserEnabled', true);
$dompdf = new Dompdf($options);

// Define sections
$sections = [
    "general_info" => "General Information",
    "degree_details" => "Degree Details",
    "proposal_grades_received" => "Grades Received at Program Reviews" ,
    "program_entity" => "Program Entity",
    "assessment_rules" => "Assessment Rules",
    "compliance_check" => "Compliance Check",
    "panel_of_teachers" => "Panel of Teachers",
    "program_content" => "Program Content",
    "program_delivery" => "Program Delivery",
    "program_structure" => "Program Structure",
    "resource_requirements" => "Resource Requirements",
    "reviewers_report" => "Reviewers Report"
];

// Fields to exclude (Primary & Foreign Keys)
$exclude_fields = [
    'id', 'proposal_id', 'report_id','user_id', 'customer_id', 'degree_id', 'content_id', 'program_entity_id','aspect','main_proposal_comment','fallback_qualification_comment','degree_delivery_id',
    'assessment_rule_id','compliance_check_id','program_delivery_id','general_info_id'
];

// Start HTML output
$html = '<html><head>
    <style>
        body { font-family: Arial, sans-serif; font-size: 8px; }
        h1 { text-align: center; }
        h2 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 5px; margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 4px; text-align: left; font-size: 8px; word-wrap: break-word; white-space: normal; }
        th { background-color: #f4f4f4; text-align: center; max-width: 120px; }
        a { color: #3498db; text-decoration: none; }
        tr { page-break-inside: auto; }
    </style>
</head><body>';

$html .= "<h1>Application for Approval of New Undergraduate Degree Programme (Internal) <br> Proposal ID : " . ($_SESSION['proposal_id'] ?? 'N/A') . "  </h1>";

// Loop through sections
foreach ($sections as $session_key => $section_name) {
    if (!isset($_SESSION[$session_key]) || empty($_SESSION[$session_key])) {
        continue;
    }
    $html .= "<h2>{$section_name}</h2>";
    
    // Sections that should be displayed as tables
    $table_sections = ["panel_of_teachers", "program_content", "program_structure", "proposal_grades_received"];
    if (in_array($session_key, $table_sections) && is_array($_SESSION[$session_key])) {
        $html .= '<table><tr>';
        // Generate table headers, excluding unwanted fields
        foreach (array_keys($_SESSION[$session_key][0]) as $field) {
            if (!in_array($field, $exclude_fields)) {
                $html .= "<th>" . ucfirst(str_replace('_', ' ', $field)) . "</th>";
            }
        }
        $html .= '</tr>';
        
        // Generate table rows
        foreach ($_SESSION[$session_key] as $entry) {
            $html .= "<tr>";
            foreach ($entry as $key => $value) {
                if (!in_array($key, $exclude_fields)) {
                    $html .= "<td>" . htmlspecialchars($value ?? '') . "</td>";
                }
            }
            $html .= "</tr>";
        }
        $html .= '</table>';
        continue;
    }
// Handle File Uploads as "View File" Links
$html .= '<table>';

$KEYS_TO_SKIP = array("program_reviews");
$upload_base_path = "/qac_ugc/Proposal_sections/uploads/"; // Define the correct base path

foreach ($_SESSION[$session_key] as $key => $value) {
    if (is_string($value) && strpos($value, '/uploads/') !== false) {
        // Remove any duplicate occurrences of '/qac_ugc/' to ensure a clean path
        $file_path = str_replace("//", "/", $value); // Remove double slashes
        $file_path = preg_replace("#(/qac_ugc/)+#", "/qac_ugc/", $file_path); // Ensure single '/qac_ugc/'

        // Ensure base path is added ONLY if it doesn't already exist
        if (strpos($file_path, $upload_base_path) === false) {
            // Extract only the file name from the existing path
            $file_name = basename($file_path);
            $file_path = $upload_base_path . $file_name;
        }

        // Final cleanup in case of extra slashes
        $file_path = str_replace("//", "/", $file_path);

        // Create the link
        $value = "<a href='http://localhost" . htmlspecialchars($file_path, ENT_QUOTES) . "' target='_blank'>View File</a>";
    }

    if (is_array($value)) {
        $value = implode(" ", $value);
    }
    if (in_array($key, $KEYS_TO_SKIP)) {
        continue;
    } else {
        $html .= "<tr><th>" . ucfirst(str_replace('_', " ", $key)) . "</th><td>{$value}</td></tr>";
    }
}

$html .= '</table>';




    // Program Reviews Table (Under Degree Details)
    if ($session_key === "degree_details" && isset($_SESSION[$session_key]['program_reviews'])) {
        $html .= '<h3>Grades Received at Program Reviews</h3>';
        $html .= '<table>
                    <tr>
                        <th>Program Name</th>
                        <th>Year</th>
                        <th>Grade</th>
                    </tr>';
        foreach ($_SESSION[$session_key]['program_reviews'] as $review) {
            $html .= "<tr>
                        <td>{$review['program_name']}</td>
                        <td>{$review['program_year']}</td>
                        <td>{$review['program_grade']}</td>
                      </tr>";
        }
        $html .= '</table>';
    }
    
}

$html .= '</body></html>';

// Load HTML into Dompdf
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();

// Set download headers
header('Content-Type: application/pdf');
header('Content-Disposition: attachment; filename="Application_Summary.pdf"');
header('Cache-Control: max-age=0');

// Output the PDF directly
echo $dompdf->output();
exit();
?>
