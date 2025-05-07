<?php
session_start();

//include 'database_handling/program_structure_db.php';
// Retrieve saved data (if available)
$programStructure = $_SESSION['program_structure'] ?? [];

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Program Structure</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .form-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 50px;
            max-width: 1280px; /* Increased width */
        }

        .form-header {
            background-color: #007bff;
            color: white;
            padding: 15px;
            border-radius: 10px 10px 0 0;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            vertical-align: middle;
        }

        table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container mx-auto">
            <div class="form-header">
                <h3>Section 4: Program Structure</h3>
            </div>

            <p class="mt-3">Provide detailed information about the program structure below.</p>

            <form action="save_data.php" method="POST">
                <input type="hidden" name="form_type" value="program_structure">
                <table id="programStructureTable">
                    <thead>
                        <tr>
                            <th>Semesters</th>
                            <th>Module/Course Code</th>
                            <th>Module/Course Name</th>
                            <th>Credit Value</th>
                            <th>Status (Compulsory/Optional)</th>
                            <th>Existing/New</th>
                            <th>Modules/Courses related to qualifier 1</th>
                            <th>Modules/Courses related to qualifier 2</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (!empty($programStructure)): ?>
                            <?php foreach ($programStructure as $index => $module): ?>
                        <tr>
                            <td><input type="text" class="form-control" name="semesters[]" value="<?php echo htmlspecialchars($module['semester']); ?>" required></td>
                            <td><input type="text" class="form-control" name="module_code[]" value="<?php echo htmlspecialchars($module['module_code']); ?>" required></td>
                            <td><input type="text" class="form-control" name="module_name[]" value="<?php echo htmlspecialchars($module['module_name']); ?>" required></td>
                            <td><input type="number" class="form-control" name="credit_value[]" value="<?php echo htmlspecialchars($module['credit_value']); ?>" required></td>
                            <td>
                                <select class="form-select" name="module_status[]">
                                <option value="Compulsory" <?php if ($module['module_status'] === 'Compulsory') echo 'selected'; ?>>Compulsory</option>
                                <option value="Optional" <?php if ($module['module_status'] === 'Optional') echo 'selected'; ?>>Optional</option>
                                </select>
                            </td>
                            <td>
                                <select class="form-select" name="module_type[]">
                                <option value="Existing" <?php if ($module['module_type'] === 'Existing') echo 'selected'; ?>>Existing</option>
                                <option value="New" <?php if ($module['module_type'] === 'New') echo 'selected'; ?>>New</option>
                                </select>
                            </td>
                            <td><input type="checkbox" name="qualifier1_related[<?php echo $index; ?>]" value="Yes" <?php if ($module['qualifier1_related'] === 'Yes') echo 'checked'; ?>></td>
                            <td><input type="checkbox" name="qualifier2_related[<?php echo $index; ?>]" value="Yes" <?php if ($module['qualifier2_related'] === 'Yes') echo 'checked'; ?>></td>
                            <td><button type="button" class="btn btn-danger" onclick="removeRow(this)">Remove</button></td>
                        </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                    
                            <!-- Default Empty Row if No Data Exists -->
                        <tr>
                            <td><input type="text" class="form-control" name="semesters[]" placeholder="Enter semester" required></td>
                            <td><input type="text" class="form-control" name="module_code[]" placeholder="Enter code" required></td>
                            <td><input type="text" class="form-control" name="module_name[]" placeholder="Enter name" required></td>
                            <td><input type="number" class="form-control" name="credit_value[]" placeholder="Enter credits" required></td>
                            <td>
                                <select class="form-select" name="status[]">
                                    <option value="Compulsory">Compulsory</option>
                                    <option value="Optional">Optional</option>
                                </select>
                             </td>
                            <td>
                                <select class="form-select" name="module_type[]">
                                    <option value="Existing">Existing</option>
                                    <option value="New">New</option>
                                </select>
                            </td>
                            <td><input type="checkbox" name="qualifier1_related[]" value="Yes"></td>
                            <td><input type="checkbox" name="qualifier2_related[]" value="Yes"></td>
                            <td><button type="button" class="btn btn-danger" onclick="removeRow(this)">Remove</button></td>
                        </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
                <button type="button" class="btn btn-primary mt-3" onclick="addRow()">Add Row</button>

                <div class="mt-3">
                <label for="totalModuleCredits" class="form-label"><strong>Total Module Credits:</strong></label>
                <input type="text" id="totalModuleCredits" class="form-control" readonly value="0">
                </div>


                <div class="form-footer text-end mt-4">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-success">Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="program_structure">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>

    <script>
        function addRow() {
            const tableBody = document.querySelector('#programStructureTable tbody');
            const newRow = document.createElement('tr');

            newRow.innerHTML = `
                <td><input type="text" class="form-control" name="semesters[]" placeholder="Enter semester" required></td>
                <td><input type="text" class="form-control" name="module_code[]" placeholder="Enter code" required></td>
                <td><input type="text" class="form-control" name="module_name[]" placeholder="Enter name" required></td>
                <td><input type="number" class="form-control" name="credit_value[]" placeholder="Enter credits" required></td>
                <td>
                    <select class="form-select" name="status[]">
                        <option value="Compulsory">Compulsory</option>
                        <option value="Optional">Optional</option>
                    </select>
                </td>
                <td>
                    <select class="form-select" name="module_type[]">
                        <option value="Existing">Existing</option>
                        <option value="New">New</option>
                    </select>
                </td>
                <td><input type="checkbox" name="qualifier1_related[]" value="Yes"></td>
                <td><input type="checkbox" name="qualifier2_related[]" value="Yes"></td>
                <td><button type="button" class="btn btn-danger" onclick="removeRow(this)">Remove</button></td>
            `;
            tableBody.appendChild(newRow);
        }

        function removeRow(button) {
            const row = button.closest('tr');
            row.remove();
        }
    </script>

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
