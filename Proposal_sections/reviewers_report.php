<?php
session_start();
//include 'database_handling/reviewers_report_db.php';

// Retrieve saved data (if available)
$reviewersReport = $_SESSION['reviewers_report'] ?? [];

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Section 10: Reviewers Report</title>
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
            max-width: 1100px;
        }

        .form-header {
            background-color: #007bff;
            color: white;
            padding: 15px;
            border-radius: 10px 10px 0 0;
            text-align: center;
        }

        table input,
        table textarea {
            max-width: 150px;
        }

        table textarea {
            resize: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container mx-auto">
            <div class="form-header">
                <h3>Section 10: Reviewers Report</h3>
            </div>
            <form action="save_data.php" method="POST">
            <input type="hidden" name="form_type" value="reviewers_report">
                <h5 class="mt-4">Review Aspects and Recommendation</h5>
                <table class="table table-bordered text-center">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Aspect</th>
                            <th>Main Proposal</th>
                            <th>Fallback Qualification (If applicable)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Acceptability of the Background and the Justification</td>
                            <td><textarea class="form-control" name="main_acceptability"><?php echo htmlspecialchars($reviewersReport['main_acceptability']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_acceptability"><?php echo htmlspecialchars($reviewersReport['fallback_acceptability']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Relevance of proposed degree program to Society</td>
                            <td><textarea class="form-control" name="main_relevance"><?php echo htmlspecialchars($reviewersReport['main_relevance']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_relevance"><?php echo htmlspecialchars($reviewersReport['fallback_relevance']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Entry Qualification and Admission Process</td>
                            <td><textarea class="form-control" name="main_entry_qualification"><?php echo htmlspecialchars($reviewersReport['main_entry_qualification']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_entry_qualification"><?php echo htmlspecialchars($reviewersReport['fallback_entry_qualification']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>Program Structure</td>
                            <td><textarea class="form-control" name="main_structure"><?php echo htmlspecialchars($reviewersReport['main_structure']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_structure"><?php echo htmlspecialchars($reviewersReport['fallback_structure']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>Program Content</td>
                            <td><textarea class="form-control" name="main_content"><?php echo htmlspecialchars($reviewersReport['main_content']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_content"><?php echo htmlspecialchars($reviewersReport['fallback_content']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td>Teaching Learning Methods</td>
                            <td><textarea class="form-control" name="main_methods"><?php echo htmlspecialchars($reviewersReport['main_methods']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_methods"><?php echo htmlspecialchars($reviewersReport['fallback_methods']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>Assessment Strategy/Procedure</td>
                            <td><textarea class="form-control" name="main_procedure"><?php echo htmlspecialchars($reviewersReport['main_procedure']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_procedure"><?php echo htmlspecialchars($reviewersReport['fallback_procedure']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td>Resource Availability - Physical</td>
                            <td><textarea class="form-control" name="main_availability"><?php echo htmlspecialchars($reviewersReport['main_availability']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_availability"><?php echo htmlspecialchars($reviewersReport['fallback_availability']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>9</td>
                            <td>Qualifications of Panel of Teachers (Internal & External)</td>
                            <td><textarea class="form-control" name="main_qualifications"><?php echo htmlspecialchars($reviewersReport['main_qualifications']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_qualifications"><?php echo htmlspecialchars($reviewersReport['fallback_qualifications']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>10</td>
                            <td>Recommended Reading</td>
                            <td><textarea class="form-control" name="main_recommended_reading"><?php echo htmlspecialchars($reviewersReport['main_recommended_reading']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_recommended_reading"><?php echo htmlspecialchars($reviewersReport['fallback_recommended_reading']??''); ?></textarea></td>
                        </tr>
                        <tr>
                            <td>11</td>
                            <td>
                                Recommendation (Please enter the corresponding letter for your chosen option: a, b, or c)<br>
                                a. Recommended without amendment<br>
                                b. Recommended subject to improvement in the following areas:<br>
                                c. Not suitable for the next stage of evaluation due to the following reasons:<br>

                            </td>
                            <td><textarea class="form-control" name="main_recommendation"><?php echo htmlspecialchars($reviewersReport['main_recommendation']??''); ?></textarea></td>
                            <td><textarea class="form-control" name="fallback_recommendation"><?php echo htmlspecialchars($reviewersReport['fallback_recommendation']??''); ?></textarea></td>
                        </tr>
                    </tbody>
                </table>

                <h5 class="mt-5">Reviewer Details</h5>
                <table class="table table-bordered text-center">
                    <thead class="table-light">
                        <tr>
                            <th>Details</th>
                            <th>Reviewer 1</th>
                            <th>Reviewer 2</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Name</td>
                            <td><input type="text" class="form-control" name="reviewer1_name" value="<?php echo htmlspecialchars($reviewersReport['reviewer1_name']??''); ?>"></td>
                            <td><input type="text" class="form-control" name="reviewer2_name" value="<?php echo htmlspecialchars($reviewersReport['reviewer2_name']??''); ?>"></td>
                        </tr>
                        <tr>
                            <td>Designation</td>
                            <td><input type="text" class="form-control" name="reviewer1_designation" value="<?php echo htmlspecialchars($reviewersReport['reviewer1_designation']??''); ?>"></td>
                            <td><input type="text" class="form-control" name="reviewer2_designation" value="<?php echo htmlspecialchars($reviewersReport['reviewer2_designation']??''); ?>"></td>
                        </tr>
                        <tr>
                            <td>Qualification and Relevant Field</td>
                            <td><input type="text" class="form-control" name="reviewer1_qualification" value="<?php echo htmlspecialchars($reviewersReport['reviewer1_qualification']??''); ?>"></td>
                            <td><input type="text" class="form-control" name="reviewer2_qualification" value="<?php echo htmlspecialchars($reviewersReport['reviewer2_qualification']??''); ?>"></td>
                        </tr>
                        <tr>
                            <td>Signature</td>
                            <td><input type="text" class="form-control" name="reviewer1_signature" value="<?php echo htmlspecialchars($reviewersReport['reviewer1_signature']??''); ?>"></td>
                            <td><input type="text" class="form-control" name="reviewer2_signature" value="<?php echo htmlspecialchars($reviewersReport['reviewer2_signature']??''); ?>"></td>
                        </tr>
                        <tr>
                            <td>Date</td>
                            <td><input type="date" class="form-control" name="reviewer1_date" value="<?php echo htmlspecialchars($reviewersReport['reviewer1_date']??''); ?>"></td>
                            <td><input type="date" class="form-control" name="reviewer2_date" value="<?php echo htmlspecialchars($reviewersReport['reviewer2_date']??''); ?>"></td>
                        </tr>
                    </tbody>
                </table>

                <div class="text-end">
                <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                <button type="submit" class="btn btn-success">Save</button>
                <button type="button" class="btn btn-danger clearButton" data-section="reviewers_report">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>
</body>
</html>
