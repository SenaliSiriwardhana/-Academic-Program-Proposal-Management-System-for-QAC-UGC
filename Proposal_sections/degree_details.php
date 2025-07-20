<?php
session_start();
include 'form_field_helper.php';

// Retrieve saved data (if available)
$degreeDetails = $_SESSION['degree_details'] ?? [
    'background_to_program' => '',
    'mandate_faculty' => '',
    'faculty_status' => '',
    'student_intake' => '',
    'staff_cadres' => '',
    'educational_facilities' => '',
    'common_facilities' => '',
    'program_benefits' => '',
    'rec_in_review_report'  => '',
    'degree_details_justification'  => '',
    'degree_details_objective'  => '',
    'eligibility_req' => '',
    'indicate_program' => '',
    'addmission_process' => '',
    'other_criteria' => '',
    'intake' => '',
    'degree_type' => '',
    'duration' => '',
    'coursework_credits' => '',
    'thesis_credits' => '',
    'total_credits' => '',
    'medium_of_instruction' => '',
    'subject_benchmark' => '',
    'slqf_level' => [],
    'slqf_filled'=> [],
    'program_reviews' => []
];


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Details of the Degree Program</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 50px;
        }
        .form-header {
            background-color: #007bff;
            color: white;
            padding: 15px;
            border-radius: 10px 10px 0 0;
            text-align: center;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .form-label {
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }
        .form-footer {
            margin-top: 20px;
            text-align: right;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container mx-auto" style="max-width: 800px;">
            <div class="form-header">
                <h3>Section 3: Details of the Degree Program</h3>
            </div>

            <p class="mt-3">Please provide detailed information about the degree program below.</p>

            <form action="save_data.php" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="form_type" value="degree_details">

                <!-- Background to the Program -->
                <div class="mb-3">
                    <label for="background_to_program" class="form-label">3.1.a. Background to the Program</label>
                    <textarea class="form-control" id="background_to_program" name="background_to_program" rows="5" placeholder="Provide a detailed background" required><?php echo htmlspecialchars($degreeDetails['background_to_program'] ?? ''); ?></textarea><?php echo get_lock_status_attr('degree_details.background_to_program'); ?><?php render_field_feedback('degree_details.background_to_program'); ?>
                </div>

                <!-- Subsections under Background -->
                <div class="mb-3">
                    <label class="form-label">Additional Information</label>
                    <textarea class="form-control mb-2" name="mandate_faculty" rows="3" placeholder="Mandate of the Faculty/Department in offering the degree program"<?php echo get_lock_status_attr('degree_details.mandate_faculty'); ?>><?php echo htmlspecialchars($degreeDetails['mandate_faculty'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.mandate_faculty'); ?>
                    
                    <textarea class="form-control mb-2" name="faculty_status" rows="3" placeholder="Details regarding the current status of faculty - existing departments and degree programs offered"<?php echo get_lock_status_attr('degree_details.faculty_status'); ?>><?php echo htmlspecialchars($degreeDetails['faculty_status'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.faculty_status'); ?>

                    <textarea class="form-control mb-2" name="student_intake" rows="3" placeholder="Student intake"<?php echo get_lock_status_attr('degree_details.student_intake'); ?>><?php echo htmlspecialchars($degreeDetails['student_intake'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.student_intake'); ?>

                    <textarea class="form-control mb-2" name="staff_cadres" rows="3" placeholder="Staff cadres"<?php echo get_lock_status_attr('degree_details.staff_cadres'); ?>><?php echo htmlspecialchars($degreeDetails['staff_cadres'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.staff_cadres'); ?>

                    <textarea class="form-control mb-2" name="educational_facilities" rows="3" placeholder="Educational facilities"<?php echo get_lock_status_attr('degree_details.educational_facilities'); ?>><?php echo htmlspecialchars($degreeDetails['educational_facilities'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.educational_facilities'); ?>

                    <textarea class="form-control mb-2" name="common_facilities" rows="3" placeholder="Common facilities"<?php echo get_lock_status_attr('degree_details.common_facilities'); ?>><?php echo htmlspecialchars($degreeDetails['common_facilities'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.common_facilities'); ?>

                    <textarea class="form-control" name="program_benefits" rows="3" placeholder="General description of benefits to students and employment markets"<?php echo get_lock_status_attr('degree_details.program_benefits'); ?>><?php echo htmlspecialchars($degreeDetails['program_benefits'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.program_benefits'); ?>
                </div>

                <!-- Grades Table -->
                <div class="mb-3">
                    <label class="form-label">3.1.b. Grades Received at Program Reviews</label>
                     <?php
                    $table_identifier = 'table.program_grades';
                    
                    // Use the correct function for the component
                    render_component_feedback($table_identifier);
                ?>

                 <!-- 3. Wrap everything in a <fieldset> and call the correct helper function -->
                <fieldset <?php echo get_group_lock_attr($table_identifier); ?>>

                    <table>
                        <thead>
                            <tr>
                                <th>Name of the Existing Program</th>
                                <th>Year of the Program Review</th>
                                <th>Grade</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="programTableBody">
                            <?php if (!empty($degreeDetails['program_reviews'])): ?>
                                <?php foreach ($degreeDetails['program_reviews'] as $program): ?>
                                    <tr>
                                        <td><input type="text" class="form-control" name="program_name[]" value="<?php echo htmlspecialchars($program['program_name']); ?>"></td>
                                        <td><input type="text" class="form-control" name="program_year[]" value="<?php echo htmlspecialchars($program['program_year']); ?>"></td>
                                        <td><input type="text" class="form-control" name="program_grade[]"value="<?php echo htmlspecialchars($program['program_grade']); ?>"></td>
                                        <td><button type="button" class="btn btn-danger" onclick="removeRow(this)">Remove</button></td>
                                    </tr>
                                <?php endforeach; ?>
                             <?php else: ?>
                                <tr>
                                        <td><input type="text" class="form-control" name="program_name[]" placeholder="Enter program name"></td>
                                        <td><input type="text" class="form-control" name="program_year[]" placeholder="Enter year"></td>
                                        <td><input type="text" class="form-control" name="program_grade[]" placeholder="Enter grade"></td>
                                        <td><button type="button" class="btn btn-danger" onclick="removeRow(this)">Remove</button></td>
                                </tr>
                             <?php endif; ?>
                        </tbody>
                    </table>
                    <button type="button" class="btn btn-primary mt-2" onclick="addRow()">Add Row</button>
                </div>

                 <!-- Recommendation in review reports -->
                <div class="mb-3">
                    <label for="rec_in_review_report" class="form-label">3.1.c. Recommendation in review reports and the action taken</label>
                    
                    <?php
                    // --- MODIFICATION START ---
                    $identifier = 'degree_details.rec_in_review_report';
                    
                    // Get the lock attribute string ('readonly...' or '')
                    $lock_attr = get_lock_status_attr($identifier);
                    
                    // Determine if the field is locked by checking if the lock attribute is not empty
                    $is_locked = !empty($lock_attr);
                    
                    // Only add the 'required' attribute if the field is NOT locked
                    $required_attr = !$is_locked ? 'required' : '';
                    // --- MODIFICATION END ---
                    ?>

                    <textarea class="form-control" 
                            id="rec_in_review_report" 
                            name="rec_in_review_report" 
                            rows="3" 
                            placeholder="Recommendations in Review Reports and the actions taken" 
                            <?php echo $required_attr; ?> 
                            <?php echo $lock_attr; ?>
                    ><?php echo htmlspecialchars($degreeDetails['rec_in_review_report'] ?? ''); ?></textarea>

                    <?php render_field_feedback($identifier); ?>
                </div>
                
                <!-- JUSTIFICATION -->
                <div class="mb-3">
                    <label for="degree_details_justification" class="form-label">
                        3.2 Justification. Please review the Annexure.  
                        <a href="/qac_ugc/Proposal_sections/uploads/justification_degree_details.jpg">View</a>
                    </label>

                    <?php
                    // --- MODIFICATION START ---
                    $identifier = 'degree_details.degree_details_justification';
                    
                    // Check if the field should be locked. We use the opposite of the group lock function.
                    // An item is EDITABLE only if it's explicitly 'non_compliance'.
                    $is_editable = (get_group_lock_attr($identifier) === ''); 
                    // --- MODIFICATION END ---
                    ?>

                    <?php if ($is_editable): ?>
                        
                        <!-- === THIS BLOCK SHOWS IF THE FIELD IS UNLOCKED === -->
                        <input type="file" class="form-control" name="degree_details_justification">
                        
                        <?php 
                        // Render the feedback message (which will be the UGC comment)
                        render_field_feedback($identifier); 
                        ?>

                    <?php else: ?>
                    
                        <!-- === THIS BLOCK SHOWS IF THE FIELD IS LOCKED === -->
                        <div class="form-control" style="background-color: #e9ecef;">
                            <!-- We don't show an <input type="file"> at all. Just the link. -->
                            <?php if (!empty($degreeDetails['degree_details_justification'])): ?>
                                Uploaded: 
                                <a href="<?php echo htmlspecialchars($degreeDetails['degree_details_justification']); ?>" target="_blank">View File</a>
                            <?php else: ?>
                                No file was uploaded for this section.
                            <?php endif; ?>
                        </div>
                        
                        <?php 
                        // Render the feedback message (which will be "✔ Compliant")
                        render_field_feedback($identifier); 
                        ?>

                    <?php endif; ?>
                </div>
            
                <!-- Objective of The Degree Program -->
                <div class="mb-3">
                    <label for="degree_details_objective" class="form-label">
                        3.3 Objective of the Degree Programme / Attributes of Qualification Holders/Programming Learning Outcomes. Please review the Annexure.  
                        <a href="/qac_ugc/Proposal_sections/uploads/degree_details_objectives.jpg">View</a>
                    </label>

                    <?php
                    // 1. Define the unique identifier for this field
                    $identifier = 'degree_details.degree_details_objective';
                    
                    // 2. Determine if this field is editable
                    $is_editable = (get_group_lock_attr($identifier) === ''); 
                    ?>

                    <?php if ($is_editable): ?>
                        
                        <!-- === UNLOCKED VIEW: SHOW FILE INPUT === -->
                        <input type="file" class="form-control" name="degree_details_objective">
                        
                        <?php 
                        // Show the link to the currently uploaded file, if any
                        if (!empty($degreeDetails['degree_details_objective'])): ?>
                            <p class="mt-1"><small>Currently Uploaded: 
                                <a href="<?php echo htmlspecialchars($degreeDetails['degree_details_objective']); ?>" target="_blank">View File</a>
                            </small></p>
                        <?php endif; ?>

                        <?php 
                        // Render the UGC comment to guide the user
                        render_field_feedback($identifier); 
                        ?>

                    <?php else: ?>
                    
                        <!-- === LOCKED VIEW: SHOW A GREY BOX WITH A LINK, NO FILE INPUT === -->
                        <div class="form-control" style="background-color: #e9ecef;">
                            <?php if (!empty($degreeDetails['degree_details_objective'])): ?>
                                Uploaded: 
                                <a href="<?php echo htmlspecialchars($degreeDetails['degree_details_objective']); ?>" target="_blank">View File</a>
                            <?php else: ?>
                                No file was uploaded for this section.
                            <?php endif; ?>
                        </div>
                        
                        <?php 
                        // Render the "✔ Compliant" message
                        render_field_feedback($identifier); 
                        ?>

                    <?php endif; ?>
                </div>

                <!-- Eligibility Requirements -->
                <div class="mb-3">
                    <label for="eligibility_req" class="form-label">3.4.a. Eligibility requirements (Qualifications for university admission)</label>
                    
                    <textarea class="form-control" 
                            id="eligibility_req" 
                            name="eligibility_req" 
                            rows="3" 
                            placeholder="List the GCE A/L subject basket"
                            <?php echo get_lock_status_attr('degree_details.eligibility_req'); ?>
                    ><?php echo htmlspecialchars($degreeDetails['eligibility_req'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.eligibility_req'); ?>
                </div>

                <!-- Indicate Program -->
                <div class="mb-3">
                    <label for="indicate_program" class="form-label">3.4.b. Indicate under which course (programme) of study this programme should be included in the UGC student admission handbook</label>
                    
                    <textarea class="form-control" 
                            id="indicate_program" 
                            name="indicate_program" 
                            rows="3" 
                            placeholder="Provide details"
                            <?php echo get_lock_status_attr('degree_details.indicate_program'); ?>
                    ><?php echo htmlspecialchars($degreeDetails['indicate_program'] ?? ''); ?></textarea>

                    <?php render_field_feedback('degree_details.indicate_program'); ?>
                </div>

               <!-- Admission Process -->
                <div class="mb-3">
                    <label class="form-label fw-bold">3.5 Admission Process</label>
                    
                    <?php
                    // --- MODIFICATION START ---
                    // 1. Define the identifiers for BOTH parts of this component
                    $checkbox_identifier = 'degree_details.admission_process';
                    $textbox_identifier = 'degree_details.other_criteria';

                    // 2. The entire component is locked UNLESS one of its parts is non-compliant.
                    $is_component_locked = true; // Assume locked by default
                    if (get_group_lock_attr($checkbox_identifier) === '' || get_group_lock_attr($textbox_identifier) === '') {
                        $is_component_locked = false; // Unlock if either part is non-compliant
                    }

                    // 3. Display feedback for each part
                    render_field_feedback($checkbox_identifier);
                    render_field_feedback($textbox_identifier);
                    // --- MODIFICATION END ---
                    ?>

                    <!-- 4. Wrap the entire component in a fieldset -->
                    <fieldset <?php if ($is_component_locked) echo 'disabled'; ?>>
                    
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="admission_process" name="admission_process" value="UGC Z score based selection"
                                <?php 
                                // Use `in_array` because the session value might be an array
                                if (!empty($degreeDetails['admission_process']) && in_array('UGC Z score based selection', (array)$degreeDetails['admission_process'])) echo 'checked'; 
                                ?>>
                            <label for="admission_process" class="form-check-label">UGC Z score based selection</label>
                        </div>

                        <label for="other_criteria" class="form-label mt-2">Any other criteria, please specify:</label>
                        <input type="text" class="form-control" id="other_criteria" name="other_criteria" value="<?php echo htmlspecialchars($degreeDetails['other_criteria'] ?? ''); ?>">

                    </fieldset>

                </div>

                <!-- Proposed Student Intake -->
                <div class="mb-3">
                    <label for="intake" class="form-label">3.6 Proposed Student Intake</label>
                    <input type="text" class="form-control" id="intake" name="intake" 
                        placeholder="Enter number of students per year"
                        value="<?php echo htmlspecialchars($degreeDetails['intake'] ?? ''); ?>"
                        <?php echo get_lock_status_attr('degree_details.intake'); ?>>
                    <?php render_field_feedback('degree_details.intake'); ?>
                    <small class="text-muted">(Please note, the minimum number for a new degree programme is 50 students per year)</small>
                </div>

                <!-- Programme Duration and Credit Load -->
                <div class="mb-3">
                    <h6>3.7 Programme Duration and Credit Load</h6>
                    
                    <div class="mb-2">
                        <label for="degree_type" class="form-label">Bachelor/Bachelor Honours Degree/Professional Degree:</label>
                        <input type="text" class="form-control" id="degree_type" name="degree_type" 
                            placeholder="Specify the degree type"
                            value="<?php echo htmlspecialchars($degreeDetails['degree_type'] ?? ''); ?>"
                            <?php echo get_lock_status_attr('degree_details.degree_type'); ?>>
                        <?php render_field_feedback('degree_details.degree_type'); ?>
                    </div>

                    <div class="mb-2">
                    <label for="duration" class="form-label">Duration:</label>
                    <input type="text" class="form-control" id="duration" name="duration" 
                        placeholder="Enter duration in years"
                        value="<?php echo htmlspecialchars($degreeDetails['duration'] ?? ''); ?>"
                        <?php echo get_lock_status_attr('degree_details.duration'); // <-- VERIFY THIS IDENTIFIER ?>> 
                    <?php render_field_feedback('degree_details.duration'); // <-- VERIFY THIS IDENTIFIER ?>
                    </div>

                    <div class="mb-2">
                        <label for="coursework_credits" class="form-label">Course Work Credits:</label>
                        <input type="text" class="form-control" id="coursework_credits" name="coursework_credits" 
                            placeholder="Enter coursework credits"
                            value="<?php echo htmlspecialchars($degreeDetails['coursework_credits'] ?? ''); ?>"
                            <?php echo get_lock_status_attr('degree_details.coursework_credits'); ?>>
                        <?php render_field_feedback('degree_details.coursework_credits'); ?>
                    </div>

                    <div class="mb-2">
                        <label for="thesis_credits" class="form-label">Student Thesis Research:</label>
                        <input type="text" class="form-control" id="thesis_credits" name="thesis_credits" 
                            placeholder="Enter thesis credits"
                            value="<?php echo htmlspecialchars($degreeDetails['thesis_credits'] ?? ''); ?>"
                            <?php echo get_lock_status_attr('degree_details.thesis_credits'); ?>>
                        <?php render_field_feedback('degree_details.thesis_credits'); ?>
                    </div>

                    <div class="mb-2">
                    <label for="total_credits" class="form-label">Total Credits:</label>
                    <input type="text" class="form-control" id="total_credits" name="total_credits" 
                        placeholder="Enter total credits"
                        value="<?php echo htmlspecialchars($degreeDetails['total_credits'] ?? ''); ?>"
                        <?php echo get_lock_status_attr('degree_details.total_credits'); // <-- VERIFY THIS IDENTIFIER ?>>
                    <?php render_field_feedback('degree_details.total_credits'); // <-- VERIFY THIS IDENTIFIER ?>
                </div>
            </div>

                <!-- Handle duration and total credits according to the degree type-->
            <script>
            function updateFields() {
                let degreeTypeInput = document.getElementById('degree_type');
                let totalCredits = document.getElementById('total_credits');
                let duration = document.getElementById('duration');

                if (!degreeTypeInput || !totalCredits || !duration) {
                    console.error("One or more fields not found.");
                return;
                }

                let degreeType = degreeTypeInput.value.trim().toLowerCase();

                if (degreeType === 'bachelor' || degreeType === 'bachelor degree') {
                    totalCredits.value = 90;
                    duration.value = 3;
                    totalCredits.readOnly = true;
                    duration.readOnly = true;
                } else if (degreeType === 'bachelor honours degree') {
                    totalCredits.value = 120;
                    duration.value = 4;
                    totalCredits.readOnly = true;
                    duration.readOnly = true;
                } else if (degreeType === 'professional degree') {
                    totalCredits.value = '';
                    duration.value = '';
                    totalCredits.readOnly = false;
                    duration.readOnly = false;
                } else {
                    totalCredits.value = '';
                    duration.value = '';
                    totalCredits.readOnly = false;
                    duration.readOnly = false;
                }
            }

            // Attach the event listener on input change
            document.getElementById('degree_type').addEventListener('input', updateFields);

            // Call the function on page load in case values are already entered
            window.onload = function() {
            updateFields();
            };
        </script>



                <!-- Subject Benchmarks -->
                <div class="mb-3">
                    <label for="subject_benchmark" class="form-label">3.8 Name/s of the Subject Benchmark/s Used. Please review the Annexure.  <a href="/qac_ugc/Proposal_sections/uploads/Annex_Subject_Benchmark_Statement_Mapping.pdf">View</a></label>
                    
                    <?php
                    $identifier = 'degree_details.subject_benchmark';
                    // An item is EDITABLE only if it's explicitly 'non_compliance'.
                    $is_editable = (get_group_lock_attr($identifier) === ''); 
                    ?>

                    <?php if ($is_editable): ?>
                        <!-- UNLOCKED VIEW: Show the file input -->
                        <input type="file" class="form-control" name="subject_benchmark">
                        <?php render_field_feedback($identifier); ?>
                    <?php else: ?>
                        <!-- LOCKED VIEW: Show a disabled-looking box with the link -->
                        <div class="form-control" style="background-color: #e9ecef;">
                            <?php if (!empty($degreeDetails['subject_benchmark'])): ?>
                                Uploaded: <a href="<?php echo htmlspecialchars($degreeDetails['subject_benchmark']); ?>" target="_blank">View File</a>
                            <?php else: ?>
                                No file was uploaded for this section.
                            <?php endif; ?>
                        </div>
                        <?php render_field_feedback($identifier); ?>
                    <?php endif; ?>

                    <?php if (!empty($degreeDetails['subject_benchmark']) && $is_editable): // Also show the current file if editable ?>
                        <p class="mt-1"><small>Currently Uploaded: 
                            <a href="<?php echo htmlspecialchars($degreeDetails['subject_benchmark']); ?>" target="_blank">View File</a>
                        </small></p>
                    <?php endif; ?>
                </div>

               <!-- Medium of Instruction -->
                <div class="mb-3">
                    <h6>3.9 Medium of Instruction</h6>
                    
                    <?php
                    // We check the identifier for the whole group. Let's assume it's 'medium_of_instruction'.
                    $group_identifier = 'degree_details.medium_of_instruction';
                    render_component_feedback($group_identifier); // Show feedback for the whole group
                    ?>

                    <fieldset <?php echo get_group_lock_attr($group_identifier); ?>>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="mediumEnglish" name="mediumOfInstructionEnglish" value="English"
                            <?php if (!empty($degreeDetails['medium_of_instruction']) && in_array('English', (array)$degreeDetails['medium_of_instruction'])) echo 'checked'; ?>>
                            <label for="mediumEnglish" class="form-check-label">English</label>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="mediumSinhala" name="mediumOfInstructionSinhala" value="Sinhala"
                            <?php if (!empty($degreeDetails['medium_of_instruction']) && in_array('Sinhala', (array)$degreeDetails['medium_of_instruction'])) echo 'checked'; ?>>
                            <label for="mediumSinhala" class="form-check-label">Sinhala</label>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="mediumTamil" name="mediumOfInstructionTamil" value="Tamil"
                            <?php if (!empty($degreeDetails['medium_of_instruction']) && in_array('Tamil', (array)$degreeDetails['medium_of_instruction'])) echo 'checked'; ?>>
                            <label for="mediumTamil" class="form-check-label">Tamil</label>
                        </div>
                    </fieldset>
                </div>

                <!-- Targeted SLQF Level -->
                <div class="mb-4">
                    <h6>3.10.a. Targeted Sri Lanka Qualification Framework (SLQF) Level</h6>
                    
                    <?php
                    $group_identifier = 'degree_details.slqf_level';
                    render_component_feedback($group_identifier);
                    ?>

                    <fieldset <?php echo get_group_lock_attr($group_identifier); ?>>
                        <div class="mb-3">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="targetedSlqf5" name="targetedSlqfLevel5" value="Level 5 (Bachelors)"
                                <?php if (!empty($degreeDetails['slqf_level']) && in_array('Level 5 (Bachelors)', (array)$degreeDetails['slqf_level'])) echo 'checked'; ?>>
                                <label for="targetedSlqf5" class="form-check-label">Level 5 (Bachelors)</label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="targetedSlqf6" name="targetedSlqfLevel6" value="Level 6 (Bachelors Honours - 4 year programme)"
                                <?php if (!empty($degreeDetails['slqf_level']) && in_array('Level 6 (Bachelors Honours - 4 year programme)', (array)$degreeDetails['slqf_level'])) echo 'checked'; ?>>
                                <label for="targetedSlqf6" class="form-check-label">Level 6 (Bachelors Honours - 4 year programme)</label>
                            </div>
                        </div>
                    </fieldset>
                </div>

                <!-- Minimum Requirements of SLQF -->
                <div class="mb-4">
                    <h6>3.10.b.  Minimum requirements of SLQF fulfilled</h6>
                    
                    <?php
                    $group_identifier = 'degree_details.slqf_filled';
                    render_component_feedback($group_identifier);
                    ?>
                    
                    <fieldset <?php echo get_group_lock_attr($group_identifier); ?>>
                        <div class="mb-3">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="slqfyes" name="slqf_fullfilled_yes" value="Yes"
                                <?php if (!empty($degreeDetails['slqf_filled']) && in_array('Yes', (array)$degreeDetails['slqf_filled'])) echo 'checked'; ?>>
                                <label for="slqf_fullfilled_yes" class="form-check-label">Yes</label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="slqfno" name="slqf_fullfilled_no" value="No"
                                <?php if (!empty($degreeDetails['slqf_filled']) && in_array('No', (array)$degreeDetails['slqf_filled'])) echo 'checked'; ?>>
                                <label for="slqf_fullfilled_no" class="form-check-label">No</label>
                            </div>
                        </div>
                    </fieldset>
                </div>

                <!-- Navigation Buttons -->
                <div class="form-footer">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-primary">Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="degree_details">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>

    <script>
        // Add new row to the table
        function addRow() {
            const tableBody = document.getElementById("programTableBody");
            const newRow = document.createElement("tr");
            newRow.innerHTML = `
                <td><input type="text" class="form-control" name="program_name[]" placeholder="Enter program name"></td>
                <td><input type="text" class="form-control" name="program_year[]" placeholder="Enter year"></td>
                <td><input type="text" class="form-control" name="program_grade[]" placeholder="Enter grade"></td>
                <td><button type="button" class="btn btn-danger" onclick="removeRow(this)">Remove</button></td>
            `;
            tableBody.appendChild(newRow);
        }

        // Remove a row from the table
        function removeRow(button) {
            const row = button.closest("tr");
            row.remove();
        }
    </script>
</body>
</html>
