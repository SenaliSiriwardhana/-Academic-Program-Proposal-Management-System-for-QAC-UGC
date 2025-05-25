<?php
// Start the session
session_start();


// Function to handle file uploads - Global handle for common use to each switch cases.
function handleFileUpload($fileKey , $sessionKey) {
    $uploadDir = __DIR__ . '/uploads/';  // Ensure the correct directory path
    $uploadUrl = '/qac_ugc/Proposal_sections/uploads/'; // Public URL

     // DEBUG: Log directory path
    error_log("Upload Directory: " . $uploadDir);
    
    // Ensure the uploads directory exists
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    // Check if a new file is uploaded
    if (!empty($_FILES[$fileKey]['name'])) {
        // Get the old file path from the session
        $oldFileUrl = $_SESSION[$sessionKey][$fileKey] ?? '';
        $oldFilePath = str_replace($uploadUrl, $uploadDir, $oldFileUrl); // Convert URL to file path
    }

        // If an old file exists, delete it
        if (!empty($oldFilePath) && file_exists($oldFilePath)) {
            unlink($oldFilePath);
        }

    if (!empty($_FILES[$fileKey]['name'])) {
        if ($_FILES[$fileKey]['error'] !== UPLOAD_ERR_OK) {
            error_log("File Upload Error ({$fileKey}): " . $_FILES[$fileKey]['error']);
            return $_SESSION[$sessionKey][$fileKey] ?? ''; // Keep previous file if new one fails
        }

        $fileName = time() . "_" . basename($_FILES[$fileKey]["name"]); // Add timestamp to avoid overwriting
        $filePath = $uploadDir . $fileName;
        $fileUrl = $uploadUrl . $fileName;   // Web-accessible URL

        if (move_uploaded_file($_FILES[$fileKey]["tmp_name"], $filePath)) {
            return $fileUrl;
        } else {
            error_log("Failed to move uploaded file ({$fileKey}).");
            return $_SESSION[$sessionKey][$fileKey] ?? ''; // Keep previous file
        }
    }
    return $_SESSION[$sessionKey][$fileKey] ?? ''; // Keep previous file if no new upload
}

// Check if the form is submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Determine the type of form submitted
    $formType = $_POST['form_type'] ?? '';

    switch ($formType) {
        case 'assessment_rules':
            // Retrieve assessment rules form data
            $FSExamination = $_POST['formative_summative'] ?? '';
            $gradingSystem = $_POST['grading_scheme'] ?? '';
            $GPA = $_POST['gpa_calculation'] ?? '';
            $Contributionsem = $_POST['semester_contribution'] ?? '';
            $Contributiontraining = $_POST['inplant_training'] ?? '';
            $RepeatExam = $_POST['repeat_exams'] ?? '';
            $ReqDegree = $_POST['degree_requirements'] ?? '';
            $ReqClass = $_POST['class_requirements'] ?? '';

            // Save the data in session (replace with database logic if needed)
            $_SESSION['assessment_rules'] = [
                'formative_summative' => $FSExamination,
                'grading_scheme' => $gradingSystem,
                'gpa_calculation' => $GPA,
                'semester_contribution' => $Contributionsem,
                'inplant_training' => $Contributiontraining,
                'repeat_exams' => $RepeatExam,
                'degree_requirements' => $ReqDegree,
                'class_requirements' => $ReqClass,
            ];

            // Check if all fields are empty
            if (empty($FSExamination) && empty($gradingSystem) && empty($GPA) && empty($Contributionsem) && 
            empty($Contributiontraining) && empty($RepeatExam) && empty($ReqDegree) && empty($ReqClass)) {
                $_SESSION['status_assessment_rules'] = 'Not Started';
                unset($_SESSION['assessment_rules']);
            } else {
                $_SESSION['status_assessment_rules'] = 'Completed';
            }
            break;

        case 'general_info':
            // Retrieve general information form data
            $degreeNameEnglish = $_POST['degree_name_english'] ?? '';
            $degreeNameSinhala = $_POST['degree_name_sinhala'] ?? '';
            $degreeNameTamil = $_POST['degree_name_tamil'] ?? '';
            $quaNameEnglish = $_POST['qua_name_english'] ?? '';
            $quaNameSinhala = $_POST['qua_name_sinhala'] ?? '';
            $quaNameTamil = $_POST['qua_name_tamil'] ?? '';
            $abbreviatedQualification = $_POST['abbreviated_qualification_english'] ?? '';

            // Save the data (temporarily using session; replace with database logic if needed)
            $_SESSION['general_info'] = [
                'degree_name_english' => $degreeNameEnglish,
                'degree_name_sinhala' => $degreeNameSinhala,
                'degree_name_tamil' => $degreeNameTamil,
                'qua_name_english' => $quaNameEnglish,
                'qua_name_sinhala' => $quaNameSinhala,
                'qua_name_tamil' => $quaNameTamil,
                'abbreviated_qualification' => $abbreviatedQualification,
            ];

            // Check if all fields are empty
            if (empty($degreeNameEnglish) && empty($degreeNameSinhala) && empty($degreeNameTamil) && empty($quaNameEnglish) && empty($quaNameSinhala) && empty($quaNameTamil) && empty($abbreviatedQualification)) {
                $_SESSION['status_general_info'] = 'Not Started';
                unset($_SESSION['general_info']);
            } else {
                $_SESSION['status_general_info'] = 'Completed';
            }
            header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;

                         
            case 'compliance_check':
                         
            // Process form data
            $_SESSION['compliance_check'] = [
                    'resources_commence' => $_POST['resources_commence'] ?? '',
                    'fallback_options' => $_POST['fallback_options'] ?? '',
                    'fallback_qualification' => isset($_POST['fallback_qualification']) ? (array) $_POST['fallback_qualification'] : [],
                    'collaboration' => $_POST['collaboration'] ?? '',
                    'collaboration_details' => ($_POST['collaboration'] === 'Yes') ? ($_POST['collaboration_details'] ?? '') : '',
                    'access_facilities' => $_POST['access_facilities'] ?? '',
                    'professional_membership' => $_POST['professional_membership'] ?? '',

             // Store previous file path if new one is not uploaded
                    'fallback_attachment' => handleFileUpload('fallback_attachment','compliance_check'),
                    'collaboration_attachment' => handleFileUpload('collaboration_attachment','compliance_check'),
                    'access_facilities_attachment' => handleFileUpload('access_facilities_attachment','compliance_check'),
                    'membership_attachment' => handleFileUpload('membership_attachment','compliance_check'),
                    ];

            // Remove file fields from validation check
            $complianceDataWithoutFiles = $_SESSION['compliance_check'];
                    unset($complianceDataWithoutFiles['fallback_attachment']);
                    unset($complianceDataWithoutFiles['collaboration_attachment']);
                    unset($complianceDataWithoutFiles['access_facilities_attachment']);
                    unset($complianceDataWithoutFiles['membership_attachment']);

            // If collaboration is "No", ignore `collaboration_details`
            if ($_SESSION['compliance_check']['collaboration'] === 'No') {
                    unset($complianceDataWithoutFiles['collaboration_details']);
            }
            
            // Check if all non-file fields are empty
            if (empty(array_filter($complianceDataWithoutFiles, fn($value) => !empty($value)))) {
                $_SESSION['status_compliance_check'] = 'Not Started';
                unset($_SESSION['compliance_check']);
            }else {
                $_SESSION['status_compliance_check'] = 'Completed';
            }
            header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;

        case 'degree_details':
                session_start();
            
                // Store degree details in session (replace with database logic if needed)
                $_SESSION['degree_details'] = [
                    'background_to_program' => $_POST['background_to_program'] ?? '',
                    'mandate_faculty' => $_POST['mandate_faculty'] ?? '',
                    'faculty_status' => $_POST['faculty_status'] ?? '',
                    'student_intake' => $_POST['student_intake'] ?? '',
                    'staff_cadres' => $_POST['staff_cadres'] ?? '',
                    'educational_facilities' => $_POST['educational_facilities'] ?? '',
                    'common_facilities' => $_POST['common_facilities'] ?? '',
                    'program_benefits' => $_POST['program_benefits'] ?? '',
                    'rec_in_review_report' => $_POST['rec_in_review_report'] ?? '',
                    'degree_details_justification' => handleFileUpload('degree_details_justification','degree_details'), // Handle file upload
                    'degree_details_objective' => handleFileUpload('degree_details_objective','degree_details'), // Handle file upload
                    'eligibility_req' => $_POST['eligibility_req'] ?? '',
                    'indicate_program' => $_POST['indicate_program'] ?? '',
                    'admission_process' => isset($_POST['admission_process']) ? 'UGC Z score based selection' : '',
                    'other_criteria' => $_POST['other_criteria'] ?? '',
                    'intake' => $_POST['intake'] ?? '',
                    'degree_type' => $_POST['degree_type'] ?? '',
                    'duration' => $_POST['duration'] ?? '',
                    'coursework_credits' => $_POST['coursework_credits'] ?? '',
                    'thesis_credits' => $_POST['thesis_credits'] ?? '',
                    'total_credits' => $_POST['total_credits'] ?? '',
                    'subject_benchmark' => handleFileUpload('subject_benchmark','degree_details'), // Handle file upload
                    'medium_of_instruction' => [
                        '0' => isset($_POST['mediumOfInstructionEnglish']) ? 'English' : '',
                        '1' => isset($_POST['mediumOfInstructionSinhala']) ? 'Sinhala' : '',
                        '2' => isset($_POST['mediumOfInstructionTamil']) ? 'Tamil' : ''
                    ],
                    'slqf_level' => [
                        '0' => isset($_POST['targetedSlqfLevel5']) ? 'Level 5 (Bachelors)' : '',
                        '1' => isset($_POST['targetedSlqfLevel6']) ? 'Level 6 (Bachelors Honours - 4 year programme)' : '',
                    ],

                    'slqf_filled' => [
                        '0' => isset($_POST['slqf_fullfilled_yes']) ? 'Yes' : '',
                        '1' => isset($_POST['slqf_fullfilled_no']) ? 'No' : '',
                    ],

                    'program_reviews' => []
                ];
            
                // Handle dynamic table data (Grades Received at Program Reviews)
                if (!empty($_POST['program_name']) && !empty($_POST['program_year']) && !empty($_POST['program_grade'])) {
                    for ($i = 0; $i < count($_POST['program_name']); $i++) {
                        $_SESSION['degree_details']['program_reviews'][] = [
                            'program_name' => $_POST['program_name'][$i] ?? '',
                            'program_year' => $_POST['program_year'][$i] ?? '',
                            'program_grade' => $_POST['program_grade'][$i] ?? '',
                        ];
                    }
                }
            
                // Check if all fields are empty
                if (empty(array_filter($_SESSION['degree_details'], function ($value) {
                    return !empty($value);
                }))) {
                    $_SESSION['status_degree_details'] = 'Not Started';
                    unset($_SESSION['degree_details']);
                } else {
                    $_SESSION['status_degree_details'] = 'Completed';
                }
            
                header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;
            
        case 'panel_of_teachers':
                session_start();
            
                // Store panel of teachers' data in session
                $_SESSION['panel_of_teachers'] = [];
            
                if (!empty($_POST['lecturer_name'])) {
                    for ($i = 0; $i < count($_POST['lecturer_name']); $i++) {
                        $_SESSION['panel_of_teachers'][] = [
                            'lecturer_name' => $_POST['lecturer_name'][$i] ?? '',
                            'designation' => $_POST['designation'][$i] ?? '',
                            'internal_ug_hours' => $_POST['internal_ug_hours'][$i] ?? 0,
                            'internal_pg_hours' => $_POST['internal_pg_hours'][$i] ?? 0,
                            'external_ug_hours' => $_POST['external_ug_hours'][$i] ?? 0,
                            'external_pg_hours' => $_POST['external_pg_hours'][$i] ?? 0,
                            'proposed_program_hours' => $_POST['proposed_program_hours'][$i] ?? 0,
                            'total_hours' => ($_POST['internal_ug_hours'][$i] ?? 0) +
                                             ($_POST['internal_pg_hours'][$i] ?? 0) +
                                             ($_POST['external_ug_hours'][$i] ?? 0) +
                                             ($_POST['external_pg_hours'][$i] ?? 0) +
                                             ($_POST['proposed_program_hours'][$i] ?? 0)
                        ];
                    }
                }
            
                // Check if all fields are empty
                if (empty($_SESSION['panel_of_teachers'])) {
                    $_SESSION['status_panel_of_teachers'] = 'Not Started';
                    unset($_SESSION['panel_of_teachers']);
                } else {
                    $_SESSION['status_panel_of_teachers'] = 'Completed';
                }
                header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;

            case 'program_content':
                session_start();
            
                // Store program content data in session
                $_SESSION['program_content'] = [];
            
                if (!empty($_POST['module_code'])) {
                    for ($i = 0; $i < count($_POST['module_code']); $i++) {
                        $_SESSION['program_content'][] = [
                            'semester' => $_POST['semester'][$i] ?? '',
                            'module_code' => $_POST['module_code'][$i] ?? '',
                            'module_name' => $_POST['module_name'][$i] ?? '',
                            'credit_value' => $_POST['credit_value'][$i] ?? 0,
                            'core_optional' => $_POST['core_optional'][$i] ?? '',
                            'lecture_hours' => $_POST['lecture_hours'][$i] ?? 0,
                            'practical_hours' => $_POST['practical_hours'][$i] ?? 0,
                            'independent_hours' => $_POST['independent_hours'][$i] ?? 0,
                            'learning_outcomes' => $_POST['learning_outcomes'][$i] ?? '',
                            'module_content' => $_POST['module_content'][$i] ?? '',
                            'teaching_methods' => $_POST['teaching_methods'][$i] ?? '',
                            'continuous_assessment_percentage' => $_POST['continuous_assessment_percentage'][$i] ?? 0,
                            'final_assessment_percentage' => $_POST['final_assessment_percentage'][$i] ?? 0,
                            'recommended_reading' => $_POST['recommended_reading'][$i] ?? '',
                            
                        ];
                    }
                }
            
                // Debugging: Log saved session data
                error_log("Session Data: " . print_r($_SESSION['program_content'], true));

                // Check if all fields are empty
                if (empty($_SESSION['program_content'])) {
                    $_SESSION['status_program_content'] = 'Not Started';
                    unset($_SESSION['program_content']);
                } else {
                    $_SESSION['status_program_content'] = 'Completed';
                }
            
                // Redirect back to the main proposal section
                header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;
            
        case 'program_delivery':
                session_start();
            
                // Store program delivery data in session
                $_SESSION['program_delivery'] = [
                    'program_delivery_description' => $_POST['program_delivery_description'] ?? ''
                ];
            
                // Check if all fields are empty
                if (empty($_SESSION['program_delivery']['program_delivery_description'])) {
                    $_SESSION['status_program_delivery'] = 'Not Started';
                    unset($_SESSION['program_delivery']);
                } else {
                    $_SESSION['status_program_delivery'] = 'Completed';
                }
            
                // Redirect back to the main proposal section
                header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;

        case 'program_entity':
                session_start();
            
                                           
                // Store program entity data in session
                $_SESSION['program_entity'] = [
                    'university' => $_POST['university'] ?? '',
                    'faculty' => $_POST['faculty'] ?? '',
                    'department' => $_POST['department'] ?? '',
                    
                    // Mandate Availability
                    'ref_corporate_plan' => $_POST['ref_corporate_plan'] ?? '',
                    'date_corporate_plan' => $_POST['date_corporate_plan'] ?? '',
                    'evidence_corporate_plan' => handleFileUpload('evidence_corporate_plan','program_entity'),
            
                    'ref_action_plan' => $_POST['ref_action_plan'] ?? '',
                    'date_action_plan' => $_POST['date_action_plan'] ?? '',
                    'evidence_action_plan' => handleFileUpload('evidence_action_plan','program_entity'),

                    'ref_faculty_approval' => $_POST['ref_faculty_approval'] ?? '',
                    'date_faculty_approval' => $_POST['date_faculty_approval'] ?? '',
                    'evidence_faculty_approval' => handleFileUpload('evidence_faculty_approval','program_entity'),
            
                    'ref_senate_approval' => $_POST['ref_senate_approval'] ?? '',
                    'date_senate_approval' => $_POST['date_senate_approval'] ?? '',
                    'evidence_senate_approval' => handleFileUpload('evidence_senate_approval','program_entity'),
            
                    'ref_council_approval' => $_POST['ref_council_approval'] ?? '',
                    'date_council_approval' => $_POST['date_council_approval'] ?? '',
                    'evidence_council_approval' => handleFileUpload('evidence_council_approval','program_entity'),
                ];
            
                //  Ensure status is updated correctly
                if (!empty($_SESSION['program_entity']['faculty']) || !empty($_SESSION['program_entity']['department'])) {
                    $_SESSION['status_program_entity'] = 'Completed';
                } else {
                    $_SESSION['status_program_entity'] = 'Not Started';
                    unset($_SESSION['program_entity']);
                }
            
                // Redirect back to the main proposal section
                header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;
            
        case 'program_structure':
                session_start();
            
                // Store program structure data in session
                $_SESSION['program_structure'] = [];
            
                if (!empty($_POST['module_code'])) {
                    for ($i = 0; $i < count($_POST['module_code']); $i++) {
                        $_SESSION['program_structure'][] = [
                            'semester' => $_POST['semesters'][$i] ?? '',
                            'module_code' => $_POST['module_code'][$i] ?? '',
                            'module_name' => $_POST['module_name'][$i] ?? '',
                            'credit_value' => $_POST['credit_value'][$i] ?? 0,
                            'module_status' => $_POST['module_status'][$i] ?? '',
                            'module_type' => $_POST['module_type'][$i] ?? '',
                            'qualifier1_related' => $_POST['qualifier1_related'][$i],
                            'qualifier2_related' => $_POST['qualifier2_related'][$i],
                        ];
                    }
                }
            
                // Debugging: Log saved session data (optional)
                error_log("Session Data (Program Structure): " . print_r($_SESSION['program_structure'], true));
            
                // Check if all fields are empty
                if (empty($_SESSION['program_structure'])) {
                    $_SESSION['status_program_structure'] = 'Not Started';
                    unset($_SESSION['program_structure']);
                } else {
                    $_SESSION['status_program_structure'] = 'Completed';
                }
            
                // Redirect back to the main proposal section
                header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;

        case 'resource_requirements':
                session_start();
            
                // Ensure the session array exists and retains previous values
                if (!isset($_SESSION['resource_requirements'])) {
                    $_SESSION['resource_requirements'] = [];
                }
            
                // Define the resource types and their field patterns
                $physical_resources = range(0, 8); // 9 physical resources
                $financial_resources = range(0, 1); // 2 financial resources
                $staff_resources = range(0, 4); // 5 staff resources
            
                // Function to retain previous values if form fields are empty
                function retain_previous($key) {
                    return $_POST[$key] ?? ($_SESSION['resource_requirements'][$key] ?? '');
                }
            
                // Handle Physical Resources

                 
                 $physical_resources = [
                    "Land extent (Acre/Hectare)",
                    "Office Space",
                    "No. of Lecture Theatres",
                    "No. of Laboratories",
                    "No. of Computers with Internet Facilities",
                    "Reading Rooms/Halls",
                    "Staff Common Rooms/Amenities",
                    "Student Common Rooms/Amenities",
                    "Other"
                ];
                
                foreach ($physical_resources as $index => $resource ) {
                    $key = strtolower(str_replace([' ', '/', '.'], '_', $resource));
                    $_SESSION['resource_requirements']["physical_type_$index"] = retain_previous("physical_type_$index");
                    $_SESSION['resource_requirements'][$key . "_existing"] = retain_previous($key . "_existing");
                    $_SESSION['resource_requirements'][$key . "_year1"] = retain_previous($key . "_year1");
                    $_SESSION['resource_requirements'][$key . "_year2"] = retain_previous($key . "_year2");
                    $_SESSION['resource_requirements'][$key . "_year3"] = retain_previous($key . "_year3");
                    $_SESSION['resource_requirements'][$key . "_year4"] = retain_previous($key . "_year4");
                }
            
               // Handle Financial Resources

                $financial_resources = [
                        "Capital Expenditure",
                        "Recurrent Expenditure"
                
                ];
                foreach ($financial_resources as $index  => $resource ) {
                    $key = strtolower(str_replace([' ', '/', '.'], '_', $resource));
                    $_SESSION['resource_requirements']["financial_type_$index"] = retain_previous("financial_type_$index");
                    $_SESSION['resource_requirements'][$key . "_year1"] = retain_previous($key . "_year1");
                    $_SESSION['resource_requirements'][$key . "_year2"] = retain_previous($key . "_year2");
                    $_SESSION['resource_requirements'][$key . "_year3"] = retain_previous($key . "_year3");
                    $_SESSION['resource_requirements'][$key . "_year4"] = retain_previous($key . "_year4");
                }
            
                // Define staff_resources as an array of resource names
                $staff_resources = ["Lecturers", "Instructors/Demonstrators", "Technical Grades", "Management Assistants", "Minor Staff"];

                foreach ($staff_resources as $index => $resource) {
                // Generate the same key as in the form
                    $key = strtolower(str_replace([' ', '/', '.'], '_', $resource));
                    $_SESSION['resource_requirements']["staff_type_$index"] = retain_previous("staff_type_$index");
                    $_SESSION['resource_requirements'][$key . "_year1"] = retain_previous($key . "_year1");
                    $_SESSION['resource_requirements'][$key . "_year2"] = retain_previous($key . "_year2");
                    $_SESSION['resource_requirements'][$key . "_year3"] = retain_previous($key . "_year3");
                    $_SESSION['resource_requirements'][$key . "_year4"] = retain_previous($key . "_year4");
                    }

            
                // Update status
                if (empty(array_filter($_SESSION['resource_requirements'], fn($value) => !empty($value)))) {
                    $_SESSION['status_resource_requirements'] = 'Not Started';
                    unset($_SESSION['resource_requirements']);
                } else {
                    $_SESSION['status_resource_requirements'] = 'Completed';
                }
            
                header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
            break;
            
            

       
        case 'reviewers_report':
                    session_start();
                // Store Review Aspects and Recommendations in session
                    $_SESSION['reviewers_report'] = [
                    'main_acceptability' => $_POST['main_acceptability'] ?? '',
                    'fallback_acceptability' => $_POST['fallback_acceptability'] ?? '',
                    'main_relevance' => $_POST['main_relevance'] ?? '',
                    'fallback_relevance' => $_POST['fallback_relevance'] ?? '',
                    'main_entry_qualification' => $_POST['main_entry_qualification'] ?? '',
                    'fallback_entry_qualification' => $_POST['fallback_entry_qualification'] ?? '',
                    'main_structure' => $_POST['main_structure'] ?? '',
                    'fallback_structure' => $_POST['fallback_structure'] ?? '',
                    'main_content' => $_POST['main_content'] ?? '',
                    'fallback_content' => $_POST['fallback_content'] ?? '',
                    'main_methods' => $_POST['main_methods'] ?? '',
                    'fallback_methods' => $_POST['fallback_methods'] ?? '',
                    'main_procedure' => $_POST['main_procedure'] ?? '',
                    'fallback_procedure' => $_POST['fallback_procedure'] ?? '',
                    'main_availability' => $_POST['main_availability'] ?? '',
                    'fallback_availability' => $_POST['fallback_availability'] ?? '',
                    'main_qualifications' => $_POST['main_qualifications'] ?? '',
                    'fallback_qualifications' => $_POST['fallback_qualifications'] ?? '',
                    'main_recommended_reading' => $_POST['main_recommended_reading'] ?? '',
                    'fallback_recommended_reading' => $_POST['fallback_recommended_reading'] ?? '',
                    'main_recommendation' => $_POST['main_recommendation'] ?? '',
                    'fallback_recommendation' => $_POST['fallback_recommendation'] ?? '',
                   
                
                // Reviewer Recommendations
                    //'main_recommendation' => $_POST['main_recommendation'] ?? '',
                
                // Reviewer 1 Details
                    'reviewer1_name' => $_POST['reviewer1_name'] ?? '',
                    'reviewer1_designation' => $_POST['reviewer1_designation'] ?? '',
                    'reviewer1_qualification' => $_POST['reviewer1_qualification'] ?? '',
                    'reviewer1_signature' => $_POST['reviewer1_signature'] ?? '',
                    'reviewer1_date' => $_POST['reviewer1_date'] ?? '',
                
                // Reviewer 2 Details
                    'reviewer2_name' => $_POST['reviewer2_name'] ?? '',
                    'reviewer2_designation' => $_POST['reviewer2_designation'] ?? '',
                    'reviewer2_qualification' => $_POST['reviewer2_qualification'] ?? '',
                    'reviewer2_signature' => $_POST['reviewer2_signature'] ?? '',
                    'reviewer2_date' => $_POST['reviewer2_date'] ?? '',
                    ];

                   
                    // Check if **any** required field is missing
                        if (in_array('', $_SESSION['reviewers_report'], true)) {
                        $_SESSION['status_reviewers_report'] = 'Not Started';
                        unset($_SESSION['reviewers_report']); // Remove partial data to ensure completeness
                         } else {
                        $_SESSION['status_reviewers_report'] = 'Completed';
                    }
                
                    // Redirect back to the main proposal section
                    header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
                       
                break;
            
    
        default:
            echo "Invalid form type.";
            exit();
    }

    // Redirect back to the main proposal section
    header($_SESSION['is_editing'] ? 'Location: /qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  'Location: /qac_ugc/new_proposal_section.php');
    exit();
} else {
    // Invalid request method
    echo "Invalid request method.";
    exit();
}
?>





