<?php
session_start();
require 'databaseconnection.php'; // Your database connection

// Adjust this path if your `dompdf` folder is located elsewhere.
require_once 'Proposal_sections/dompdf/vendor/autoload.php';

use Dompdf\Dompdf;
use Dompdf\Options;

// --- SECURITY CHECK ---
if (!isset($_SESSION['role'])) {
    die("Access Denied. Please log in.");
}
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    die("Invalid Proposal ID.");
}

$proposal_id = (int)$_GET['id'];

// --- FETCH DATA ---

// 1. Fetch proposal details (Title, Code, University) with a single efficient query
$proposal_title = "Proposal #" . $proposal_id;
$proposal_code = "N/A";
$university_name = "N/A";

$query = "
    SELECT 
        gi.degree_name_english,
        p.proposal_code,
        pe.university
    FROM proposals p
    LEFT JOIN proposal_general_info gi ON p.proposal_id = gi.proposal_id
    LEFT JOIN proposal_program_entity pe ON p.proposal_id = pe.proposal_id
    WHERE p.proposal_id = ?
";
$stmt = $connection->prepare($query);
$stmt->bind_param("i", $proposal_id);
$stmt->execute();
$result = $stmt->get_result();
if ($row = $result->fetch_assoc()) {
    $proposal_title = !empty($row['degree_name_english']) ? $row['degree_name_english'] : $proposal_title;
    $proposal_code = !empty($row['proposal_code']) ? $row['proposal_code'] : $proposal_code;
    $university_name = !empty($row['university']) ? $row['university'] : $university_name;
}
$stmt->close();


// 2. Fetch the summary sheet data
$summary_data = [];
$summaryQuery = "SELECT section_identifier, compliance_status, comment FROM proposal_summary_sheet WHERE proposal_id = ?";
$stmt_summary = $connection->prepare($summaryQuery);
$stmt_summary->bind_param("i", $proposal_id);
$stmt_summary->execute();
$result_summary = $stmt_summary->get_result();
while ($row = $result_summary->fetch_assoc()) {
    $summary_data[] = $row;
}
$stmt_summary->close();

if (empty($summary_data)) {
    die("No summary data found for this proposal.");
}


// --- BUILD THE HTML CONTENT FOR THE PDF ---
$html = "
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<style>
    @page { margin: 25px; }
    body { font-family: Arial, sans-serif; font-size: 11px; }
    .header-table { width: 100%; border: none; margin-bottom: 20px; font-size: 12px; }
    .header-table td { border: none; padding: 0; }
    h1 { text-align: center; color: #333; margin: 0; font-size: 18px; }
    h2 { font-size: 14px; color: #555; border-bottom: 1px solid #ccc; padding-bottom: 5px; margin-top: 15px; }
    table { width: 100%; border-collapse: collapse; margin-top: 15px; }
    th, td { border: 1px solid #999; padding: 6px; text-align: left; vertical-align: top; }
    th { background-color: #e8e8e8; font-weight: bold; }
    .compliance { color: #155724; background-color: #d4edda; }
    .non-compliance { color: #721c24; background-color: #f8d7da; }
    .comment { word-wrap: break-word; }
</style>
</head>
<body>
    <h1>UGC Proposal Review - Summary Sheet</h1>

    <table class='header-table'>
        <tr>
            <td style='width: 60%;'><strong>University:</strong> " . htmlspecialchars($university_name) . "</td>
            <td style='width: 40%; text-align: right;'><strong>Proposal Code:</strong> " . htmlspecialchars($proposal_code) . "</td>
        </tr>
    </table>
    
    <h2>" . htmlspecialchars($proposal_title) . " (Proposal #" . $proposal_id . ")</h2>

    <table>
        <thead>
            <tr>
                <th style='width: 35%;'>Section / Field</th>
                <th style='width: 20%;'>Status</th>
                <th style='width: 45%;'>Comment</th>
            </tr>
        </thead>
        <tbody>
";

foreach ($summary_data as $item) {
    $identifier = htmlspecialchars(ucwords(str_replace(['_', '.'], ' ', $item['section_identifier'])));
    $status = htmlspecialchars(ucwords(str_replace('_', ' ', $item['compliance_status'])));
    $comment = htmlspecialchars($item['comment']);
    $status_class = strtolower(str_replace('_', '-', $item['compliance_status']));

    $html .= "<tr>";
    $html .= "  <td>" . $identifier . "</td>";
    $html .= "  <td class='" . $status_class . "'>" . $status . "</td>";
    $html .= "  <td class='comment'>" . nl2br($comment) . "</td>"; // nl2br converts newlines to <br> tags
    $html .= "</tr>";
}

$html .= "
        </tbody>
    </table>
</body>
</html>
";

// --- PDF GENERATION (using your Dompdf setup) ---

// Initialize Dompdf
$options = new Options();
$options->set('isHtml5ParserEnabled', true);
$options->set('defaultFont', 'Helvetica');
$options->set('isRemoteEnabled', true); // Important for images, if any, in the future
$dompdf = new Dompdf($options);

// Load HTML into Dompdf
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');

// Render the PDF
$dompdf->render();

// Force download of the generated PDF
$filename = "Summary_Sheet_" . str_replace(' ', '_', $proposal_code) . ".pdf";
$dompdf->stream($filename, ["Attachment" => 1]);

exit;
?>