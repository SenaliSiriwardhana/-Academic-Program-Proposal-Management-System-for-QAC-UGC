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

//  If "Create New Proposal" button is clicked, reset all sections & delete files
if (isset($_POST['create_new_proposal'])) {
    //  List of all sections
    $sections = [
        'general_info', 'program_entity', 'assessment_rules', 'compliance_check',
        'degree_details', 'panel_of_teachers', 'program_content', 'program_delivery',
        'program_structure', 'resource_requirements', 'reviewers_report'
    ];

    //  Delete uploaded files for each section
    foreach ($sections as $section) {
        deleteUploadedFiles($section);
    }

    //  Reset session data for all sections
    unset($_SESSION['proposal_id']);
    foreach ($sections as $section) {
        unset($_SESSION[$section]);  // Clear section data
        unset($_SESSION["status_$section"]);  // Reset section status
    }

    unset($_SESSION['proposal_id']);

    //  Insert a new proposal
    $sql = "INSERT INTO proposals (university_id, created_at, status, created_by) VALUES (?, NOW(), 'fresh', ?)";
    $stmt = $connection->prepare($sql);
    $stmt->bind_param("ii", $university_id, $user_id);

    if ($stmt->execute()) {
        $new_proposal_id = $stmt->insert_id;
        $_SESSION['proposal_id'] = $new_proposal_id;

        // Redirect to proposal_section.php with the proposal_id
        header("Location: new_proposal_section.php?proposal_id=" . $new_proposal_id);
        exit();

    } else {
        echo json_encode(["success" => false, "error" => $stmt->error]);
    }
   

}

    
   


$drafts = [];
$stmt = $connection->prepare("SELECT proposal_id, status FROM proposals WHERE status = 'draft' AND created_by = ? ORDER BY proposal_id ASC");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $drafts[] = $row;
}

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

    </style>
    <script>
        function confirmNewProposal() {
            if (confirm("Are you sure you want to start a new proposal? This will create a fresh start and previous data will be lost.")) {
                window.location.href = "new_proposal_section.php";
            }
        }
    </script>
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
        <li><a class="nav-link sub-link" href="new_proposal.php">Undergraduate Programs</a></li>
        <li><a class="nav-link sub-link" href="new_proposal_postgraduate.php">Postgraduate Programs</a></li>
        <li><a class="nav-link sub-link" href="new_proposal_external.php">External Programs</a></li>
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
            <h3>New Undergraduate Programs </h3>
            <h4>Create Proposal Instructions</h4>
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">Instructions</div>
                <div class="card-body">
                    <p>To create a new proposal, please follow these steps:</p>
                    <ul>
                        <li>Click on the "Create New Proposal" button.</li>
                        <li>Fill in each section (11 sections).</li>
                        <li>Consider the attached templates for the file uploads. 
                        <li>Save the draft as you go. If you doesn't draft save data will be lost when exit from the page or refresh.</li>
                        <li>Submit the final proposal when all sections are complete.</li>
                        <li>Submitted proposals can be edited when necessary.</li>
                        <li>File uploads should be PDF format. </li>
                    </ul>
                </div>
            </div>

             <!-- Create New Proposal Button -->
             <form id="newProposalForm" action="new_proposal.php" method="POST">
                <button onclick="confirmNewProposal()" type="submit" name="create_new_proposal" class="btn btn-secondary mb-4">Create New Proposal</button>
            </form>

            <!-- Draft Proposals Table -->
            <div class="card">
                <div class="text-bg-dark p-3">Draft Proposals</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Proposal ID</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($drafts)) { ?>
                                <tr><td colspan="2" class="text-center">No draft proposals found.</td></tr>
                            <?php } else {
                                foreach ($drafts as $draft) { ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($draft['proposal_id']); ?></td>
                                        <td><?php echo htmlspecialchars($draft['status']); ?></td>
                                        <td>
                                        <a href="new_proposal_section.php?proposal_id=<?php echo htmlspecialchars($draft['proposal_id']); ?>&edit=true&initial" class="btn btn-primary btn-sm">Edit</a>
                                    </td>
                                    </tr>
                                <?php }
                            } ?>
                        </tbody>
                    </table>
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
</body>
</html>