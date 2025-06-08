<?php
session_start();
include 'databaseconnection.php';

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: login.php');
    exit();
}

// Retrieve user details
$username = $_SESSION['username'];
$query = "SELECT first_name, last_name, role, university, university_id, id FROM users WHERE username = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    $full_name = $user['first_name'] . ' ' . $user['last_name'];
    $Role = str_replace(" of the university", "", $user['role']);
    $university = $user['university'];
    $university_id = $user['university_id']; // Store university_id
    $user_id = $user['id']; // store user_id to apply created_by

    $_SESSION['university'] = $university;
} else {
    $full_name = "Unknown User";
    $Role = "Unknown Role";
    $university = "Unknown University";

    $_SESSION['university'] = $university;
}


// Define the upload directory
$uploadDir = __DIR__ . '/../uploads/';  // Adjust path if necessary
$uploadUrl = '/qac_ugc/Proposal_sections/uploads/';

// Function to delete uploaded files from session data
function deleteUploadedFiles($section) {
    global $uploadDir, $uploadUrl;

    if (!empty($_SESSION[$section])) {
        foreach ($_SESSION[$section] as $key => $fileUrl) {
            if (is_string($fileUrl) && strpos($fileUrl, $uploadUrl) === 0) { // Ensure it's a file path
                $filePath = str_replace($uploadUrl, $uploadDir, $fileUrl); // Convert URL to file path
                if (file_exists($filePath)) {
                    unlink($filePath); // Delete the file
                }
            }
        }
    }
}


// Retrieve list of draft proposals
$drafts = [];
$stmt = $connection->prepare("SELECT proposal_id, proposal_code, status FROM proposals WHERE status = 'submitted' AND university_id = ? ORDER BY proposal_id ASC");
$stmt->bind_param("i", $university_id); // Bind parameters 
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $drafts[] = $row;
}


// Retrieve submitted proposals
$submittedProposals = [];
$stmt = $connection->prepare("SELECT p.proposal_id, p.proposal_code, p.status, gi.degree_name_english FROM proposals p join proposal_general_info gi ON p.proposal_id = gi.proposal_id  WHERE university_id = ? AND status NOT IN ('draft', 'fresh') ORDER BY proposal_id ASC");
$stmt->bind_param("i", $university_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $submittedProposals[] = $row;
}
$stmt->close();



// Retrieve revised/rejected proposals
$revisedProposals = [];
$stmt = $connection->prepare("
    SELECT p.proposal_id, 
           p.proposal_code,
           p.status, 
           gi.degree_name_english,
           c.comment, 
           c.comment_id, 
           c.seal_and_sign, 
           c.proposal_status, 
           c.Date
    FROM proposals p
    LEFT JOIN proposal_comments c 
        ON p.proposal_id = c.proposal_id 
        AND c.comment_id = ( 
            SELECT MAX(comment_id) 
            FROM proposal_comments 
            WHERE proposal_id = p.proposal_id
        ) --  Select only the latest comment
    LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id
    WHERE p.university_id = ? 
      AND p.status LIKE 'rejectedby%' 
    ORDER BY p.proposal_id ASC
");

$stmt->bind_param("i", $university_id);
$stmt->execute();
$result = $stmt->get_result();

$revisedProposals = [];
while ($row = $result->fetch_assoc()) {
    $revisedProposals[] = $row;
}
$stmt->close();


// Retrieve final approved proposals
$finalapprovedProposals = [];
//$stmt = $connection->prepare("SELECT proposal_id, status FROM proposals WHERE university_id = ? AND status IN ('approvedbyugcacademic') ORDER BY proposal_id ASC");
$stmt = $connection->prepare("
    SELECT p.proposal_id,p.proposal_code, p.status, gi.degree_name_english,
        COALESCE(pc.comment, 'No Comment') AS latest_comment,
        COALESCE(pc.proposal_status, 'No Status') AS latest_status
    FROM proposals p
    LEFT JOIN proposal_comments pc 
        ON p.proposal_id = pc.proposal_id 
        AND pc.comment_id = (
            SELECT MAX(comment_id) FROM proposal_comments 
            WHERE proposal_id = p.proposal_id
        )
    LEFT JOIN proposal_general_info gi 
    ON p.proposal_id = gi.proposal_id
    WHERE p.university_id = ? 
    AND p.status = 'approvedbyugcacademic'
    ORDER BY p.proposal_id ASC
");
$stmt->bind_param("i", $university_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $finalapprovedProposals[] = $row;
}
$stmt->close();


// Fetch university data
//$query = "SELECT  
                 //(SELECT COUNT(*) FROM proposals WHERE university_id = ? AND status NOT IN ('draft', 'fresh') ORDER BY proposal_id ASC) AS total_submissions,
                 //(SELECT COUNT(*) FROM proposals WHERE university_id = ? AND status LIKE 'rejectedby%') AS rejected_proposals
          //FROM proposals order by total_submissions";


$query = "SELECT u.university_id, u.university_name, 
                
                 (SELECT COUNT(*) FROM proposals WHERE proposals.university_id = u.university_id) AS total_submissions,
                 (SELECT COUNT(*) FROM proposals WHERE proposals.university_id = u.university_id AND status LIKE 'rejectedby%') AS rejected_proposals
          FROM universities u
          WHERE u.university_name LIKE '%University of Colombo%'
          ORDER BY total_submissions DESC";

$stmt = $connection->prepare($query);
$stmt->execute();
$result = $stmt->get_result();


$reportData = [];
$max_submissions = 0;
while ($row = $result->fetch_assoc()) {
    $reportData[] = $row;
  
  $rejectionRate = ($row['rejected_proposals'] / $row['total_submissions']) * 100;
}
$stmt->close();

// Calculate participation rate
foreach ($reportData as &$row) {
    $row['rate'] = $rejectionRate;
}
unset($row);





?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Proposal - Proposal Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            overflow-x: hidden;
        }
        .sidebar {
            height: 100vh;
            position: fixed;
            background-color: #2c3e50;
            color: white;
            width: 250px;
            transition: all 0.3s;
            z-index: 1000;
        }
        .sidebar.collapsed {
            width: 70px;
        }
        .sidebar .user-info {
            text-align: center;
            margin: 20px 0;
        }
        .sidebar .user-info h6 {
            margin: 0;
            font-size: 16px;
            font-weight: bold;
        }
        .sidebar .user-info p {
            margin: 0;
            font-size: 14px;
            color: #bdc3c7;
        }
        .sidebar .nav-item {
            padding: 10px 20px;
        }
        .sidebar .nav-link {
            color: white;
            font-size: 16px;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover {
            background-color: #34495e;
            border-radius: 4px;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
            font-size: 18px;
        }
        .sidebar .toggle-btn {
            position: absolute;
            top: 15px;
            right: -20px;
            background-color: #2c3e50;
            border: none;
            color: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            font-size: 20px;
            cursor: pointer;
        }
        .main-content {
            margin-left: 250px;
            transition: all 0.3s;
            padding: 20px;
        }
        .main-content.collapsed {
            margin-left: 70px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            font-weight: bold;
            border-radius: 10px 10px 0 0;
        }
        footer {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            color: #7f8c8d;
        }

        /* Dropdown menu */
        .dropdown-menu 
        {
            list-style: none;
            padding-left: 20px;
            display: none;
            flex-direction: column;
            background: #2c3e50;    /* Light background, change as needed */
            border: 1px solid #ccc; /* Border to distinguish */
            width: 150px;
            position: absolute;      /* Position relative to dropdown container */
            z-index: 1000;
        }

        .dropdown-menu li 
        {
            margin-top: 5px;
            display:flex;
        }

        .nav-link.dropdown-toggle 
        {
            cursor: pointer;
        }

        .sub-link 
        {
            font-size: 14px;
            padding-left: 25px;
            color:rgba(36, 35, 35, 0.88);
            transition: 0.3s;
        }

        .sub-link:hover 
        {
            color: black;
            background-color: #34495e;
            border-radius: 4px;
        }

         footer {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
            color: #7f8c8d;
        }

    </style>
</head>
<body>

    <!-- Sidebar -->
    <div id="sidebar" class="sidebar">
        <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
        <div class="user-info">
            <h6><?php echo htmlspecialchars($full_name); ?></h6>
            <p><?php echo htmlspecialchars($Role); ?></p>
            <p><?php echo htmlspecialchars($university); ?></p>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="submitted_proposals.php"><i class="fas fa-home"></i> Dashboard</a>
            </li>
           <li class="nav-item">
    <div class="nav-link dropdown-toggle" style="cursor: pointer;" onclick="toggleDropdown(event)">
        <i class="fas fa-file-alt"></i> New Proposals
    </div>
    <ul id="proposalDropdown" class="dropdown-menu">
        <li><a class="nav-link sub-link" href="new_proposal.php?type=undergraduate">Undergraduate Programs</a></li>
        <li><a class="nav-link sub-link" href="new_proposal_postgraduate.php?type=postgraduate">Postgraduate Programs</a></li>
        <li><a class="nav-link sub-link" href="new_proposal_external.php?type=external">External Programs</a></li>
    </ul>
</li>

            <li class="nav-item">
                <hr class="text-light">
                <a class="nav-link" href="reset_password.php"><i class="fas fa-key"></i> Reset Password</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="login.php"><i class="fas fa-sign-out-alt"></i> Log out</a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div id="main-content" class="main-content">
        <div class="container">
            <h5> Submitted Proposals List</h5>
	 </div>
           <!-- Submitted Proposals Table -->
        <div class="card">
            <div class="text-bg-dark p-3">Submitted Proposals</div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Proposal Code</th>
                            <th>Degree Name </th>
                            <th>Status</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($submittedProposals)) { ?>
                            <tr><td colspan="3" class="text-center">No submitted proposals found.</td></tr>
                        <?php } else {
                            foreach ($submittedProposals as $proposal) { ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($proposal['proposal_code']); ?></td>
                                    <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                                    <td><?php echo htmlspecialchars($proposal['status']); ?></td>
                                    
                                </tr>
                            <?php }
                        } ?>
                    </tbody>
                </table>
            </div>
        </div>

        <h5 class="mt-4">Revised / Rejected Proposals</h5>

        <!-- Revised Proposals Table -->
        <div class="card">
            <div class="text-bg-dark p-3">Revised Proposals</div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Proposal Code</th>
                            <th>Degree Name </th>
                            <th>Status</th>
                            <th>Comment</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (empty($revisedProposals)) { ?>
                            <tr><td colspan="3" class="text-center">No revised proposals found.</td></tr>
                        <?php } else {
                            foreach ($revisedProposals as $proposal) { ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($proposal['proposal_code']); ?></td>
                                    <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                                    <td><?php echo htmlspecialchars($proposal['status']); ?></td>
                                    <td><?php echo htmlspecialchars($proposal['comment'] ?? "No Comment"); ?></td>
                                    <td>
                                    <a href="new_proposal_section.php?proposal_id=<?php echo htmlspecialchars($proposal['proposal_id']); ?>&edit=true&initial" class="btn btn-primary btn-sm">Edit</a>
                                    </td>
                                </tr>
                            <?php }
                        } ?>
                    </tbody>
                </table>
            </div>
        </div>

        <h5 class="mt-4">Final Approved Proposals</h5>
<!-- Final Approved Proposals Table -->
<div class="card">
<div class="card">
    <div class="card-body">
        <table class="table">
            <thead>
                <tr>
                    <th>Proposal Code</th>
                    <th>Degree Name </th>
                    <th>Status</th>
                    <th>Comment</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($finalapprovedProposals as $proposal) {
                   


                ?>
                    <tr>
                        <td><?php echo htmlspecialchars($proposal['proposal_code']); ?></td>
                        <td><?php echo htmlspecialchars($proposal['degree_name_english']); ?></td>
                        <td><?php echo htmlspecialchars($proposal['latest_status']); ?></td>
                        <td><?php echo htmlspecialchars($proposal['latest_comment']); ?></td>
                        <td>
                           
                        <a href="view_proposal.php?id=<?php echo $proposal['proposal_id']; ?>" class="btn btn-primary">View</a>
                        </td>
                    </tr>


                      

                    <?php
                    
                    ?>
                <?php } ?>


            </tbody>
        </table>
        
    </div>

   
</div>
             
        </div>
        
        
    </div>
        
    </div>

          
        


    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
            document.getElementById('main-content').classList.toggle('collapsed');
        }

    
        function toggleDropdown() {
            const menu = document.getElementById('proposalDropdown');
            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
        }
    

    </script>

    

    <footer>
        Copyright © 2024 University Grants Commission. Developed by UGC.
    </footer>
</body>
</html>