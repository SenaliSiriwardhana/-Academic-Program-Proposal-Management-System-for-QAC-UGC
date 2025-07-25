<?php
session_start();
require 'databaseconnection.php'; // Database connection
require 'summary_sheet_generator.php'; // Include our helper

// Ensure the user is logged in and has a valid UGC role
if (!isset($_SESSION['role']) || !isset($_SESSION['username']) || !isset($_SESSION['id'])) {
    die("Access Denied. Please login.");
}

$role = strtolower(trim($_SESSION['role']));
$username = $_SESSION['username']; // Logged-in user's username
$user_id = $_SESSION['id']; // User ID for tracking approvals
$first_name = $_SESSION['first_name']; // Getting name for setting TA's status


// This logic only applies to Technical Assistants
if ($role === 'ugc - technical assistant') {
    
    // --- MAP USERNAME TO THEIR SPECIFIC ENUM STATUS ---
    // Maintain this list is a must. Add new TAs here. Use appropriate names ( and also need to add enums to status column in db [proposals])
    $ta_status_map = [
        'ATechAssistant' => 'under_review_by_ATechAssistant',
        'BTechAssistant' => 'under_review_by_BTechAssistant',
        //'CTechAssistant' => 'under_review_by_CTechAssistant', // Example for another TA
    ];

    // Check if the current TA is in our map
    if (array_key_exists($first_name, $ta_status_map)) {
        
        if (!isset($_GET['id']) || empty($_GET['id'])) { die("Invalid request."); }
        $proposal_id = $_GET['id'];

        // Get the specific ENUM status for this user
        $my_review_status = $ta_status_map[$first_name];

        // Get the current status of the proposal
        $stmt_check = $connection->prepare("SELECT status FROM proposals WHERE proposal_id = ?");
        $stmt_check->bind_param("i", $proposal_id);
        $stmt_check->execute();
        $current_status = $stmt_check->get_result()->fetch_assoc()['status'];
        $stmt_check->close();
        
        $waiting_statuses = ['approvedbyvc', 'approvedbycqa'];

        // If the proposal is waiting, assign it to this TA by setting their specific status
        if (in_array($current_status, $waiting_statuses)) {
            $stmt_update = $connection->prepare(
                "UPDATE proposals SET status = ?, university_visible_status = ? WHERE proposal_id = ?"
            );
            $stmt_update->bind_param("ssi", $my_review_status, $my_review_status, $proposal_id);
            $stmt_update->execute();
            $stmt_update->close();
        }
    }
}


// Ensure user is from UGC
$ugc_roles = [
    "ugc - technical assistant" => "approvedbyTA",
    "ugc - secretary" => "approvedbysecretary",
    "head of the qac-ugc department" => "approvedbyqachead",
    "ugc - finance department" => "approvedbyugcfinance",
    "ugc - hr department" => "approvedbyugchr",
    "ugc - idd department" => "approvedbyugcidd",
    //"ugc - legal department" => "approvedbyugclegal",
    "ugc - academic department" => "approvedbyugcacademic",
    "ugc - admission department" => "approvedbyugcadmission",
    "standard committee" => "approvedbystandardcommittee"
];

// Validate user role and set approval status
if (!array_key_exists($role, $ugc_roles)) {
    die("<pre>Error: Unauthorized access. Role detected: " . htmlspecialchars($role) . "</pre>");
}

$approval_status = $ugc_roles[$role]; // Set department-specific approval status

// Check if proposal ID is provided
if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("Invalid request.");
}

$proposal_id = $_GET['id'];

// Fetch proposal details
$proposalQuery = "SELECT proposal_id, proposal_type, status, created_at, updated_at, submitted_at, proposal_type FROM proposals WHERE proposal_id = ?";
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
        'resignature_request_from_university',
        'approvedbyugcfinance',
        'approvedbyugchr',
        'approvedbyugcidd',
        'approvedbyugcacademic',
        'approvedbyugcadmission',
	'approvedbydean',
        'approvedbycqa',
        'approvedbyvc'
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
        'approvedbyqachead',
        'approvedbyugcfinance',
        'approvedbyugchr',
        'approvedbyugcidd',
        'approvedbyugcacademic',
        'approvedbyugcadmission',
        
    ];
}

// Build IN clause dynamically
$placeholders = implode(',', array_fill(0, count($statusList), '?'));

$is_director_qac = ($role === 'head of the qac-ugc department');

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
    'approvedbyugcfinance',
    'approvedbyugchr',
    'approvedbyugcidd',
    'approvedbyugcacademic',
    'approvedbyugcadmission',
    'approvedbyStandardCommitte',
];

$revisedOrder = [
    'approvedbydean',
    'approvedbycqa',
    'approvedbyvc',
    'approvedbyTA',
    'approvedbysecretary',
    'resignature_request_from_university',
    're-signed_dean',
    're-signed_cqa',
    're-signed_vc',
    'approvedbyugcfinance',
    'approvedbyugchr',
    'approvedbyugcidd',
    'approvedbyugcacademic',
    'approvedbyugcadmission',
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


// --- 2. NEW LOGIC TO BE ADDED ---

// Get proposal status (you already have this)
$proposal_status = $proposal['status'];

// Define who can SEE the summary sheet
$ugc_roles_list = ["ugc - technical assistant", "ugc - secretary", "head of the qac-ugc department", "ugc - finance department", "ugc - hr department", "ugc - idd department", "ugc - academic department", "ugc - admission department", "standard committee"];
$is_ugc_user = in_array($role, $ugc_roles_list);

// University can see it only after a UGC decision has been made
$post_ugc_review_statuses = ['rejectedbyTA', 'rejectedbysecretary', 'rejectedbyqachead', 'approvedbyqachead', 'approvedbyqachead_revised','request_signature_from_university'];
$is_uni_user_with_view_rights = !$is_ugc_user && in_array($proposal_status, $post_ugc_review_statuses);

// Final decision on visibility
$show_summary_sheet = $is_ugc_user; // For now, let's assume only UGC users see it. You can add '|| $is_uni_user_with_view_rights' if they also use this page.

// Define who can EDIT the summary sheet
$can_edit_summary = in_array($role, ["ugc - technical assistant", "head of the qac-ugc department", "ugc - secretary", "standard committee"]);

// Fetch summary data ONLY if the sheet is being shown
$summary_data = [];
if ($show_summary_sheet) {
    $summaryQuery = "SELECT section_identifier, compliance_status, comment FROM proposal_summary_sheet WHERE proposal_id = ?";
    $stmt_summary = $connection->prepare($summaryQuery);
    $stmt_summary->bind_param("i", $proposal_id);
    $stmt_summary->execute();
    $result_summary = $stmt_summary->get_result();
    while ($row = $result_summary->fetch_assoc()) {
        $summary_data[$row['section_identifier']] = [
            'status' => $row['compliance_status'],
            'comment' => $row['comment']
        ];
    }
    $stmt_summary->close();
}

// Check if user is department reviewer (you already have this)
$departmentApprovalMap = [
    'ugc - finance department'   => 'approvedbyugcfinance',
    'ugc - hr department'        => 'approvedbyugchr',
    'ugc - idd department'       => 'approvedbyugcidd',
    'ugc - academic department'  => 'approvedbyugcacademic',
    'ugc - admission department' => 'approvedbyugcadmission',
];
$is_department_reviewer = array_key_exists($role, $departmentApprovalMap);



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
    <style>
        .summary-pane {
    position: sticky;
    top: 20px;
    max-height: calc(100vh - 40px);
    overflow-y: auto;
}
    </style>
</head>
<body class="container mt-4 bg-light">
    <form action="submit_comment.php" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="proposal_id" value="<?php echo $proposal_id; ?>">
    <div class="row">
    <!-- LEFT SIDE: Proposal and All Content -->
    <div class="col-md-6">
    <h3 class = "text-center text-primary">Proposal Details</h3>
    <table class="table table-bordered">
        <?php foreach ($proposal as $key => $value) { ?>
            <tr><th><?php echo ucfirst(str_replace('_', ' ', $key)); ?></th><td><?php echo htmlspecialchars($value); ?></td></tr>
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
    
    // Check if the proposal is in the parallel review stage
$parallel_queue_statuses = ['approvedbyqachead', 'approvedbyqachead_revised', 're-signed_vc', 'approvedbyalldepartments'];
$is_in_parallel_review = in_array($proposal['status'], $parallel_queue_statuses);
$department_approvals = [];

if ($is_in_parallel_review) {
    // Define the departments and their statuses
    $review_departments = [
        "UGC - Finance Department"   => "approvedbyugcfinance",
        "UGC - HR Department"        => "approvedbyugchr",
        "UGC - IDD Department"       => "approvedbyugcidd",
        "UGC - Academic Department"  => "approvedbyugcacademic",
        "UGC - Admission Department" => "approvedbyugcadmission",
    ];

    // Fetch approvals for these departments from the comments table
    $dept_statuses_placeholders = implode(',', array_fill(0, count($review_departments), '?'));
    $dept_approval_query = "SELECT proposal_status FROM proposal_comments WHERE proposal_id = ? AND proposal_status IN ($dept_statuses_placeholders)";
    
    $stmt_dept = $connection->prepare($dept_approval_query);
    $params = array_merge([$proposal_id], array_values($review_departments));
    $types = 'i' . str_repeat('s', count($review_departments));
    $stmt_dept->bind_param($types, ...$params);
    $stmt_dept->execute();
    $result_dept = $stmt_dept->get_result();
    
    $approved_statuses = [];
    while($row = $result_dept->fetch_assoc()) {
        $approved_statuses[] = $row['proposal_status'];
    }
    $stmt_dept->close();

    // Create a simple status map for display
    foreach ($review_departments as $name => $status) {
        $department_approvals[$name] = in_array($status, $approved_statuses);
    }
}
    ?>
</div>


 <!-- RIGHT SIDE: Compliance Summary -->
    <div class="col-md-6 summary-pane">
        <?php require 'render_summary_pane.php'; ?>
    </div>
</div> <!-- End of ROW -->

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
                        elseif ($comment['proposal_status'] === 'approvedbycqa') echo "CQA Director";
                        elseif ($comment['proposal_status'] === 'approvedbyvc') echo "Vice Chancellor";
                        elseif ($comment['proposal_status'] === 'approvedbyTA') echo "Technical Assistant";
                        elseif ($comment['proposal_status'] === 'approvedbysecretary') echo "Secretary";
                        elseif ($comment['proposal_status'] === 'approvedbyqachead') echo "Head of the QAC-UGC Department";
                        elseif ($comment['proposal_status'] === 'resignature_request_from_university') echo "Head of the QAC-UGC Department- (Revised Proposal recommended by QAC)";
                        elseif ($comment['proposal_status'] === 'approvedbyugcfinance') echo "UGC - Finance Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugchr') echo "UGC - HR Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugcidd') echo "UGC - IDD Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugcacademic') echo "UGC - Academic Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugcadmission') echo "UGC - Admission Department";
                        elseif ($comment['proposal_status'] === 're-signed_dean') echo "Re-signature for final version - Dean";
                        elseif ($comment['proposal_status'] === 're-signed_cqa') echo "Re-signature for final version - CQA Director";
                        elseif ($comment['proposal_status'] === 're-signed_vc') echo "Re-signature for final version - VC";
                        elseif ($comment['proposal_status'] === 'approvedbyugcStandardCommittee') echo "Standard Committee";
                        
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
    <!-- <form action="submit_comment.php" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="proposal_id" value="<?php echo $proposal_id; ?>"> -->
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

            <?php
           

            $departmentApprovalMap = [
                'ugc - finance department'   => 'approvedbyugcfinance',
                'ugc - hr department'        => 'approvedbyugchr',
                'ugc - idd department'       => 'approvedbyugcidd',
                'ugc - academic department'  => 'approvedbyugcacademic',
                'ugc - admission department' => 'approvedbyugcadmission',
            ];

            $is_department_reviewer = array_key_exists($role, $departmentApprovalMap);
            $department_approval_value = $departmentApprovalMap[$role] ?? null;

             $UGCSecretaryApprovalMap = [
                'ugc - finance department'   => 'approvedbyugcfinance',
                'ugc - hr department'        => 'approvedbyugchr',
                'ugc - idd department'       => 'approvedbyugcidd',
                'ugc - academic department'  => 'approvedbyugcacademic',
                'ugc - admission department' => 'approvedbyugcadmission',
            ];

            $is_department_reviewer = array_key_exists($role, $departmentApprovalMap);
            $department_approval_value = $departmentApprovalMap[$role] ?? null;
            ?>

            <?php if ($is_director_qac): ?>
            <!-- Special buttons for the Director-QAC -->
            <button type="submit" name="director_action" value="rejectedbyqachead" class="btn btn-danger">Request Revision</button>
            
            <?php if ($proposal_type === 'initial_proposal'): ?>
                <button type="submit" name="director_action" value="approvedbyqachead" class="btn btn-success btn-approve">Approve</button>
            
                <?php else: // It's a revised proposal ?>
                <!--<button type="submit" name="director_action" value="approvedbyqachead_revised" class="btn btn-primary" onclick="handleRevisedRecommendation()">Recommend Revised Proposal</button>-->
                <button type="button" class="btn btn-primary btn-approve" onclick="handleRevisedRecommendation()">Recommend Revised Proposal</button>
                <?php endif; ?>

            <?php else: ?>

            <?php
                // --- Determine the text for the "Approve" button ---
                $approve_button_text = 'Approve'; // Default text

                if ($is_department_reviewer) {
                    $approve_button_text = 'Mark as Reviewed';
                } elseif ($role === 'standard committee') {
                    $approve_button_text = 'Submit to Subject Standing Committee';
                }
            ?>

                <!-- 1. The "Approve" button -->
            <button type="submit" name="approve" class="btn btn-success btn-approve">
                <?php echo $approve_button_text; ?>
            </button>

            <br><br>
            <!-- Button 1 -->
            <button type="submit" name="approve_commission" class="btn btn-primary btn-approve">
                Submit to Commission through Management Committee
            </button>
            

            <br><br>

            <!-- Button 2 -->
            <button type="submit" name="approve_decision_received" class="btn btn-info btn-approve">
                Commission Decision Received
            </button>

            <br><br>

            <!-- Button 3 -->
            <button type="submit" name="approve_conveyed" class="btn btn-dark btn-approve">
                Decision Conveyed
            </button>
            

            <br><br>
            <?php if (!$is_department_reviewer): ?>
                <button type="submit" name="reject" class="btn btn-danger">Reject for revisions</button>
            <?php endif; ?>
    
         <?php endif; ?>

           
        
        </div>

    <script>
    // Initialize Signature Pad
    var canvas = document.getElementById('signature-pad');
    var signaturePad = new SignaturePad(canvas);

    // Clear button functionality
    document.getElementById('clear').addEventListener('click', function () {
        signaturePad.clear();
    });

    function handleRevisedRecommendation() {
        // --- VALIDATION STEP 1: Perform signature and checkbox checks FIRST ---
        if (!document.getElementById('recommend').checked) {
            alert('Please check the endorsement box to confirm your action.');
            return; // Stop the function
        }
        if (signaturePad.isEmpty()) {
            alert("Please provide your digital signature to recommend the proposal.");
            return; // Stop the function
        }
        // --- END OF VALIDATION ---
        

        // If validation passes, then show the pop-up box
        const needsResignature = confirm("Does this revised proposal require re-signatures from the university (Dean, CQA, VC)?\n\n- Click 'OK' for YES.\n- Click 'Cancel' for NO.");

        // Get the form
        const form = document.querySelector('form');

        // Create a hidden input to hold the chosen action
        let hiddenInput = form.querySelector('input[name="director_action"]');
        if (!hiddenInput) {
            hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'director_action';
            form.appendChild(hiddenInput);
        }
        
        // Set the value based on the user's choice
        if (needsResignature) {
            // User clicked "OK" (Yes, needs signature)
            hiddenInput.value = 'resignature_request_from_university';
        } else {
            // User clicked "Cancel" (No, send to committees)
            hiddenInput.value = 'approvedbyqachead_revised';
        }

         // Draw text onto the signature canvas before submitting
            var ctx = canvas.getContext('2d');
            var signerName = document.getElementById('signer_name').value;
            var currentDate = new Date().toLocaleDateString('en-GB');
            ctx.font = '14px "Helvetica", "Arial", sans-serif';
            ctx.fillStyle = '#000';
            ctx.textAlign = 'left';
            ctx.fillText(`Signed by: ${signerName} on ${currentDate}`, 10, 140);
            
            // Save the signature data to the hidden input
            document.getElementById('signature_image').value = signaturePad.toDataURL();
            
            // Finally, submit the form
            form.submit();
    

   
    }

    // Add an event listener to the form's submit event
    document.querySelector('form').addEventListener('submit', function (event) {
        // Find out which button was clicked to submit the form
        const submitter = event.submitter;

        // If for some reason there's no submitter, stop.
        if (!submitter) {
            event.preventDefault();
            return;
        }

        // =====================================================================
        //  STEP 1: Determine if the action is an "Approval"
        // =====================================================================
        let isApprovalAction = false;

        // Check the standard 'Approve' button
        if (submitter.name === 'approve') {
            isApprovalAction = true;
        } 
        // Check the Director's special buttons
        else if (submitter.name === 'director_action') {
            // This is an approval if the button's value contains "approved"
            if (submitter.value.includes('approved')) {
                isApprovalAction = true;
            }
        }
        // =====================================================================


        // =====================================================================
        //  STEP 2: Run validation ONLY if the action is an approval
        // =====================================================================
        if (isApprovalAction) {
            
            // Check 1: Is the endorsement checkbox ticked?
            if (!document.getElementById('recommend').checked) {
                alert('Please check the endorsement box to confirm your action.');
                event.preventDefault(); // Stop form submission
                return; 
            }

            // Check 2: Is the signature pad empty?
            if (signaturePad.isEmpty()) {
                alert("Please provide your digital signature to complete the approval.");
                event.preventDefault(); // Stop form submission
                return;
            }

            // If all checks pass, draw text and save the signature data
            var ctx = canvas.getContext('2d');
            var signerName = document.getElementById('signer_name').value;
            var currentDate = new Date().toLocaleDateString('en-GB');

            ctx.font = '14px "Helvetica", "Arial", sans-serif';
            ctx.fillStyle = '#000';
            ctx.textAlign = 'left';
            
            ctx.fillText(`Signed by: ${signerName} on ${currentDate}`, 10, 140);
            
            document.getElementById('signature_image').value = signaturePad.toDataURL();
        }
        // =====================================================================
        
        // If 'isApprovalAction' is false (i.e., it's a rejection), 
        // the code above is skipped and the form submits without validation.
    });
</script>

<!-- NEW CODE START: SCRIPT FOR APPROVAL BUTTON VALIDATION -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // This script only runs if a user who can edit the summary is on the page.
    const summaryPane = document.querySelector('.summary-pane');
    const approveButtons = document.querySelectorAll('.btn-approve');
    
    // If the summary pane or approve buttons don't exist, exit the script.
    if (!summaryPane || approveButtons.length === 0) {
        return;
    }

    const totalItemsInput = document.getElementById('total_review_items');
    // If the hidden input for total items doesn't exist, something is wrong, so we also exit.
    if (!totalItemsInput) {
        return;
    }
    const totalItems = parseInt(totalItemsInput.value, 10);

    function checkSummaryCompletion() {
        // If there are no items to review, the buttons should be enabled by default.
        if (totalItems === 0) {
            approveButtons.forEach(btn => btn.disabled = false);
            return;
        }

        // Count all the radio buttons that have been checked inside the summary pane.
        const checkedRadios = summaryPane.querySelectorAll('.review-controls .form-check-input[type="radio"]:checked').length;
        
        // The review is complete if the number of checked radios equals the total number of items.
        const isComplete = (checkedRadios >= totalItems);

        // Loop through all approve buttons and enable/disable them.
        approveButtons.forEach(btn => {
            if (isComplete) {
                btn.disabled = false;
                btn.title = 'Ready to approve.';
                btn.classList.remove('disabled'); // Bootstrap visual cue
            } else {
                btn.disabled = true;
                btn.title = 'Please review all items in the summary sheet to enable this action.';
                btn.classList.add('disabled'); // Bootstrap visual cue
            }
        });
    }

    // Add a single event listener to the summary pane to efficiently catch all radio button changes.
    summaryPane.addEventListener('change', function(event) {
        // We only care about changes to our radio buttons.
        if (event.target.matches('.review-controls .form-check-input[type="radio"]')) {
            checkSummaryCompletion();
        }
    });

    // Run the check once when the page first loads to set the initial state of the buttons.
    checkSummaryCompletion();
});
</script>
<!-- NEW CODE END -->



</body>
</html>
