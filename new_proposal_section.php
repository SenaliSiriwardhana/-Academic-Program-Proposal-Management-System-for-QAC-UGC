<?php
session_start();

require 'databaseconnection.php';

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
        if ($section === 'program_structure' || $section === 'program_content') {
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
                    $array_fields = ['medium_of_instruction', 'slqf_level', 'fallback_qualification'];
                    
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

        if ($section === 'panel_of_teachers') {
            $_SESSION[$section] = [];
        
            // Clear existing session data to prevent duplication
            if (!isset($_SESSION[$section]) || empty($_SESSION[$section])) {
                while ($row = $result->fetch_assoc()) {
                    // Check if this teacher already exists in session to prevent duplicates
                    $exists = false;
                    foreach ($_SESSION[$section] as $existingRow) {
                        if ($existingRow['teacher_id'] === $row['teacher_id']) { // Change 'teacher_id' based on your table schema
                            $exists = true;
                            break;
                        }
                    }
        
                    if (!$exists) {
                        $_SESSION[$section][] = $row;
                    }
                }
            }
        
            if (count($_SESSION[$section]) > 0) {
                $_SESSION['status_' . $section] = 'Completed';
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
                $_SESSION['program_entity']["evidence_{$key}"] = '/qac_ugc/' . $row['evidence'];
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
}

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
    </style>
</head>
<body>
    <div class="container mt-5">
        <!--<pre><?php echo print_r($_SESSION); ?></pre>-->
        <h3><?php echo $isEditing ? 'Edit Proposal: #' : 'New Proposal: #'; echo $_SESSION['proposal_id'] ?></h3>
        <p>Please complete all sections before submitting the proposal.</p>
            <ul class="section-list">
            <li>
                <span>1. General Information</span>
                <span>
                    
                    <span class="badge <?php echo $badgeClass1; ?>"><?php echo $statusGeneralInfo; ?></span>
                    <a href="Proposal_sections/general_info.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>2. Program Offering Entity</span>
                <span>
                    <span class="badge <?php echo $badgeClass2; ?>"><?php echo $statusprogramentity; ?></span>
                    <a href="Proposal_sections/program_entity.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>3. Details of the Degree Program</span>
                <span>
                    <span class="badge <?php echo $badgeClass3; ?>"><?php echo $statusdegreeDetails; ?></span>
                    <a href="Proposal_sections/degree_details.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>4. Program Structure</span>
                <span>
                <span class="badge <?php echo $badgeClass4; ?>"><?php echo $statusprogramStructure; ?></span>
                    <a href="Proposal_sections/program_structure.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>5. Program Content</span>
                <span>
                    <span class="badge <?php echo $badgeClass5; ?>"><?php echo $statusprogramContent; ?></span>
                    <a href="Proposal_sections/program_content.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>6. Program Delivery and Learner Support System</span>
                <span>
                    <span class="badge <?php echo $badgeClass6; ?>"><?php echo $statusprogramDelivery; ?></span>
                    <a href="Proposal_sections/program_delivery.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>7. Program Assessment Procedure/Rules</span>
                <span>
                    <span class="badge <?php echo $badgeClass7; ?>"><?php echo $statusAssessmentRules; ?></span>
                    <a href="Proposal_sections/assessment_rules.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>8. Resource Requirements</span>
                <span>
                    <span class="badge <?php echo $badgeClass8; ?>"><?php echo $statusresourceRequirements; ?></span>
                    <a href="Proposal_sections/resource_requirements.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>9. Panel of Teachers</span>
                <span>
                    <span class="badge <?php echo $badgeClass9; ?>"><?php echo $statuspanelofTeachers; ?></span>
                    <a href="Proposal_sections/panel_of_teachers.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>10. Reviewers Report</span>
                <span>
                    <span class="badge <?php echo $badgeClass10; ?>"><?php echo $statusreviewersReport; ?></span>
                    <a href="Proposal_sections/reviewers_report.php" class="btn btn-primary btn-sm btn-section">Fill</a>
                </span>
            </li>
            <li>
                <span>11. Compliance Check </span>
                <span>
                <span class="badge <?php echo $badgeClass11; ?>"><?php echo $statusComplianceCheck; ?></span>
                    <a href="Proposal_sections/compliance_check.php" class="btn btn-primary btn-sm btn-section">Fill</a>
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



</body>
</html>
