<?php
session_start();


// Retrieve saved data (if available)
$assessmentRules = $_SESSION['assessment_rules'] ?? [
    'formative_summative' => '',
    'grading_scheme' => '',
    'gpa_calculation' => '',
    'semester_contribution' => '',
    'inplant_training' => '',
    'repeat_exams' => '',
    'degree_requirements' => '',
    'class_requirements' => '',
];


?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Section 7: Programme Assessment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 50px;
            max-width: 900px;
        }

        .form-header {
            background-color: #007bff;
            color: white;
            padding: 15px;
            border-radius: 10px 10px 0 0;
            text-align: center;
        }

        textarea {
            resize: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container mx-auto">
            <div class="form-header">
                <h3>Section 7: Programme Assessment Procedure/Rules</h3>
            </div>
            <form action="save_data.php" method="POST">
            <input type="hidden" name="form_type" value="assessment_rules">
                <p>Please provide details regarding the assessment procedure/rules as outlined below.</p>

                <div class="mb-3">
                    <label for="formativeSummative" class="form-label"><b>Formative and Summative Examinations in the Program</b></label>
                    <textarea class="form-control" id="formativeSummative" name="formative_summative" rows="4" placeholder="Describe the formative and summative examinations conducted in the program." required><?php echo htmlspecialchars($assessmentRules['formative_summative']); ?></textarea>
                </div>

                <div class="mb-3">
                    <label for="gradingScheme" class="form-label"><b>Scheme of Grading (Grades/Grade Points/Marks Ranges)</b></label>
                    <textarea class="form-control" id="gradingScheme" name="grading_scheme" rows="4" placeholder="Provide details about the grading scheme including grade points, marks ranges, etc." required><?php echo htmlspecialchars($assessmentRules['grading_scheme']); ?></textarea>
                </div>

                <div class="mb-3">
                    <label for="gpaCalculation" class="form-label"><b>Calculation of Grade Point Average (GPA)</b></label>
                    <textarea class="form-control" id="gpaCalculation" name="gpa_calculation" rows="4" placeholder="Explain the method of calculating the GPA." required><?php echo htmlspecialchars($assessmentRules['gpa_calculation']); ?></textarea>
                </div>

                <div class="mb-3">
                    <label for="semesterContribution" class="form-label"><b>Contribution by Each Semester to Final GPA</b></label>
                    <textarea class="form-control" id="semesterContribution" name="semester_contribution" rows="4" placeholder="Explain the contribution of each semester to the final GPA." required><?php echo htmlspecialchars($assessmentRules['semester_contribution']); ?></textarea>
                </div>

                <div class="mb-3">
                    <label for="inplantTraining" class="form-label"><b>Contribution by In-Plant Training, etc. to Final GPA</b></label>
                    <textarea class="form-control" id="inplantTraining" name="inplant_training" rows="4" placeholder="Explain how in-plant training contributes to the final GPA." required><?php echo htmlspecialchars($assessmentRules['inplant_training']); ?></textarea>
                </div>

                <div class="mb-3">
                    <label for="repeatExams" class="form-label"><b>Repeat Examinations</b></label>
                    <textarea class="form-control" id="repeatExams" name="repeat_exams" rows="4" placeholder="Describe the rules and procedures for repeat examinations." required><?php echo htmlspecialchars($assessmentRules['repeat_exams']); ?></textarea>
                </div>

                <div class="mb-3">
                    <label for="degreeRequirements" class="form-label"><b>Requirements for Award of the Degree</b></label>
                    <textarea class="form-control" id="degreeRequirements" name="degree_requirements" rows="4" placeholder="Outline the requirements for students to be awarded the degree." required><?php echo htmlspecialchars($assessmentRules['degree_requirements']); ?></textarea>
                </div>

                <div class="mb-3">
                    <label for="classRequirements" class="form-label"><b>Requirements for Award of Classes</b></label>
                    <textarea class="form-control" id="classRequirements" name="class_requirements" rows="4" placeholder="Specify the requirements for the award of classes (e.g., First Class, Second Class, etc.)." required><?php echo htmlspecialchars($assessmentRules['class_requirements']); ?></textarea>
                </div>

                <div class="text-end mt-4">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-primary" id=saveButton>Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="assessment_rules">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>
</body>
</html>
