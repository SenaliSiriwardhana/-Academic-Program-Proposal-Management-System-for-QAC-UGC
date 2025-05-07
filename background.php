<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simplified Faculty Input UI</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .section {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .section h4 {
            margin-top: 0;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007BFF;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function addDepartment() {
            const container = document.getElementById('departments-container');
            const section = document.createElement('div');
            section.className = 'section';

            section.innerHTML = `
                <h4>Department Details</h4>
                <div class="form-group">
                    <label for="department">Department Name</label>
                    <input type="text" name="department[]" placeholder="Enter department name">
                </div>
                <div class="form-group">
                    <label for="degree">Offered Degree Programme</label>
                    <input type="text" name="degree[]" placeholder="Enter degree programme">
                </div>
                <div class="form-group">
                    <label for="abbreviation">Abbreviation</label>
                    <input type="text" name="abbreviation[]" placeholder="Enter abbreviation">
                </div>
                <div class="form-group">
                    <label for="student-intake">Student Intake</label>
                    <input type="number" name="student-intake[]" placeholder="Enter student intake">
                </div>
                <div class="form-group">
                    <label for="staff-cadres">Staff Cadres</label>
                    <input type="number" name="staff-cadres[]" placeholder="Enter staff cadres">
                </div>
                <div class="form-group">
                    <label for="educational-facilities">Educational Facilities</label>
                    <textarea name="educational-facilities[]" rows="3" placeholder="Enter educational facilities"></textarea>
                </div>
                <div class="form-group">
                    <label for="common-facilities">Common Facilities</label>
                    <textarea name="common-facilities[]" rows="3" placeholder="Enter common facilities"></textarea>
                </div>
            `;

            container.appendChild(section);
        }
    </script>
</head>
<body>
    <h2>Simplified Faculty Input</h2>

    <div class="form-group">
        <label for="faculty">Faculty</label>
        <select name="faculty" id="faculty">
            <option value="Management">Management</option>
            <option value="Engineering">Engineering</option>
            <option value="Arts">Arts</option>
            <!-- Add more faculties as needed -->
        </select>
    </div>

    <div id="departments-container">
        <!-- Dynamic department sections will be added here -->
    </div>

    <button type="button" class="btn" onclick="addDepartment()">Add Department</button>
    <button type="submit" class="btn">Submit</button>
</body>
</html>
