<?php
session_start();
require 'databaseconnection.php'; // Database connection
//Debug session data (remove after testing)
//echo "<pre>";
//print_r($_SESSION);
//echo "</pre>";

// Ensure the user is logged in and has a valid UGC role
if (!isset($_SESSION['role']) || !isset($_SESSION['username']) || !isset($_SESSION['id'])) {
    die("Access Denied. Please login.");
}

$role = strtolower(trim($_SESSION['role']));
$username = $_SESSION['username']; // Logged-in user's username
$user_id = $_SESSION['id']; // User ID for tracking approvals

// Ensure user is from UGC
$ugc_roles = [
    "program coordinator of the university" => "submitted",
    "dean" => "approvedbydean",
    "vice chancellor" => "approvedbyvc",
    "cqa director" => "approvedbycqa",
    "head of the qac-ugc department" => "approvedbyqachead",
    "ugc - finance department" => "approvedbyugcfinance",
    "ugc - hr department" => "approvedbyugchr",
    "ugc - idd department" => "approvedbyugcidd",
    //"ugc - legal department" => "approvedbyugclegal",
    "ugc - academic department" => "approvedbyugcacademic",
    "ugc - admission department" => "approvedbyugcadmission",
    "ugc - technical assistant" => "approvedbyTA",
    "ugc - secretary" => "approvedbysecretary",
    "standard committee" => "approvedbystandardcommittee"
];
// Normalize the Dean's role
if (strpos($role, 'dean') !== false) {
    $role = 'dean';
}

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
$proposalQuery = "SELECT proposal_code, status, created_at, updated_at, submitted_at FROM proposals WHERE proposal_id = ?";
$stmt = $connection->prepare($proposalQuery);
$stmt->bind_param("i", $proposal_id);
$stmt->execute();
$proposal = $stmt->get_result()->fetch_assoc();
$stmt->close();


// Fetch previous approvals from proposal_comments table
$commentQuery = "SELECT id, proposal_status, comment, seal_and_sign, Date
FROM proposal_comments 
WHERE proposal_id = ? AND proposal_status IN ('approvedbyStandardCommitte','approvedbyqachead','approvedbydean','approvedbyvc','approvedbycqa')
ORDER BY id ASC";


$stmt = $connection->prepare($commentQuery);
$stmt->bind_param("i", $proposal_id);
$stmt->execute();
$result = $stmt->get_result();
$comments = $result->fetch_all(MYSQLI_ASSOC);

//  Ensure $comments is always an array (to prevent foreach() errors)
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
define("UPLOADS_DIR", "http://localhost/qac_ugc/Proposal_sections/uploads/");


// Function to format file URLs correctly
function formatValue($value) {
    // If the value contains "Proposal_sections/uploads/" and is a PDF, format it as a clickable link
    if (strpos($value, "Proposal_sections/uploads/") !== false && preg_match('/\.pdf$/i', $value)) {
        return "<a href='" . UPLOADS_DIR . basename($value) . "' target='_blank'>View File</a>";
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

     <!-- Download PDF & Back Button (Hidden in PDF) -->
<div class="no-print d-flex gap-2 mt-3">
    <form action="generate_final_proposal.php" method="GET">
        <input type="hidden" name="id" value="<?php echo $proposal_id; ?>">
        <button type="submit" class="btn btn-success">Download as PDF</button>
    </form>
</div>

    <h3 class = "text-center text-primary">Application for Approval of New Undergraduate Degree Programme (Internal)</h3>
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
                        elseif ($comment['proposal_status'] === 'approvedbyqachead') echo "Head of the QAC-UGC Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugcfinance') echo "UGC - Finance Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugchr') echo "UGC - HR Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugcidd') echo "UGC - IDD Department";
                        //elseif ($comment['proposal_status'] === 'approvedbyugclegal') echo "UGC - Legal Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugcacademic') echo "UGC - Academic Department";
                        elseif ($comment['proposal_status'] === 'approvedbyugcadmission') echo "UGC - Admission Department";
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

  

    


</body>
</html>
