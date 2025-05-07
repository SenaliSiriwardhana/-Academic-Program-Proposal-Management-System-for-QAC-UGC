<?php
session_start();
//include 'database_handling/program_delivery_db.php';

// Retrieve saved data (if available)
$programDelivery = $_SESSION['program_delivery'] ?? ['program_delivery_description' => ''];


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Section 6: Program Delivery</title>
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
                <h3>Section 6: Program Delivery and Learner Support System</h3>
            </div>
            <form action="save_data.php" method="POST">
            <input type="hidden" name="form_type" value="program_delivery"> 
                <p>Please describe in detail the teaching-learning methods, resources, and activities for delivering the program.</p>

                <div class="mb-3">
                   <textarea class="form-control" id="programDeliveryDescription" name="program_delivery_description" rows="8" placeholder="Describe the teaching-learning methods and resources available for program delivery (e.g., teaching strategies, blended learning opportunities, and facilities)." required><?php echo htmlspecialchars($programDelivery['program_delivery_description']); ?></textarea>
                </div>

                <div class="text-end mt-4">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-success">Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="program_delivery">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>
</body>
</html>
