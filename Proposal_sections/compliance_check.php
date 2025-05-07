<?php
session_start();
//include 'database_handling/compliance_check_db.php';

// Retrieve saved data (if available)
$complianceCheck = $_SESSION['compliance_check'] ?? [
    'resources_commence' => '',
    'fallback_options' => '',
    'fallback_qualification' => '',
    'collaboration' => '',
    'collaboration_details' => '',
    'access_facilities' => '',
    'professional_membership' => '',
];



?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Section 10: Additional Program Aspects</title>
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

        .form-section {
            margin-top: 30px;
        }

        .form-section h5 {
            font-weight: bold;
        }

        .form-section p {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container mx-auto">
            <div class="form-header">
                <h3>Section 11: Compliance Check (Additional Program Aspects) </h3>
            </div>
            <form action="save_data.php" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="form_type" value="compliance_check">
                <!-- Aspect 8 -->
                <div class="form-section">
                    <h5>Resources to Commence Operation</h5>
                    <label>Does the Faculty have resources to commence operation of new degree programme, pending allocation of resources requested?</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="resources_commence" id="resourcesYes" value="Yes"
                        <?php if ($complianceCheck['resources_commence'] === 'Yes') echo 'checked'; ?>>
                        <label class="form-check-label" for="resourcesYes">Yes</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="resources_commence" id="resourcesNo" value="No" 
                        <?php if ($complianceCheck['resources_commence'] === 'No') echo 'checked'; ?>>
                        <label class="form-check-label" for="resourcesNo">No</label>
                    </div>
                </div>

                <!-- Aspect 9 -->
                <div class="form-section">
                    <h5>Fallback Options</h5>
                    <label>a. Does the programme have fallback options/s at different levels?</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="fallback_options" id="fallbackYes" value="Yes" 
                        <?php if ($complianceCheck['fallback_options'] === 'Yes') echo 'checked'; ?>>
                        <label class="form-check-label" for="fallbackYes">Yes</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="fallback_options" id="fallbackNo" value="No" 
                        <?php if ($complianceCheck['fallback_options'] === 'No') echo 'checked'; ?>>
                        <label class="form-check-label" for="fallbackNo">No</label>
                    </div>

                    <div class="mt-3">
                        <label>b. If yes, state the fallback qualification/s:</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="fallback_qualification[]" id="diploma" value="Diploma (SLQF 3)" 
                            <?php if (!empty($complianceCheck['fallback_qualification']) && in_array('Diploma (SLQF 3)', $complianceCheck['fallback_qualification'])) echo 'checked'; ?>>
                            <label class="form-check-label" for="diploma">Diploma (SLQF 3)</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="fallback_qualification[]" id="higherDiploma" value="Higher Diploma (SLQF 4)" 
                            <?php if (!empty($complianceCheck['fallback_qualification']) && in_array('Higher Diploma (SLQF 4)', $complianceCheck['fallback_qualification'])) echo 'checked'; ?>>
                            <label class="form-check-label" for="higherDiploma">Higher Diploma (SLQF 4)</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="fallback_qualification[]" id="bachelorsDegree" value="Bachelors Degree (SLQF 5)" 
                            <?php if (!empty($complianceCheck['fallback_qualification']) && in_array('Bachelors Degree (SLQF 5)', $complianceCheck['fallback_qualification'])) echo 'checked'; ?>>
                            <label class="form-check-label" for="bachelorsDegree">Bachelors Degree (SLQF 5)</label>
                        </div>
                    </div>
                    <div class="mt-3">
                        <label>Attach supporting document (optional):</label>
                        <input type="file" class="form-control" name="fallback_attachment"> 
                        <?php if (!empty($_SESSION['compliance_check']['fallback_attachment'])): ?>
                            <p>Uploaded: 
                                <a href="<?php echo $_SESSION['compliance_check']['fallback_attachment']; ?>" target="_blank">View File</a>
                            </p>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- Aspect 10 -->
                <div class="form-section">
                    <h5>Collaboration</h5>
                    <label>Does the programme have any collaboration with another Department/Faculty/Institute outside universities?</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="collaboration" id="collaborationYes" value="Yes" 
                        <?php if ($complianceCheck['collaboration'] === 'Yes') echo 'checked'; ?>>
                        <label class="form-check-label" for="collaborationYes">Yes</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="collaboration" id="collaborationNo" value="No" 
                        <?php if ($complianceCheck['collaboration'] === 'No') echo 'checked'; ?>>
                        <label class="form-check-label" for="collaborationNo">No</label>
                    </div>
                    <div class="mt-3">
                        <label>If yes, give details:</label>
                        <textarea class="form-control" name="collaboration_details" rows="3"><?php echo htmlspecialchars($complianceCheck['collaboration_details'] ?? ''); ?></textarea>
                    </div>
                    <div class="mt-3">
                        <label>Attach supporting document (optional):</label>
                        <input type="file" class="form-control" name="collaboration_attachment">
                        <?php if (!empty($_SESSION['compliance_check']['collaboration_attachment'])): ?>
                            <p>Uploaded: 
                                <a href="<?php echo $_SESSION['compliance_check']['collaboration_attachment']; ?>" target="_blank">
                                    View File
                                </a>
                            </p>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- Aspect 11 -->
                <div class="form-section">
                    <h5>Access to Facilities</h5>
                    <label>Access to facilities outside the university.</label>
                    <p>If yes, copy of the relevant agreement/MoU with the appropriate authority should be attached.</p>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="access_facilities" id="accessYes" value="Yes" 
                        <?php if ($complianceCheck['access_facilities'] === 'Yes') echo 'checked'; ?>>
                        <label class="form-check-label" for="accessYes">Yes</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="access_facilities" id="accessNo" value="No"
                        <?php if ($complianceCheck['access_facilities'] === 'No') echo 'checked'; ?>>
                        <label class="form-check-label" for="accessNo">No</label>
                    </div>
                    <div class="mt-3">
                        <label>Attach supporting document (optional):</label>
                        <input type="file" class="form-control" name="access_facilities_attachment">
                        <?php if (!empty($complianceCheck['access_facilities_attachment'])): ?>
                        <p>Uploaded: <a href="<?php echo $complianceCheck['access_facilities_attachment']; ?>" target="_blank">View File</a></p>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- Aspect 12 -->
                <div class="form-section">
                    <h5>Membership in Professional Bodies</h5>
                    <label>Do the graduates need membership in the professional body after completion of the Degree?</label>
                    <p>If yes, copy of the document on recognition/provisional recognition of the degree by the professional body should be attached.</p>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="professional_membership" id="membershipYes" value="Yes" 
                        <?php if ($complianceCheck['professional_membership'] === 'Yes') echo 'checked'; ?>>
                        <label class="form-check-label" for="membershipYes">Yes</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="professional_membership" id="membershipNo" value="No" 
                        <?php if ($complianceCheck['professional_membership'] === 'No') echo 'checked'; ?>>
                        <label class="form-check-label" for="membershipNo">No</label>
                    </div>
                    <div class="mt-3">
                        <label>Attach supporting document (optional):</label>
                        <input type="file" class="form-control" name="membership_attachment">
                        <?php if (!empty($complianceCheck['membership_attachment'])): ?>
                        <p>Uploaded: <a href="<?php echo $complianceCheck['membership_attachment']; ?>" target="_blank">View File</a></p>
                        <?php endif; ?>
                    </div>
                </div>

                <div class="text-end mt-4">
                    <a href="<?php echo isset($_SESSION['is_editing']) ? '/qac_ugc/new_proposal_section.php?proposal_id='.$_SESSION['editing_proposal_id'].'&edit=true' :  '/qac_ugc/new_proposal_section.php' ?>"; class="btn btn-secondary">Back</a>
                    <button type="submit" class="btn btn-success" id=saveButton>Save</button>
                    <button type="button" class="btn btn-danger clearButton" data-section="compliance_check">Clear All Data</button>

                <!-- Link to the external JavaScript file - Clear All Data Button -->
                <script src="/qac_ugc/Proposal_sections/Clear_Data_Button/clear_data.js"></script>

                </div>
            </form>
        </div>
    </div>
</body>
</html>
