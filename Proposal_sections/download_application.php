<?php
session_start();
ob_start(); // Prevent output before headers

error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', 'error_log.txt');


// Check DomPDF installation
if (!file_exists(__DIR__ . "/dompdf/autoload.inc.php")) {
    die("Error: DomPDF library not found!");
}

require_once __DIR__ . "/dompdf/autoload.inc.php";
use Dompdf\Dompdf;
use Dompdf\Options;

// Check if all sections are completed
$sections = [
    "general_info",
    "program_entity",
    "assessment_rules",
    "compliance_check",
    "degree_details",
    "panel_of_teachers",
    "program_content",
    "program_delivery",
    "program_structure",
    "resource_requirements",
    "reviewers_report"
];

$allCompleted = true;
foreach ($sections as $key) {
    if (!isset($_SESSION["status_" . $key]) || $_SESSION["status_" . $key] !== "Completed") {
        $allCompleted = false;
        break;
    }
}

if (!$allCompleted) {
    die("Error: Not all sections are completed!");
}

// Debug: Print session data to verify
file_put_contents("session_debug.txt", print_r($_SESSION, true));

// Initialize Dompdf
$options = new Options();
//$options->set('defaultFont', 'Helvetica');
$options->set('defaultFont', 'DejaVu Sans');
$options->set('isHtml5ParserEnabled', true);
$options->set('isRemoteEnabled', true);

$dompdf = new Dompdf($options);

// Generate PDF content
$html = "<html><head><style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    h1 { text-align: center; color: #2C3E50; }
    h2 { background-color: #3498db; color: #fff; padding: 10px; border-radius: 5px; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
    th { background-color: #f4f4f4; }
    .section { margin-bottom: 30px; page-break-before: always; }
</style></head><body>";

$html .= "<h1>Application Summary</h1>";

foreach ($sections as $key) {
    if (isset($_SESSION[$key]) && !empty($_SESSION[$key])) {
        $html .= "<div class='section'><h2>" . ucfirst(str_replace('_', ' ', $key)) . "</h2><table>";

        foreach ($_SESSION[$key] as $field => $value) {
            $formattedValue = is_array($value) ? implode(", ", $value) : htmlspecialchars((string)$value);
            $html .= "<tr><th>" . ucfirst(str_replace('_', ' ', $field)) . "</th><td>{$formattedValue}</td></tr>";
        }
        $html .= "</table></div>";
    }
}

$html .= "</body></html>";

// Debug: Save HTML output to file
file_put_contents("debug.html", $html);

// Load HTML into Dompdf
$dompdf->loadHtml($html);
$dompdf->setPaper("A4", "portrait");
$dompdf->render();

// Debug: Check if PDF content is generated
$pdfContent = $dompdf->output();
if (empty($pdfContent)) {
    die("Error: PDF content is empty. Check your session data or HTML structure.");
}

// Send the PDF as a download
header("Content-Type: application/pdf");
header("Content-Disposition: attachment; filename=application.pdf");
header("Cache-Control: no-cache, no-store, must-revalidate");
header("Pragma: no-cache");
header("Expires: 0");

$dompdf->stream("application.pdf", ["Attachment" => true]);
exit();
?>
