<?php
require 'databaseconnection.php'; // Database connection
require_once 'Proposal_sections/dompdf/vendor/autoload.php'; // Adjust Dompdf path if necessary

use Dompdf\Dompdf;
use Dompdf\Options;

// Validate and get proposal ID
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    die("Invalid request.");
}
$proposal_id = intval($_GET['id']);

// Capture the contents of view_proposal.php
ob_start();
include 'view_proposal.php';
$html = ob_get_clean();


$html = preg_replace('/<div class="no-print">.*?<\/div>/s', '', $html);


$html = preg_replace('/<a .*?>Back<\/a>/', '', $html);
$html = preg_replace('/<button .*?>Download as PDF<\/button>/', '', $html);

// Improve table formatting and prevent content from being cut off
$style = "
<style>
    body { font-family: Arial, sans-serif; }
    h3 { text-align: center; color: #004085; margin-bottom: 20px; }
    
    table { width: 100%; border-collapse: collapse; margin-top: 20px; table-layout: fixed; word-wrap: break-word; }
    th, td { border: 1px solid #000; padding: 8px; text-align: left; font-size: 10px; word-break: break-word; overflow-wrap: break-word; }
    th { background-color: #f2f2f2; font-weight: bold; }

    /* Ensure program content fits properly */
    .program-content table { page-break-inside: auto; }
    .program-content tr { page-break-inside: avoid; page-break-after: auto; }
    .page-break { page-break-before: always; }

    /* Hide no-print elements */
    .no-print { display: none !important; visibility: hidden !important; }
</style>
";

// Apply the styles before the content
$html = $style . $html;

// Initialize Dompdf
$options = new Options();
$options->set('isHtml5ParserEnabled', true);
$options->set('defaultFont', 'Helvetica');
$options->set('isRemoteEnabled', true);
$options->set('isPhpEnabled', true);
$dompdf = new Dompdf($options);

// Load HTML into Dompdf
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'landscape'); // Use landscape mode to fit wide tables

// Render the PDF
$dompdf->render();

// Force download of the generated PDF
$dompdf->stream("proposal_details.pdf", ["Attachment" => 1]);

exit;
?>
