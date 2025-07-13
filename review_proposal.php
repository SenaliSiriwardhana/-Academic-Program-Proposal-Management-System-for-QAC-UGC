<?php
session_start();
// Debug session data (remove after testing)
//echo "<pre>";
//print_r($_SESSION);
//echo "</pre>";

require 'databaseconnection.php'; // Database connection

// Check if the user is logged in and has a role
if (!isset($_SESSION['role']) || !isset($_SESSION['username'])|| !isset($_SESSION['id'])) {
    die("Access Denied. Please login.");
}

$role = $_SESSION['role']; // Dean, VC, or CQA
$username = $_SESSION['username']; // Logged-in user's username


// Check if proposal ID is provided
if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("Invalid request.");
}

$proposal_id = $_GET['id'];
//echo "$proposal_id";

// Fetch all proposal details from different sections
$proposalQuery = "SELECT proposal_code,
  university_visible_status,
  created_at,
  updated_at ,
  proposal_type,
  submitted_at FROM proposals WHERE proposal_id = ?";
  
$stmt = $connection->prepare($proposalQuery);
$stmt->bind_param("i", $proposal_id);
$stmt->execute();
$proposal = $stmt->get_result()->fetch_assoc();
$stmt->close();


$proposal_type = strtolower($proposal['proposal_type']);


if (strpos($proposal_type, 'revised') === 0) {
    // Revised proposal — use extended status list
    $statusList = [
        'approvedbyStandardCommitte',
        'approvedbyqachead_revised',
        'approvedbysecretary',
        'approvedbyTA',
        're-signed_dean',
        're-signed_cqa',
        're-signed_vc',
        'resignature_request_from_university'
    ];
} else {
    // Initial proposal — use basic status list
    $statusList = [
        'approvedbyStandardCommitte',
        'approvedbydean',
        'approvedbycqa',
        'approvedbyvc',
        'approvedbyTA',
        'approvedbysecretary',
        'approvedbyqachead'
        
    ];
}

// Build IN clause dynamically
$placeholders = implode(',', array_fill(0, count($statusList), '?'));

$commentQuery = "
SELECT id, proposal_status, comment, seal_and_sign, Date
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY proposal_status 
               ORDER BY Date DESC, id DESC
           ) as rn
    FROM proposal_comments
    WHERE proposal_id = ?
      AND proposal_status IN ($placeholders)
) AS ranked
WHERE rn = 1
ORDER BY Date ASC;
";

$stmt = $connection->prepare($commentQuery);

$params_to_bind = array_merge([$proposal_id], $statusList);
$types = 'i' . str_repeat('s', count($statusList));
$stmt->bind_param($types, ...$params_to_bind);

$stmt->execute();
$result = $stmt->get_result();
$comments = $result->fetch_all(MYSQLI_ASSOC);

// Determine if revised or initial
$isRevised = strpos($proposal_type, 'revised') === 0;

// Define orders for each case
$initialOrder = [
    'approvedbydean',
    'approvedbycqa',
    'approvedbyvc',
    'approvedbyTA',
    'approvedbysecretary',
    'approvedbyqachead',
    'approvedbyStandardCommitte',
];

$revisedOrder = [
    'approvedbyTA',
    'approvedbysecretary',
    'resignature_request_from_university',
    're-signed_dean',
    're-signed_cqa',
    're-signed_vc',
    'approvedbyStandardCommitte',
];

// Choose the right order array
$desiredOrder = $isRevised ? $revisedOrder : $initialOrder;

// Create mapping for sorting
$orderMap = array_flip($desiredOrder);

// Sort comments based on the chosen order
usort($comments, function ($a, $b) use ($orderMap) {
    $orderA = $orderMap[$a['proposal_status']] ?? PHP_INT_MAX;
    $orderB = $orderMap[$b['proposal_status']] ?? PHP_INT_MAX;
    return $orderA <=> $orderB;
});




// ✅ Ensure $comments is always an array (to prevent foreach() errors)
if (!$comments) {
    $comments = []; 
}

$stmt->close();

// Section: Degree_Details (without grades)
$degreeDetailsQuery = "SELECT 
    background_to_program, mandate_faculty,
    faculty_status, student_intake, staff_cadres, educational_facilities,
    common_facilities, program_benefits, eligibility_req, indicate_program,
    admission_process, other_criteria, intake, degree_type, duration,
    coursework_credits, thesis_credits, total_credits, medium_of_instruction,
    subject_benchmark, slqf_level, slqf_filled, rec_in_review_report, degree_details_objective, degree_details_justification
FROM proposal_degree_details WHERE proposal_id = ?";

// Section: Program Grades
$programGradesQuery = "SELECT program_name, program_year, grade 
FROM proposal_grades_received WHERE proposal_id = ?";

// Section: General Information
$generalInfoQuery = "SELECT  
  degree_name_english,
  degree_name_sinhala,
  degree_name_tamil,
  qualification_name_english,
  qualification_name_sinhala,
  qualification_name_tamil,
  abbreviated_qualification FROM proposal_general_info WHERE proposal_id = ?";

// Section: Program Entity (form-based)
$programEntityQuery = "SELECT faculty, department, university
FROM proposal_program_entity WHERE proposal_id = ?";

// Section: Mandate Availability (table)
$mandateAvailabilityQuery = "SELECT mandate_availability_type, reference_no, 
date_of_approval, evidence FROM proposal_mandate_availability WHERE proposal_id = ?";

// Section: Assessment Rules
$assessmentRulesQuery = "SELECT formative_summative,
  grading_scheme,
  gpa_calculation,
  semester_contribution,
  inplant_training,
  repeat_exams,
  degree_requirements,
  class_requirements FROM proposal_assessment_rules WHERE proposal_id = ?";

// Section: Program Content (table)
$programContentQuery = "SELECT 
  
  semester,
  module_code,
  module_name,
  credit_value,
  core_optional,
  lecture_hours,
  practical_hours,
  independent_hours,
  learning_outcomes,
  module_content,
  teaching_methods,
  continuous_assessment_percentage,
  final_assessment_percentage,
  recommended_reading FROM proposal_program_content WHERE proposal_id = ?";

// Section: Program Structure (table)
$programStructureQuery = "SELECT 
 
  semester,
  module_code,
  module_name,
  credit_value,
  module_status,
  qualifier1_related,
  qualifier2_related,
  module_type FROM proposal_program_structure WHERE proposal_id = ?";

// Section: Compliance Check
$complianceCheckQuery = "SELECT resources_commence,
  fallback_options ,
  fallback_qualification ,
  collaboration,
  collaboration_details ,
  access_facilities ,
  professional_membership ,
  fallback_attachment ,
  collaboration_attachment ,
  access_facilities_attachment ,
  membership_attachment  FROM proposal_compliance_check WHERE proposal_id = ?";

// Section: Program Delivery
$programDeliveryQuery = "SELECT program_delivery_description FROM proposal_program_delivery WHERE proposal_id = ?";

// Section: Reviewers Report (table)
$reviewersReportQuery = "SELECT aspect, main_proposal_comment, 
fallback_qualification_comment FROM proposal_reviewers_report WHERE proposal_id = ?";

// Section: Reviewer Details (table)
$reviewerDetailsQuery = "SELECT name, designation, qualification, 
signature, date FROM proposal_reviewer_details WHERE proposal_id = ?";

// Section: Panel of Teachers (table)
$panelOfTeachersQuery = "SELECT 
  
  lecturer_name,
  designation,
  internal_ug_hours,
  internal_pg_hours,
  external_ug_hours,
  external_pg_hours,
  proposed_program_hours,
  total_hours FROM proposal_panel_of_teachers WHERE proposal_id = ?";

// Section: Resource Requirements (split into Human, Physical, Financial)
$humanResourceQuery = "SELECT staff_type, year1, year2, year3, year4 
FROM proposal_human_resource WHERE proposal_id = ?";

$physicalResourceQuery = "SELECT physical_type, existing_amount, year1, year2, year3, year4 
FROM proposal_physical_resource WHERE proposal_id = ?";

$financialResourceQuery = "SELECT financial_type, year1, year2, year3, year4 
FROM proposal_financial_resource WHERE proposal_id = ?";

// Fetch proposal details
$stmt = $connection->prepare($proposalQuery);
$stmt->bind_param("i", $proposal_id);
$stmt->execute();
$proposal = $stmt->get_result()->fetch_assoc();

// Fetch all other sections
function fetchData($connection, $query, $proposal_id) {
    $stmt = $connection->prepare($query);
    $stmt->bind_param("i", $proposal_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

// Fetch all sections
$degreeDetails = fetchData($connection, $degreeDetailsQuery, $proposal_id);
$programGrades = fetchData($connection, $programGradesQuery, $proposal_id);
$generalInfo = fetchData($connection, $generalInfoQuery, $proposal_id);
$programEntity = fetchData($connection, $programEntityQuery, $proposal_id);
$mandateAvailability = fetchData($connection, $mandateAvailabilityQuery, $proposal_id);
$assessmentRules = fetchData($connection, $assessmentRulesQuery, $proposal_id);
$programContent = fetchData($connection, $programContentQuery, $proposal_id);
$programStructure = fetchData($connection, $programStructureQuery, $proposal_id);
$complianceCheck = fetchData($connection, $complianceCheckQuery, $proposal_id);
$programDelivery = fetchData($connection, $programDeliveryQuery, $proposal_id);
$reviewersReport = fetchData($connection, $reviewersReportQuery, $proposal_id);
$reviewerDetails = fetchData($connection, $reviewerDetailsQuery, $proposal_id);
$panelOfTeachers = fetchData($connection, $panelOfTeachersQuery, $proposal_id);
$humanResource = fetchData($connection, $humanResourceQuery, $proposal_id);
$physicalResource = fetchData($connection, $physicalResourceQuery, $proposal_id);
$financialResource = fetchData($connection, $financialResourceQuery, $proposal_id);

// Define the common upload directory prefix
define("UPLOADS_DIR", "/qac_ugc/Proposal_sections/uploads/");

// Function to detect and format only PDF file URLs
function formatValue($value) {
    // Check if the value starts with the uploads directory and is a PDF
    if (strpos($value, UPLOADS_DIR) === 0 && preg_match('/\.pdf$/i', $value)) {
        return "<a href='$value'>View File</a>";
    }

    return htmlspecialchars($value); // Escape other text values for security
}


// Function to calculate total credits
function calculateTotalCredits($sectionData) {
    $total_credits = 0;
    foreach ($sectionData as $row) {
        if (isset($row['credit_value'])) {
            $total_credits += (float) $row['credit_value']; // Convert to float and sum up
        }
    }
    return $total_credits;
}




// Function to display form-based sections in a single row with file upload handling
function displayFormSection($sectionTitle, $sectionData) {
    if (!empty($sectionData)) {
        echo "<h4 class='mt-4'>$sectionTitle</h4>";
        echo "<div class='table-responsive'><table class='table table-striped'>";
        
        foreach ($sectionData[0] as $key => $value) {
            echo "<tr><th>" . ucfirst(str_replace('_', ' ', $key)) . "</th><td>" . formatValue($value) . "</td></tr>";
        }
        
        echo "</table></div>";
    }
}


// Function to display table-based sections with file upload handling
function displayTableSection($sectionTitle, $sectionData) {
    if (!empty($sectionData)) {
        echo "<h4 class='mt-4'>$sectionTitle</h4>";
        echo "<div class='table-responsive'><table class='table table-bordered'>";
        
        // Table headers
        echo "<thead><tr>";
        foreach (array_keys($sectionData[0]) as $column) {
            echo "<th>" . ucfirst(str_replace('_', ' ', $column)) . "</th>";
        }
        echo "</tr></thead><tbody>";

        // Table content
        foreach ($sectionData as $row) {
            echo "<tr>";
            foreach ($row as $value) {
                echo "<td>" . formatValue($value) . "</td>";
            }
            echo "</tr>";
        }

        echo "</tbody></table></div>";
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proposal Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4 bg-light">

    <h3 class = "text-center text-primary">Proposal Details</h3>
    <table class="table table-bordered">
        <?php
        $customLabels = [
        'university_visible_status' => 'Status'
        ];
        ?>

        <?php foreach ($proposal as $key => $value) { ?>
           <?php $label = $customLabels[$key] ?? ucfirst(str_replace('_', ' ', $key)); ?>
            <tr><th><?php echo $label; ?></th><td><?php echo htmlspecialchars($value); ?></td></tr>
        <?php } ?>
    </table>

    <?php 
     displayFormSection("General Information", $generalInfo);
     displayFormSection("Program Entity", $programEntity);
     displayTableSection("Mandate Availability", $mandateAvailability);
     displayFormSection("Degree Details", $degreeDetails);
     displayTableSection("Program Grades", $programGrades);
     displayTableSection("Program Structure", $programStructure);
     displayTableSection("Program Content", $programContent);
     displayFormSection("Program Delivery and Learner Support System", $programDelivery);
     displayFormSection("Program Assessment Rules and Precodures", $assessmentRules);
     displayTableSection("Human Resources", $humanResource);
     displayTableSection("Physical Resources", $physicalResource);
     displayTableSection("Financial Resources", $financialResource);
     displayTableSection("Panel of Teachers", $panelOfTeachers);
     displayTableSection("Reviewers Report", $reviewersReport);
     displayTableSection("Reviewer Details", $reviewerDetails);
     displayFormSection("Compliance Check", $complianceCheck);
    
    
    ?>

    <!-- Previous Approvals Section -->
    <h4 class="mt-4 text-primary">Approvals</h4>
    <table class="table table-bordered">
        <tr>
            <th>Reviewed By</th>
            <th>Decision</th>
            <th>Comment</th>
            <th>Date</th>
            <th>Signature</th>
        </tr>
        <?php foreach ($comments as $comment) { ?>
            <tr>
                <td>
                    <?php 
                        if ($comment['proposal_status'] === 'approvedbydean') echo "Dean";
                        elseif ($comment['proposal_status'] === 'approvedbyvc') echo "Vice Chancellor";
                        elseif ($comment['proposal_status'] === 'approvedbycqa') echo "CQA Director";
                    ?>
                </td>
                <td><?php echo ucfirst(str_replace("approvedby", "Approved by ", $comment['proposal_status'])); ?></td>
                <td><?php echo htmlspecialchars($comment['comment']); ?></td>
                <td><?php echo htmlspecialchars($comment['Date']); ?></td>
                <td>
                    <?php 
                    if (!empty($comment['seal_and_sign'])) {
                        echo "<a href='{$comment['seal_and_sign']}'>View Signature</a>";
                    } else {
                        echo "No Signature Uploaded";
                    }
                    ?>
                </td>
            </tr>
        <?php } ?>
    </table>


    <!-- Include the Signature Pad Library -->
    <script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>

    <!-- Comment Section -->
    <h4 class="mt-4 text-primary">Comments</h4>
    <form action="submit_comment.php" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="proposal_id" value="<?php echo $proposal_id; ?>">
        <textarea name="dean_comment" class="form-control mb-3" rows="4" placeholder="Enter your comments here..."></textarea>
        
        <!-- Checkbox for confirmation -->
        <div class="form-check">
            <input type="checkbox" class="form-check-input" id="recommend" name="recommend">
            <label class="form-check-label" for="recommend">I hereby endorse the proposal, confirming that all the above information provided is accurate and complete.</label>
        </div>

        <!-- Signature Pad -->
            <h4 class="mt-4">Digital Signature</h4>

            <!-- Add this block for the signer's name -->
        <div class="mb-2">
            <label for="signer_name" class="form-label">Signer's Name (as it will appear on the signature):</label>
            <input type="text" id="signer_name" class="form-control" value="<?php echo htmlspecialchars(trim(($_SESSION['first_name'] ?? '') . ' ' . ($_SESSION['last_name'] ?? ''))); ?>" readonly>
        </div>
        
         
            <canvas id="signature-pad" width="400" height="150" style="border: 1px solid #000;"></canvas>
            <br>
            <button type="button" id="clear" class="btn btn-warning">Clear</button>
            <br>

        <!-- Hidden input to store the signature image -->
            <input type="hidden" name="signature_image" id="signature_image">

        <br>

        <div class="d-flex gap-2 align-items-center">
            <button type="submit" name="approve" class="btn btn-success">Approve</button>
            <button type="submit" name="reject" class="btn btn-danger">Reject</button>
            
        </div>

        <script>
            // Initialize Signature Pad
            var canvas = document.getElementById('signature-pad');
            var signaturePad = new SignaturePad(canvas);

            // Clear button functionality
            document.getElementById('clear').addEventListener('click', function () {
                signaturePad.clear();
            });

            // Add an event listener to the form's submit event
            document.querySelector('form').addEventListener('submit', function (event) {
                // Find out which button was clicked to submit the form
                const submitter = event.submitter;

                // --- LOGIC FOR APPROVAL ---
                // Only perform signature checks if the 'approve' button was clicked
                if (submitter && submitter.name === 'approve') {
                    
                    // Check 1: Is the recommendation checkbox ticked?
                    if (!document.getElementById('recommend').checked) {
                        alert('Please mark the checkbox to confirm your recommendation and correctness of the proposal information.');
                        event.preventDefault(); // Stop form submission
                        return; // Exit the function
                    }

                    // Check 2: Is the signature pad empty?
                    if (signaturePad.isEmpty()) {
                        alert("Please provide your digital signature to approve the proposal.");
                        event.preventDefault(); // Stop form submission
                        return; // Exit the function
                    }

                    
                    // Draw Name and Date on the Canvas ---

                    // Get the 2D context of the canvas
                    var ctx = canvas.getContext('2d');
                    
                    // Get the name from the readonly input field
                    var signerName = document.getElementById('signer_name').value;
                    
                    // Get the current date
                    var currentDate = new Date().toLocaleDateString();

                    // Set font and color for the text
                    ctx.font = '14px "Helvetica", "Arial", sans-serif';
                    ctx.fillStyle = '#000'; // Black text
                    ctx.textAlign = 'left'; // Align text to the left

                    // Draw the name and date at the bottom of the canvas
                    // You can adjust the coordinates (10, 140) as needed
                    ctx.fillText(`Signed by: ${signerName} on ${currentDate}`, 10, 140);
                    // --- END NEW LOGIC ---

                    // If all checks pass for approval, save the signature data to the hidden input
                    document.getElementById('signature_image').value = signaturePad.toDataURL();
                }

                // --- LOGIC FOR REJECTION (or any other button) ---
                // For the 'reject' button, no special client-side validation is needed here.
                // The form will submit normally without checking the signature.
            });
        </script>

</body>
</html>

</body>
</html>
