<?php
session_start();

include 'form_field_helper.php';
// Retrieve saved data (if available)
$programContent = $_SESSION['program_content'] ?? [];


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Section 5: Program Content</title>
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
            max-width: 1800px;
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
                <h3>Section 5: Program Content</h3>
            </div>
            <form action="save_data.php" method="POST">
                <input type="hidden" name="form_type" value="program_content">
                <p>Fill in the details of each module in the program. Use the "Add Row" button to include multiple modules.</p>

                <?php
                    $table_identifier = 'table.program_content';
                    // Use the correct function for the component
                    render_component_feedback($table_identifier);
                ?>
    
                <!-- Use the correct function for the group -->
                <fieldset <?php echo get_group_lock_attr($table_identifier); ?>>
                <table class="table table-bordered" id="moduleTable">
                    <thead class="table-primary">
                        <tr>
                            <th>Semester</th>
                            <th>Module Code</th>
                            <th>Module Name</th>
                            <th>Credit Value</th>
                            <th>Core/<br>Optional</th>
                            <th>Hourly Breakdown <br> (Lectures/Practical/Independent Learning)</th>
                            <th>Learning Outcomes</th>
                            <th>Content</th>
                            <th>Teaching Methods</th>
                            <th>Assessment Strategy </th>
                            <th>Recommended Reading</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php if (!empty($programContent)): ?>
                    <?php foreach ($programContent as $module): ?>
                        <tr>
                            <td><input type="number" class="form-control" name="semester[]" value="<?php echo htmlspecialchars($module['semester']); ?>" required></td>
                            <td><input type="text" class="form-control" name="module_code[]" value="<?php echo htmlspecialchars($module['module_code']); ?>" required></td>
                            <td><input type="text" class="form-control" name="module_name[]" value="<?php echo htmlspecialchars($module['module_name']); ?>" required></td>
                            <td><input type="number" class="form-control" name="credit_value[]" value="<?php echo htmlspecialchars($module['credit_value']); ?>" required></td>
                            <td>
                                <select class="form-select" name="core_optional[]" required>
                                    <option value="Core" <?php if ($module['core_optional'] === 'Core') echo 'selected'; ?>>Core</option>
                                    <option value="Optional" <?php if ($module['core_optional'] === 'Optional') echo 'selected'; ?>>Optional</option>
                                </select>
                            </td>
                            <td>
                                <div class="d-flex">
                                    <input type="number" class="form-control me-1" name="lecture_hours[]" value="<?php echo htmlspecialchars($module['lecture_hours']); ?>" required>
                                    <input type="number" class="form-control me-1" name="practical_hours[]" value="<?php echo htmlspecialchars($module['practical_hours']); ?>" required>
                                    <input type="number" class="form-control" name="independent_hours[]" value="<?php echo htmlspecialchars($module['independent_hours']); ?>" required>
                                </div>
                            </td>
                            <td><textarea class="form-control" name="learning_outcomes[]" rows="2" required><?php echo htmlspecialchars($module['learning_outcomes']); ?></textarea></td>
                            <td><textarea class="form-control" name="module_content[]" rows="2" required><?php echo htmlspecialchars($module['module_content']); ?></textarea></td>
                            <td><textarea class="form-control" name="teaching_methods[]" rows="2" required><?php echo htmlspecialchars($module['teaching_methods']); ?></textarea></td>
                            <td>
                                <div>
                                    <input type="number" class="form-control mb-2" name="continuous_assessment_percentage[]" value="<?php echo htmlspecialchars($module['continuous_assessment_percentage']); ?>" required>
                                    <input type="number" class="form-control" name="final_assessment_percentage[]" value="<?php echo htmlspecialchars($module['final_assessment_percentage']); ?>" required>
                                </div>
                            </td>
                            <td><textarea class="form-control" name="recommended_reading[]" rows="2" required><?php echo htmlspecialchars($module['recommended_reading']); ?></textarea></td>
                            <td>
                                <button type="button" class="btn btn-danger btn-sm remove-row">Remove</button>
                            </td>
                        </tr>
                    <?php endforeach; ?>
            <?php else: ?>

        <!-- If no data is available, keep the default empty row -->
                        <tr>
                            <td><input type="number" class="form-control" name="semester[]" placeholder="Enter Semester" required></td>
                            <td><input type="text" class="form-control" name="module_code[]" placeholder="Enter Code" required></td>
                            <td><input type="text" class="form-control" name="module_name[]" placeholder="Enter Name" required></td>
                            <td><input type="number" class="form-control" name="credit_value[]" placeholder="Enter Value" required></td>
                            <td>
                                <select class="form-select" name="core_optional[]" required>
                                    <option value="Core">Core</option>
                                    <option value="Optional">Optional</option>
                                </select>
                            </td>
                            <td>
                                <div class="d-flex">
                                    <input type="number" class="form-control me-1" name="lecture_hours[]" placeholder="Lectures" required>
                                    <input type="number" class="form-control me-1" name="practical_hours[]" placeholder="Practical" required>
                                    <input type="number" class="form-control" name="independent_hours[]" placeholder="Independent" required>
                                </div>
                            </td>
                            <td><textarea class="form-control" name="learning_outcomes[]" rows="2" placeholder="Describe outcomes" required></textarea></td>
                            <td><textarea class="form-control" name="module_content[]" rows="2" placeholder="Main topics" required></textarea></td>
                            <td><textarea class="form-control" name="teaching_methods[]" rows="2" placeholder="Teaching methods" required></textarea></td>
                            <td>
                                <div>
                                    <input type="number" class="form-control mb-2" name="continuous_assessment_percentage[]" placeholder="Continuous %" required>
                                    <input type="number" class="form-control" name="final_assessment_percentage[]" placeholder="Final %" required>
                                </div>
                            </td>
                            <td><textarea class="form-control" name="recommended_reading[]" rows="2" placeholder="Recommended reading" required></textarea></td>
                            <td>
                                <button type="button" class="btn btn-danger btn-sm remove-row">Remove</button>
                            </td>
                        </tr>
                    <?php endif; ?>
                    </tbody>
                </table>
                <button type="button" class="btn btn-primary" id="addRow">Add Row</button>

                <div class="mt-3">
                <label for="totalModuleCredits" class="form-label"><strong>Total Module Credits:</strong></label>
                <input type="text" id="totalModuleCredits" class="form-control" readonly value="0">
                </div>

                <div class="text-end mt-4">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-success">Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="program_content">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>

    <script>
        // Add new row to the table
        document.getElementById('addRow').addEventListener('click', () => {
            const tableBody = document.querySelector('#moduleTable tbody');
            const newRow = document.createElement('tr');
            newRow.innerHTML = `
                <td><input type="number" class="form-control" name="semester[]" placeholder="1" required></td>
                <td><input type="text" class="form-control" name="module_code[]" placeholder="Enter Code" required></td>
                <td><input type="text" class="form-control" name="module_name[]" placeholder="Enter Name" required></td>
                <td><input type="number" class="form-control" name="credit_value[]" placeholder="Enter Value" required></td>
                <td>
                    <select class="form-select" name="core_optional[]" required>
                        <option value="Core">Core</option>
                        <option value="Optional">Optional</option>
                    </select>
                </td>
                <td>
                    <div class="d-flex">
                        <input type="number" class="form-control me-1" name="lecture_hours[]" placeholder="Lectures" required>
                        <input type="number" class="form-control me-1" name="practical_hours[]" placeholder="Practical" required>
                        <input type="number" class="form-control" name="independent_hours[]" placeholder="Independent" required>
                    </div>
                </td>
                <td><textarea class="form-control" name="learning_outcomes[]" rows="2" placeholder="Describe outcomes" required></textarea></td>
                <td><textarea class="form-control" name="module_content[]" rows="2" placeholder="Main topics" required></textarea></td>
                <td><textarea class="form-control" name="teaching_methods[]" rows="2" placeholder="Teaching methods" required></textarea></td>
                <td>
                    <div>
                        <input type="number" class="form-control mb-2" name="continuous_assessment_percentage[]" placeholder="Continuous %" required>
                        <input type="number" class="form-control" name="final_assessment_percentage[]" placeholder="Final %" required>
                    </div>
                </td>
                <td><textarea class="form-control" name="recommended_reading[]" rows="2" placeholder="Recommended reading" required></textarea></td>
                <td>
                    <button type="button" class="btn btn-danger btn-sm remove-row">Remove</button>
                </td>
            `;
            tableBody.appendChild(newRow);
        });

        // Remove a row from the table
        document.addEventListener('click', (e) => {
            if (e.target && e.target.classList.contains('remove-row')) {
                e.target.closest('tr').remove();
            }
        });
    </script>

    <!-- Handle Total Credits -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.querySelector("form");
        
            form.addEventListener("submit", function (event) {
            let degreeCredits = <?php echo isset($_SESSION['degree_details']['total_credits']) ? (int) $_SESSION['degree_details']['total_credits'] : 0; ?>;
            
            let moduleCredits = 0;
            document.querySelectorAll("input[name='credit_value[]']").forEach(input => {
                moduleCredits += parseInt(input.value) || 0; // Convert to number, default to 0
            });

            if ((degreeCredits === 90 && moduleCredits < 90) || (degreeCredits === 120 && moduleCredits < 120)) {
                alert(`Total credits must be at least ${degreeCredits} or greater.`);
                event.preventDefault(); // Stop form submission
            }
        });
    });
    </script>

    <!--Fill total credit value textbox  -->
    <script>
            function calculateTotalCredits() {
            let total_credits = 0;
            document.querySelectorAll("input[name='credit_value[]']").forEach(input => {
            total_credits += parseFloat(input.value) || 0; // Convert to number, default to 0
            });

            document.getElementById("totalModuleCredits").value = total_credits; // Update the read-only field
        }

         // Attach event listeners to all credit input fields
            document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll("input[name='credit_value[]']").forEach(input => {
            input.addEventListener("input", calculateTotalCredits);
            });

             calculateTotalCredits(); // Initialize on page load
            });
</script>

</body>
</html>
