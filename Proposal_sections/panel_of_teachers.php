<?php
session_start();
include 'form_field_helper.php';

// Retrieve saved data (if available)
$panelOfTeachers = $_SESSION['panel_of_teachers'] ?? [];


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Section 9: Panel of Teachers/Internal Resource Persons</title>
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
            max-width: 1200px;
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

        .add-row-btn {
            margin-top: 15px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container mx-auto">
            <div class="form-header">
                <h3>Section 9: Panel of Teachers/Internal Resource Persons</h3>
            </div>
            <form action="save_data.php" method="POST">
            <input type="hidden" name="form_type" value="panel_of_teachers"> 
                <p class="mt-4">Provide details about the teaching hours and resource persons involved in the programme.</p>
                <?php
                    $table_identifier = 'table.panel_of_teachers';
                    // Use the correct function for the component
                    render_component_feedback($table_identifier);
                ?>
    
                <!-- Use the correct function for the group -->
                <fieldset <?php echo get_group_lock_attr($table_identifier); ?>>
                <table class="table table-bordered text-center" id="panelTable">
                    <thead class="table-light">
                        <tr>
                            <th rowspan="2">Name of the Lecturer</th>
                            <th rowspan="2">Designation</th>
                            <th colspan="6">Average No. of Teaching Hours/Week</th>
                            <th rowspan="2">Action</th>
                        </tr>
                        <tr>
                            <th>Internal <br>Undergraduate</th>
                            <th>Internal <br>Postgraduate</th>
                            <th>External <br>Undergraduate</th>
                            <th>External PG <br>Postgraduate</th>
                            <th>Proposed Programs</th>
                            <th>Total Hours</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php if (!empty($panelOfTeachers)): ?>
                        <?php foreach ($panelOfTeachers as $teacher): ?>
                            <tr>
                                <input type="hidden" name="teacher_id[]" value="<?php echo htmlspecialchars($teacher['teacher_id'] ?? ''); ?>"></span>
                                <td><input type="text" class="form-control" name="lecturer_name[]" value="<?php echo htmlspecialchars($teacher['lecturer_name']); ?>"></td>
                                <td><input type="text" class="form-control" name="designation[]" value="<?php echo htmlspecialchars($teacher['designation']); ?>"></td>
                                <td><input type="number" class="form-control hours-input" name="internal_ug_hours[]" value="<?php echo htmlspecialchars($teacher['internal_ug_hours']); ?>"></td>
                                <td><input type="number" class="form-control hours-input" name="internal_pg_hours[]" value="<?php echo htmlspecialchars($teacher['internal_pg_hours']); ?>"></td>
                                <td><input type="number" class="form-control hours-input" name="external_ug_hours[]" value="<?php echo htmlspecialchars($teacher['external_ug_hours']); ?>"></td>
                                <td><input type="number" class="form-control hours-input" name="external_pg_hours[]" value="<?php echo htmlspecialchars($teacher['external_pg_hours']); ?>"></td>
                                <td><input type="number" class="form-control hours-input" name="proposed_program_hours[]" value="<?php echo htmlspecialchars($teacher['proposed_program_hours']); ?>"></td>
                                <td><input type="number" class="form-control total-hours" name="total_hours[]" value="<?php echo htmlspecialchars($teacher['total_hours']); ?>" readonly></td>
                                <td><button type="button" class="btn btn-danger remove-row-btn">Remove</button></td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                            <tr>
                                <input type="hidden" name="teacher_id[]" value=""></span>
                                <td><input type="text" class="form-control" name="lecturer_name[]"></td>
                                <td><input type="text" class="form-control" name="designation[]"></td>
                                <td><input type="number" class="form-control hours-input" name="internal_ug_hours[]"></td>
                                <td><input type="number" class="form-control hours-input" name="internal_pg_hours[]"></td>
                                <td><input type="number" class="form-control hours-input" name="external_ug_hours[]"></td>
                                <td><input type="number" class="form-control hours-input" name="external_pg_hours[]"></td>
                                <td><input type="number" class="form-control hours-input" name="proposed_program_hours[]"></td>
                                <td><input type="number" class="form-control total-hours" name="total_hours[]" readonly value="0"></td>
                                <td><button type="button" class="btn btn-danger remove-row-btn">Remove</button></td>
                            </tr>
                <?php endif; ?>
                    </tbody>
                </table>

                <button type="button" class="btn btn-primary add-row-btn" id="addRow">Add Row</button>

                <div class="text-end">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-success">Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="panel_of_teachers">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>

    <script>
        // Function to add a new row to the table
        document.getElementById('addRow').addEventListener('click', function () {
            const tableBody = document.querySelector("#panelTable tbody");
            const newRow = document.createElement("tr");
            newRow.innerHTML = `
                <input type="hidden" name="teacher_id[]" value=""></span>
                <td><input type="text" class="form-control" name="lecturer_name[]"></td>
                <td><input type="text" class="form-control" name="designation[]"></td>
                <td><input type="number" class="form-control" name="internal_ug_hours[]"></td>
                <td><input type="number" class="form-control" name="internal_pg_hours[]"></td>
                <td><input type="number" class="form-control" name="external_ug_hours[]"></td>
                <td><input type="number" class="form-control" name="external_pg_hours[]"></td>
                <td><input type="number" class="form-control" name="proposed_program_hours[]"></td>
                <td><input type="number" class="form-control" name="total_hours[]" readonly></td>
                <td><button type="button" class="btn btn-danger remove-row-btn">Remove</button></td>
            `;
            tableBody.appendChild(newRow);
        });

        // Function to remove a row from the table
        document.querySelector("#panelTable").addEventListener("click", function (e) {
            if (e.target.classList.contains("remove-row-btn")) {
                e.target.closest("tr").remove();
            }
        });
    </script>
</body>
</html>
