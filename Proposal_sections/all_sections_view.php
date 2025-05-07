<?php
session_start();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Summary</title>
    <style>
        body { font-family: Arial, sans-serif; font-size: 14px; }
        h1 { text-align: center; }
        h2 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 5px; margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
        a { color: #3498db; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<h1>Application Summary</h1>

<?php
$sections = [
    "general_info" => "General Information",
    "degree_details" => "Degree Details",
    "program_entity" => "Program Entity",
    "assessment_rules" => "Assessment Rules",
    "compliance_check" => "Compliance Check",
    "panel_of_teachers" => "Panel of Teachers",
    "program_content" => "Program Content",
    "program_delivery" => "Program Delivery",
    "program_structure" => "Program Structure",
    "resource_requirements" => "Resource Requirements",
    "reviewers_report" => "Reviewers Report"
];

foreach ($sections as $session_key => $section_name) {
    if (!isset($_SESSION[$session_key]) || empty($_SESSION[$session_key])) {
        continue; // Skip if section data is missing
    }

    echo "<h2>{$section_name}</h2>";
    echo "<table>";

    foreach ($_SESSION[$session_key] as $key => $value) {
        // Medium of Instruction: Show only selected values
        if ($key === "medium_of_instruction" && is_array($value)) {
            $selectedMediums = array_filter($value); // Only keep selected values
            $formattedValue = implode(", ", $selectedMediums);
        }
        // Mandate Availability Table (Program Entity)
        elseif ($session_key === "program_entity" && $key === "mandate_availability" && is_array($value)) {
            echo "<tr><th colspan='2'>Mandate Availability</th></tr>";
            echo "<tr><th>Category</th><th>Status</th></tr>";
            foreach ($value as $category => $status) {
                echo "<tr><td>" . ucfirst($category) . "</td><td>" . ucfirst($status) . "</td></tr>";
            }
            continue;
        }
        // Program Reviews Table (Degree Details)
        elseif ($session_key === "degree_details" && $key === "program_reviews" && is_array($value)) {
            echo "<tr><th colspan='3'>Program Reviews</th></tr>";
            echo "<tr><th>Program Name</th><th>Year</th><th>Grade</th></tr>";
            foreach ($value as $review) {
                echo "<tr><td>{$review['program_name']}</td><td>{$review['program_year']}</td><td>{$review['program_grade']}</td></tr>";
            }
            continue;

        }
// **Panel of Teachers (Table Format)**
if ($session_key === "panel_of_teachers" && is_array($_SESSION[$session_key])) {
    echo "<table>
                <tr>
                    <th>Lecturer Name</th>
                    <th>Designation</th>
                    <th>Internal UG</th>
                    <th>Internal PG</th>
                    <th>External UG</th>
                    <th>External PG</th>
                    <th>Proposed Programs</th>
                    <th>Total Hours</th>
                </tr>";
    foreach ($_SESSION[$session_key] as $teacher) {
        echo "<tr>
                    <td>{$teacher['lecturer_name']}</td>
                    <td>{$teacher['designation']}</td>
                    <td>{$teacher['internal_ug_hours']}</td>
                    <td>{$teacher['internal_pg_hours']}</td>
                    <td>{$teacher['external_ug_hours']}</td>
                    <td>{$teacher['external_pg_hours']}</td>
                    <td>{$teacher['proposed_program_hours']}</td>
                    <td>{$teacher['total_hours']}</td>
                  </tr>";
    }
    echo '</table>';
    continue;
}






        // Resource Requirements Table
        elseif ($session_key === "resource_requirements" && is_array($value)) {
            echo "<tr><th colspan='5'>Resource Requirements</th></tr>";
            echo "<tr><th>Category</th><th>Existing</th><th>Year 1</th><th>Year 2</th><th>Year 3</th></tr>";
            foreach ($value as $category => $details) {
                if (is_array($details)) {
                    echo "<tr><td>{$category}</td><td>{$details['existing']}</td><td>{$details['year1']}</td><td>{$details['year2']}</td><td>{$details['year3']}</td></tr>";
                }
            }
            continue;
        }
        // Reviewers Report Table
        elseif ($session_key === "reviewers_report" && is_array($value)) {
            echo "<tr><th colspan='2'>Reviewers Report</th></tr>";
            foreach ($value as $criteria => $review) {
                echo "<tr><td>" . ucfirst(str_replace('_', ' ', $criteria)) . "</td><td>{$review}</td></tr>";
            }
            continue;
        }
        // If it's an array, process accordingly
        elseif (is_array($value)) {
            // If it's a simple list (checkbox, dropdown)
            if (array_values($value) === $value) {
                $formattedValue = implode(", ", array_filter($value));
            } 
            // If it's a structured table
            elseif (!empty($value) && is_array(reset($value))) {
                echo "<tr><th colspan='" . count(reset($value)) . "'>" . ucfirst(str_replace('_', ' ', $key)) . "</th></tr>";
                echo "<tr>";
                foreach (array_keys(reset($value)) as $column) {
                    echo "<th>" . ucfirst(str_replace('_', ' ', $column)) . "</th>";
                }
                echo "</tr>";
                foreach ($value as $row) {
                    echo "<tr>";
                    foreach ($row as $cell) {
                        echo "<td>" . htmlspecialchars((string) $cell) . "</td>";
                    }
                    echo "</tr>";
                }
                continue;
            } 
            // Otherwise, encode it as JSON (This case shouldn't happen now)
            else {
                $formattedValue = implode(", ", array_filter($value));
            }
        } 
        // If it's a file link, show as "View File"
        elseif (is_string($value) && (filter_var($value, FILTER_VALIDATE_URL) || str_contains($value, '/uploads/'))) {
            $formattedValue = "<a href='" . htmlspecialchars($value) . "' target='_blank'>View File</a>";
        } 
        // Default case for simple text values
        else {
            $formattedValue = htmlspecialchars((string) $value);
        }
        
        echo "<tr><th>" . ucfirst(str_replace('_', ' ', $key)) . "</th><td>{$formattedValue}</td></tr>";
    }

    echo "</table>";
}
?>

</body>
</html>
