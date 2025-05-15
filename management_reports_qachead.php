<?php
session_start();
require 'databaseconnection.php';

// Ensure user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Fetch university data
$query = "SELECT u.university_id, u.university_name, 
                 IF(EXISTS(SELECT 1 FROM users WHERE users.university_id = u.university_id), 'Yes', 'No') AS registered,
                 (SELECT COUNT(*) FROM proposals WHERE proposals.university_id = u.university_id) AS total_submissions,
                 (SELECT COUNT(*) FROM proposals WHERE proposals.university_id = u.university_id AND status LIKE 'approvedbyugcacademic%') AS approved_proposals,
                 (SELECT COUNT(*) FROM proposals WHERE proposals.university_id = u.university_id AND (status LIKE 'rejectedbyugc%' OR status LIKE 'rejectedbyqachead%')) AS rejected_proposals
          FROM universities u
          WHERE u.university_name NOT LIKE '%QAC-UGC%'
          ORDER BY total_submissions DESC";

$stmt = $connection->prepare($query);
$stmt->execute();
$result = $stmt->get_result();

$reportData = [];
$max_submissions = 0;
while ($row = $result->fetch_assoc()) {
    $reportData[] = $row;
    $max_submissions = max($max_submissions, $row['total_submissions']);
}
$stmt->close();

// Calculate participation rate
foreach ($reportData as &$row) {
    $row['participation_rate'] = ($max_submissions > 0) ? round(($row['total_submissions'] / $max_submissions) * 100, 2) : 0;
}
unset($row);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>University Participation Rate</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container my-5">
        <h3 class="mb-4">Management Report : University Participation Rate</h3>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>University Name</th>
                    <th>Registered</th>
                    <th>No of Proposal Submissions</th>
                    <th>Number of Approved Proposals</th>
                    <th>No of Rejected Proposals</th>
                    <th>Participation Rate (%)</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($reportData as $row): ?>
                <tr>
                    <td><?= htmlspecialchars($row['university_name']); ?></td>
                    <td><?= htmlspecialchars($row['registered']); ?></td>
                    <td><?= $row['total_submissions']; ?></td>
                    <td><?= $row['approved_proposals']; ?></td>
                    <td><?= $row['rejected_proposals']; ?></td>
                    <td><?= number_format($row['participation_rate'], 2); ?>%</td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</body>
</html>