<?php
session_start();

include 'form_field_helper.php';


// Retrieve saved data (if available)
$resourceRequirements = $_SESSION['resource_requirements'] ?? [];

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Section 8: Resource Requirements</title>
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
        table input {
            max-width: 120px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container mx-auto">
            <div class="form-header">
                <h3>Section 8: Resource Requirements</h3>
            </div>
            <form action="save_data.php" method="POST">
                <input type="hidden" name="form_type" value="resource_requirements">
                
                <!-- Physical Resources -->
                <h5 class="mt-4">Physical Resources</h5>
                <?php
                    $table_identifier = 'table.physical_resources';
                    // Use the correct function for the component
                    render_component_feedback($table_identifier);
                ?>
    
                <!-- Use the correct function for the group -->
                <fieldset <?php echo get_group_lock_attr($table_identifier); ?>>
                <table class="table table-bordered text-center">
                    <thead class="table-light">
                        <tr>
                            <th>Physical Resources</th>
                            <th>Existing</th>
                            <th>Year 1</th>
                            <th>Year 2</th>
                            <th>Year 3</th>
                            <th>Year 4</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        $physical_resources = [
                            "Land extent (Acre/Hectare)", "Office Space", "No. of Lecture Theatres", "No. of Laboratories", "No. of Computers with Internet Facilities", "Reading Rooms/Halls", "Staff Common Rooms/Amenities", "Student Common Rooms/Amenities", "Other"
                        ];
                        
                        foreach ($physical_resources as $index => $resource) {
                            $key = strtolower(str_replace([' ', '/', '.'], '_', $resource));
                            ?>
                            <tr>
                                <td>
                                <?php echo htmlspecialchars($resource); ?>
                                </td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_existing" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_existing'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year1" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year1'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year2" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year2'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year3" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year3'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year4" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year4'] ?? ''); ?>"></td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </fieldset>
                <!-- Financial Resources -->
                <h5 class="mt-5">Financial Resources</h5>
                <?php
                    $table_identifier = 'table.financial_resources';
                    // Use the correct function for the component
                    render_component_feedback($table_identifier);
                ?>
    
                <!-- Use the correct function for the group -->
                <fieldset <?php echo get_group_lock_attr($table_identifier); ?>>
                <table class="table table-bordered text-center">
                    <thead class="table-light">
                        <tr>
                            <th>Financial Resource Type</th>
                            <th>Year 1</th>
                            <th>Year 2</th>
                            <th>Year 3</th>
                            <th>Year 4</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        $financial_resources = ["Capital Expenditure", "Recurrent Expenditure"];
                        
                        foreach ($financial_resources as $index => $resource) {
                            $key = strtolower(str_replace([' ', '/', '.'], '_', $resource));
                            ?>
                            <tr>
                                <td>
                                <?php echo htmlspecialchars($resource); ?>
                                </td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year1" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year1'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year2" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year2'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year3" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year3'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year4" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year4'] ?? ''); ?>"></td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </fieldset>
                
                <!-- Staff Resources -->
                <h5 class="mt-5">Staff Resources</h5>
                <?php
                    $table_identifier = 'table.human_resources';
                    // Use the correct function for the component
                    render_component_feedback($table_identifier);
                ?>
    
                <!-- Use the correct function for the group -->
                <fieldset <?php echo get_group_lock_attr($table_identifier); ?>>
                <table class="table table-bordered text-center">
                    <thead class="table-light">
                        <tr>
                            <th>Staff Type</th>
                            <th>Year 1</th>
                            <th>Year 2</th>
                            <th>Year 3</th>
                            <th>Year 4</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        $staff_resources = ["Lecturers", "Instructors/Demonstrators", "Technical Grades", "Management Assistants", "Minor Staff"];
                        
                        foreach ($staff_resources as $index => $resource) {
                            $key = strtolower(str_replace([' ', '/', '.'], '_', $resource));
                            ?>
                            <tr>
                                <td>
                                <?php echo htmlspecialchars($resource); ?>
                                </td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year1" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year1'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year2" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year2'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year3" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year3'] ?? ''); ?>"></td>
                                <td><input type="text" class="form-control" name="<?php echo $key; ?>_year4" value="<?php echo htmlspecialchars($resourceRequirements[$key.'_year4'] ?? ''); ?>"></td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </fieldset>
            
                <div class="text-end mt-4">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-success">Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="resource_requirements">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>
</body>
</html>




