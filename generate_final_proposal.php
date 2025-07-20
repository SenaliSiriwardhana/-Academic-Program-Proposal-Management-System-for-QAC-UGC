<?php
//session_start(); // Start session to access user role if needed for other logic
require 'databaseconnection.php'; // Database connection
require_once 'Proposal_sections/dompdf/vendor/autoload.php'; // Adjust Dompdf path if necessary

use Dompdf\Dompdf;
use Dompdf\Options;

// --- 1. VALIDATE PROPOSAL ID ---
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    die("Invalid request: Proposal ID is missing or invalid.");
}
$proposal_id = intval($_GET['id']);


// --- 2. CAPTURE THE MAIN PROPOSAL HTML ---
// We use output buffering to "capture" the entire HTML output of `view_proposal.php`
// as if we were a browser visiting it.
ob_start();
// The 'id' from the URL is passed to the included file
include 'view_proposal.php'; 
$html_main_proposal = ob_get_clean();


// --- 3. CAPTURE THE SUMMARY SHEET HTML (if it exists) ---
$html_summary_sheet = ''; // Initialize as empty

// A) First, check if the QAC Head has ever reviewed this proposal
$summary_data = []; // This will hold the data for the summary table
$qac_head_statuses = ['approvedbyqachead', 'rejectedbyqachead', 'approvedbyqachead_revised', 'resignature_request_from_university'];
$placeholders = implode(',', array_fill(0, count($qac_head_statuses), '?'));

$history_check_query = "SELECT 1 FROM proposal_status_history WHERE proposal_id = ? AND new_status IN ($placeholders) LIMIT 1";
$stmt_history = $connection->prepare($history_check_query);
$params = array_merge([$proposal_id], $qac_head_statuses);
$types = 'i' . str_repeat('s', count($qac_head_statuses));
$stmt_history->bind_param($types, ...$params);
$stmt_history->execute();
$result_history = $stmt_history->get_result();

// B) If a history record was found, it means a summary exists. Let's fetch and render it.
if ($result_history->num_rows > 0) {
    // Fetch the summary data from the database
    $summaryQuery = "SELECT section_identifier, compliance_status, comment FROM proposal_summary_sheet WHERE proposal_id = ?";
    $stmt_summary = $connection->prepare($summaryQuery);
    $stmt_summary->bind_param("i", $proposal_id);
    $stmt_summary->execute();
    $result_summary = $stmt_summary->get_result();
    while ($row = $result_summary->fetch_assoc()) {
        $summary_data[] = $row;
    }
    $stmt_summary->close();

    // C) If we found data, use output buffering again to capture the summary table HTML
    if (!empty($summary_data)) {
        ob_start();
        // The `_summary_sheet_table.php` file is a clean, reusable component
        include '_summary_sheet_table.php'; 
        $html_summary_sheet = ob_get_clean();
    }
}
$stmt_history->close();


// --- 4. CLEAN UP AND COMBINE THE HTML ---

// Remove any elements we don't want in the PDF (like buttons or accordions)
// The "no-print" class is the best way to handle this.
$html_main_proposal = preg_replace('/<div class="no-print.*?<\/div>/s', '', $html_main_proposal);
$html_main_proposal = preg_replace('/<div class="accordion.*?<\/div>/s', '', $html_main_proposal);


// ...
$style = "
<style>
    @page { margin: 25px; }
    body { font-family: Arial, sans-serif; }
    h3, h4 { text-align: center; color: #004085; }
    
    /* --- THIS IS THE FIX --- */
    /* Tell all headers to avoid breaking away from the content that follows them */
    h4 {
        page-break-after: avoid;
    }
    
    table { 
        width: 100%; 
        border-collapse: collapse; 
        margin-top: 15px; 
        /* This tells the table it's okay to split across pages if needed */
        page-break-inside: auto; 
    }
    
    /* This is the most important rule: Keep header rows (<thead>) with the first data row (tbody tr) */
    thead { 
        display: table-header-group; 
    }
    
    /* This tells individual rows to try not to split themselves */
    tr { 
        page-break-inside: avoid; 
        page-break-after: auto; 
    }
    /* --- END OF FIX --- */

    th, td { border: 1px solid #000; padding: 6px; text-align: left; font-size: 9px; word-wrap: break-word; }
    th { background-color: #f2f2f2; font-weight: bold; }

    .page-break { page-break-before: always; }
    
    /* Hide no-print elements */
    .no-print { display: none !important; }

    /* Styles for the Summary Sheet specifically */
    .status-compliance { color: #155724; background-color: #d4edda; font-weight: bold; }
    .status-non-compliance { color: #721c24; background-color: #f8d7da; font-weight: bold; }
</style>
";
// ...

// Add a page break before the summary sheet if it exists
if (!empty($html_summary_sheet)) {
    $html_summary_sheet = "<div class='page-break'></div>" . $html_summary_sheet;
}

// Combine all parts into the final HTML for Dompdf
$final_html = $style . $html_main_proposal . $html_summary_sheet;


// --- 5. INITIALIZE AND RENDER THE PDF ---

// Initialize Dompdf with recommended options
$options = new Options();
$options->set('isHtml5ParserEnabled', true);
$options->set('defaultFont', 'Helvetica');
$options->set('isRemoteEnabled', true); // Allows loading images from http://...
$options->set('isPhpEnabled', true); // Important for some complex rendering
$dompdf = new Dompdf($options);

// Load the final HTML
$dompdf->loadHtml($final_html);

// Set paper size and orientation
$dompdf->setPaper('A4', 'landscape'); // Landscape is often better for wide tables

// Render the HTML as PDF
$dompdf->render();

// --- 6. OUTPUT THE PDF TO THE BROWSER ---
// Force the browser to download the file
$dompdf->stream("Proposal_Full_Details_" . $proposal_id . ".pdf", ["Attachment" => 1]);

exit;
?>