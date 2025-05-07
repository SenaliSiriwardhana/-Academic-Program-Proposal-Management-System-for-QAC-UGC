<?php
session_start();
include 'university_name_fetch.php';
//include 'database_handling/program_entity_db.php';
// Retrieve saved data (if available)
$programEntity = $_SESSION['program_entity'] ?? [
    'university' => '',
    'faculty' => '',
    'department' => '',
    'ref_corporate_plan' => '',
    'date_corporate_plan' => '',
    'evidence_corporate_plan' => '',
    'ref_action_plan' => '',
    'date_action_plan' => '',
    'evidence_action_plan' => '',
    'ref_senate_approval' => '',
    'date_senate_approval' => '',
    'evidence_senate_approval' => '',
    'ref_council_approval' => '',
    'date_council_approval' => '',
    'evidence_council_approval' => '',
];


?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Programme Offering Entity</title>
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
                <h3>Section 2: Programme Offering Entity</h3>
            </div>

            <p class="mt-3">Please provide the details about the programme offering entity.</p>

            <form action="save_data.php" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="form_type" value="program_entity"> 

                <!-- University Information -->
                <div class="mb-3">
                    <label for="university" class="form-label">University</label>
                    <input type="text" class="form-control" id="university" name="university" placeholder="Enter the university name" value="<?php echo htmlspecialchars($university); ?>" readonly> 
                </div>
                <div class="mb-3">
                    <label for="faculty" class="form-label">Faculty/Institute</label>
                    <input type="text" class="form-control" id="faculty" name="faculty" placeholder="Enter the faculty or institute" value="<?php echo htmlspecialchars($programEntity['faculty']); ?>" required>
                </div>
                <div class="mb-3">
                    <label for="department" class="form-label">Department</label>
                    <input type="text" class="form-control" id="department" name="department" placeholder="Enter the department (if applicable)"value="<?php echo htmlspecialchars($programEntity['department']); ?>">
                </div>

                <!-- Mandate Availability -->
                <div class="mb-3">
                    <label for="mandateAvailability" class="form-label">Mandate Availability</label>
                    <table>
                        <thead>
                            <tr>
                                <th>Mandate Availability</th>
                                <th>Reference Number</th>
                                <th>Date of Approval</th>
                                <th>Evidence (Attach)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Corporate / Strategic Plan of the University</td>
                                <td><input type="text" class="form-control" name="ref_corporate_plan" placeholder="Reference Number"value="<?php echo htmlspecialchars($programEntity['ref_corporate_plan'] ?? ""); ?>"></td>
                                <td><input type="date" class="form-control" name="date_corporate_plan" value="<?php echo htmlspecialchars($programEntity['date_corporate_plan'] ?? ""); ?>"></td>
                                <td><input type="file" class="form-control" name="evidence_corporate_plan"required>
                                <?php if (!empty($programEntity['evidence_corporate_plan'])): ?>
                                    <p>Uploaded: <a href="<?php echo htmlspecialchars($programEntity['evidence_corporate_plan']); ?>" target="_blank">View File</a></p>
                                <?php endif; ?>
                            </td>
                            </tr>
                            <tr>
                                <td>Action Plan of the Faculty/Institute/Center/Unit</td>
                                <td><input type="text" class="form-control" name="ref_action_plan" placeholder="Reference Number" value="<?php echo htmlspecialchars($programEntity['ref_action_plan'] ?? ""); ?>"></td>
                                <td><input type="date" class="form-control" name="date_action_plan" value="<?php echo htmlspecialchars($programEntity['date_action_plan'] ?? ""); ?>"></td>
                                <td><input type="file" class="form-control" name="evidence_action_plan"required>
                                <?php if (!empty($programEntity['evidence_action_plan'])): ?>
                                    <p>Uploaded: <a href="<?php echo htmlspecialchars($programEntity['evidence_action_plan']); ?>" target="_blank">View File</a></p>
                                <?php endif; ?>
                            </td>

                            </tr>
                            <tr>
                                <td>Final Senate Approval</td>
                                <td><input type="text" class="form-control" name="ref_senate_approval" placeholder="Reference Number" value="<?php echo htmlspecialchars($programEntity['ref_senate_approval'] ?? ""); ?>"></td>
                                <td><input type="date" class="form-control" name="date_senate_approval" value="<?php echo htmlspecialchars($programEntity['date_senate_approval'] ?? ""); ?>"></td>
                                <td><input type="file" class="form-control" name="evidence_senate_approval"required>
                                <?php if (!empty($programEntity['evidence_senate_approval'])): ?>
                                    <p>Uploaded: <a href="<?php echo htmlspecialchars($programEntity['evidence_senate_approval']); ?>" target="_blank">View File</a></p>
                                <?php endif; ?>
                            </td>
                            </tr>
                            <tr>
                                <td>Final Council Approval</td>
                                <td><input type="text" class="form-control" name="ref_council_approval" placeholder="Reference Number" value="<?php echo htmlspecialchars($programEntity['ref_council_approval'] ?? ""); ?>"></td>
                                <td><input type="date" class="form-control" name="date_council_approval" value="<?php echo htmlspecialchars($programEntity['date_council_approval'] ?? ""); ?>"></td>
                                <td><input type="file" class="form-control" name="evidence_council_approval" required>
                                <?php if (!empty($programEntity['evidence_council_approval'])): ?>
                                    <p>Uploaded: <a href="<?php echo htmlspecialchars($programEntity['evidence_council_approval']); ?>" target="_blank">View File</a></p>
                                <?php endif; ?>
                            </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Navigation Buttons -->
                <div class="form-footer">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-primary">Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="program_entity">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>
</body>
</html>
