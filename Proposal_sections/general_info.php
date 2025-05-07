<?php
session_start();
//include 'database_handling/general_info_db.php';

// Retrieve saved data (if available)
$generalInfo = $_SESSION['general_info'] ?? [
    'degree_name_english' => '',
    'degree_name_sinhala' => '',
    'degree_name_tamil' => '',
    'abbreviated_qualification' => '',
];

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>General Information</title>
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
        .form-footer {
            margin-top: 20px;
            text-align: right;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container mx-auto" style="max-width: 700px;">
            <div class="form-header">
                <h3>Section 1: General Information</h3>
            </div>

            <p class="mt-3">Please fill out the general information for the degree program below.</p>

            <form action="save_data.php" method="POST">
                <input type="hidden" name="form_type" value="general_info"> 

                <!-- Degree Name in Multiple Languages -->
                <div class="mb-3">
                    <label for="degreeNameEnglish" class="form-label">Name of Degree Programme (English) [Name of Qualification as per SLQF 2015]</label>
                    <input type="text" class="form-control" id="degreeNameEnglish" name="degree_name_english" value="<?php echo htmlspecialchars($generalInfo['degree_name_english']); ?>" placeholder="Enter the degree name in English" required>
                </div>
                <div class="mb-3">
                    <label for="degreeNameSinhala" class="form-label">Name of Degree Programme (Sinhala) [Name of Qualification as per SLQF 2015]</label>
                    <input type="text" class="form-control" id="degreeNameSinhala" name="degree_name_sinhala" value="<?php echo htmlspecialchars($generalInfo['degree_name_sinhala']); ?>" placeholder="Enter the degree name in Sinhala" required>
                </div>
                <div class="mb-3">
                    <label for="degreeNameTamil" class="form-label">Name of Degree Programme (Tamil) [Name of Qualification as per SLQF 2015]</label>
                    <input type="text" class="form-control" id="degreeNameTamil" name="degree_name_tamil" value="<?php echo htmlspecialchars($generalInfo['degree_name_tamil']); ?>" placeholder="Enter the degree name in Tamil" required>
                </div>

                <!-- Abbreviated Qualification -->
                <div class="mb-3">
                    <label for="abbreviatedQualificationEnglish" class="form-label">Abbreviated Qualification (English)</label>
                    <input type="text" class="form-control" id="abbreviatedQualificationEnglish" name="abbreviated_qualification_english" value="<?php echo htmlspecialchars($generalInfo['abbreviated_qualification']); ?>" placeholder="E.g., BSc, BA" required>
                </div>

                <!-- Navigation Buttons -->
                <div class="form-footer">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-primary" id=saveButton>Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="general_info">Clear All Data</button>
                </div>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>
            </form>
        </div>
    </div>
</body>
</html>