<?php
session_start();
require 'databaseconnection.php';

// Ensure user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Retrieve the user's role 
$username = $_SESSION['username'];
$query = "SELECT role FROM users WHERE username = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    $normalizedRole = strtolower(trim(str_ireplace("of the university", "", $user['role'])));
    $_SESSION['role'] = $normalizedRole; // Update session role 
} else {
    header('Location: login.php');
    exit();
}

// Strictly verify user is VC
if (strpos($normalizedRole, 'vice chancellor') === false && strpos($normalizedRole, 'vc') === false) {
    die("Unauthorized Access - Your role: " . htmlspecialchars($normalizedRole));
}

// Ensure university_id is also set
if (!isset($_SESSION['university_id'])) {
    $university = $_SESSION['university'];
    $query = "SELECT university_id FROM universities WHERE university_name = ?";
    $stmt = $connection->prepare($query);
    $stmt->bind_param("s", $university);
    $stmt->execute();
    $result = $stmt->get_result();
    $uni = $result->fetch_assoc();
    if ($uni) {
        $_SESSION['university_id'] = $uni['university_id'];
    } else {
        die("University not found.");
    }
}

$university_id = $_SESSION['university_id'];

// Explicitly convert year and month to integers
$year = (int)date('Y');
$currentMonth = (int)date('m');

// Generate months up to current month only
$months = [];
for ($m = 1; $m <= $currentMonth; $m++) {
    $months[] = date('Y-m', strtotime("$year-$m-01"));
}

// Updated query with integer year
$query = "SELECT DATE_FORMAT(submitted_at, '%Y-%m') AS month,
                 COUNT(*) AS total_submissions,
                 SUM(CASE WHEN status LIKE 'approvedbyugc%' OR status = 'approvedbyqachead' THEN 1 ELSE 0 END) AS approved_proposals,
                 SUM(CASE WHEN status LIKE 'rejectedbyugc%' OR status = 'rejectedbyqachead' THEN 1 ELSE 0 END) AS rejected_proposals,
                 SUM(CASE WHEN status IN ('submitted', 'under_review', 'approvedbydean', 'approvedbyvc', 'approvedbycqa') THEN 1 ELSE 0 END) AS pending_proposals
          FROM proposals
          WHERE university_id = ? 
          AND YEAR(submitted_at) = ?
          GROUP BY month
          ORDER BY month DESC";

$stmt = $connection->prepare($query);
$stmt->bind_param("ii", $university_id, $year);
$stmt->execute();
$result = $stmt->get_result();

$db_data = [];
while ($row = $result->fetch_assoc()) {
    $db_data[$row['month']] = $row;
}
$stmt->close();

$reportData = [];

// Populate months up to current month only
foreach ($months as $month) {
    if (isset($db_data[$month])) {
        $row = $db_data[$month];
    } else {
        $row = [
            'month' => $month,
            'total_submissions' => 0,
            'approved_proposals' => 0,
            'rejected_proposals' => 0,
            'pending_proposals' => 0
        ];
    }

    

    // Calculate rates safely
    if ($row['total_submissions'] > 0) {
        $approvalRate = ($row['approved_proposals'] / $row['total_submissions']) * 100;
        $rejectionRate = (($row['total_submissions']-($row['approved_proposals'] + $row['pending_proposals'])) / $row['total_submissions']) * 100;
    } else {
        $approvalRate = 0;
        $rejectionRate = 0;
    }

    $row['approval_rate'] = round($approvalRate, 2);
    $row['rejection_rate'] = round($rejectionRate, 2);

    $reportData[] = $row;
}




?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Management Reports - Proposal Approval Rate</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container my-5">
        <h3 class="mb-4">Management Report: Proposal Approval Rate</h3>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Month</th>
                    <th>Total Submissions</th>
                    <th>Approved Proposals</th>
                    <th>Rejected Proposals</th>
                    <th>Pending Proposals</th>
                    <th>Approval Rate (%)</th>
                    <th>Rejection Rate (%)</th>
                </tr>
                </thead>
                <?php foreach ($reportData as $row): ?>
                <tr>
                    <td><?= htmlspecialchars($row['month']); ?></td>
                    <td><?= $row['total_submissions']; ?></td>
                    <td><?= $row['approved_proposals']; ?></td>
                    <td><?= $row['total_submissions'] - $row['approved_proposals'] - $row['pending_proposals'] ?></td>
                    <td><?= $row['pending_proposals']; ?></td>
                    <td><?= number_format($row['approval_rate'], 2); ?></td>
                    <td><?= number_format($row['rejection_rate'], 2); ?></td>
                </tr>
                <?php endforeach; ?>
            </table>
    </div>
</div>

</body>
</html>
