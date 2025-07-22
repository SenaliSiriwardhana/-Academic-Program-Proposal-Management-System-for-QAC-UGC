<?php
/**
 * This file renders the entire right-hand summary sheet pane.
 * It expects all necessary variables to be defined by review_proposal_ugc.php.
 */
?>

<div class="col-md-12">
    
    <div class="summary-pane">
        <div class="card">
            <div class="card-header bg-info text-white">
                <h4 class="mb-0">Summary Sheet</h4>
            </div>
            <div class="card-body" style="max-height: 90vh; overflow-y: auto;">
                
                <?php
                // This array defines all sections to be reviewed.
                $sections_to_review = [
                    'General Information' => ['type' => 'form', 'data' => $generalInfo],
                    'Program Entity' => ['type' => 'form', 'data' => $programEntity],
                    'Mandate Availability' => ['type' => 'table', 'data' => $mandateAvailability],
                    'Degree Details' => ['type' => 'form', 'data' => $degreeDetails],
                    'Program Grades' => ['type' => 'table', 'data' => $programGrades],
                    'Program Structure' => ['type' => 'table', 'data' => $programStructure],
                    'Program Content' => ['type' => 'table', 'data' => $programContent],
                    'Program Delivery and Learner Support System' => ['type' => 'form', 'data' => $programDelivery],
                    'Program Assessment Rules and Precodures' => ['type' => 'form', 'data' => $assessmentRules],
                    'Human Resources' => ['type' => 'table', 'data' => $humanResource],
                    'Physical Resources' => ['type' => 'table', 'data' => $physicalResource],
                    'Financial Resources' => ['type' => 'table', 'data' => $financialResource],
                    'Panel of Teachers' => ['type' => 'table', 'data' => $panelOfTeachers],
                    'Reviewers Report' => ['type' => 'table', 'data' => $reviewersReport],
                    'Reviewer Details' => ['type' => 'table', 'data' => $reviewerDetails],
                    'Compliance Check' => ['type' => 'form', 'data' => $complianceCheck],
                ];
                

                // A counter for reviewable items ---
                $total_review_items = 0;
                
                

                // A two-column layout *inside* the summary sheet for better readability
                echo '<div class="row">';
                foreach ($sections_to_review as $title => $details) {
                    if (empty($details['data'])) continue;

                    echo "<div class='col-md-12 mt-3'><h5 class='border-bottom pb-1'>{$title}</h5></div>";
                    $section_prefix = strtolower(str_replace([' ', '(', ')'], '_', $title));

                    if ($details['type'] === 'table') {
                        $total_review_items++;//New
                        echo "<div class='col-12'>";
                        $identifier = "table.{$section_prefix}";
                        renderReviewControls($identifier, $summary_data, $can_edit_summary,$proposal);
                        echo "</div>";
                    } else { // type is 'form'
                        foreach ($details['data'][0] as $key => $value) {
                             $total_review_items++; //New
                            echo "<div class='col-md-6 mb-3'>";
                            $identifier = "{$section_prefix}.{$key}";
                            echo "<label class='form-label fw-bold'>" . ucfirst(str_replace('_', ' ', $key)) . "</label>";
                            renderReviewControls($identifier, $summary_data, $can_edit_summary,$proposal);
                            echo "</div>";
                        }
                    }
                }
                echo '</div>'; // end inner row

                // --- NEW CODE START: Add a hidden input to the form with the total count ---
                // This is only necessary if the user can actually edit and submit the form.
                if ($can_edit_summary) {
                    echo "<input type='hidden' id='total_review_items' name='total_review_items' value='{$total_review_items}'>";
                }
                // --- NEW CODE END ---

                ?>

                

            </div> <!-- end card-body -->
        </div> <!-- end card -->
    </div> <!-- end summary-pane -->
</div> <!-- end col-md-5 -->