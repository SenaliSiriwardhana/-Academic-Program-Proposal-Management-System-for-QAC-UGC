<?php
// Include database connection
include 'databaseconnection.php';

// Initialize feedback message
$message = '';
$message_type = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $first_name = htmlspecialchars(trim($_POST['first_name']));
    $last_name = htmlspecialchars(trim($_POST['last_name']));
    $email = htmlspecialchars(trim($_POST['email']));
    $university = htmlspecialchars(trim($_POST['university']));
    $role = htmlspecialchars(trim($_POST['role']));
    $username = htmlspecialchars(trim($_POST['username']));
    $password = htmlspecialchars(trim($_POST['password']));
    $confirm_password = htmlspecialchars(trim($_POST['confirm_password']));

    // Validate passwords
    if ($password !== $confirm_password) {
        $message = 'Passwords do not match.';
        $message_type = 'error';
    } else {
        // Hash the password
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Retrieve university_id
        $stmt = $connection->prepare("SELECT university_id FROM universities WHERE university_name = ?");
        $stmt->bind_param("s", $university);
        $stmt->execute();
        $stmt->bind_result($university_id);
        $stmt->fetch();
        $stmt->close();

        // If university_id is not found, return an error
        if (!$university_id) {
            $message = "University not found.";
            $message_type = "error";
            goto end_form;
        }

        // Check if a restricted role already exists for the university
        $restricted_roles = [
            "Program Coordinator of the university",
            "Dean/Rector/Director of the university",
            "CQA Director of the university"
        ];

        if (in_array($role, $restricted_roles)) {
            $stmt = $connection->prepare("SELECT COUNT(*) FROM users WHERE university_id = ? AND role = ?");
            $stmt->bind_param("is", $university_id, $role);
            $stmt->execute();
            $stmt->bind_result($role_count);
            $stmt->fetch();
            $stmt->close();

            if ($role_count > 0) {
                $message = "A $role already exists for the university.";
                $message_type = 'error';
                goto end_form;
            }
        }

        // Check if email or username already exists
        $stmt = $connection->prepare("SELECT COUNT(*) FROM users WHERE email = ? OR username = ?");
        $stmt->bind_param("ss", $email, $username);
        $stmt->execute();
        $stmt->bind_result($count);
        $stmt->fetch();
        $stmt->close();

        if ($count > 0) {
            $message = 'Email or Username already exists.';
            $message_type = 'error';
        } else {
            // Insert the new user with university_id
            $stmt = $connection->prepare("
                INSERT INTO users (first_name, last_name, email, university, university_id, role, username, password) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmt->bind_param("ssssisss", $first_name, $last_name, $email, $university, $university_id, $role, $username, $hashed_password);

            if ($stmt->execute()) {
                $message = 'Sign-up successful.';
                $message_type = 'success';
            } else {
                $message = 'Registration failed. Please try again.';
                $message_type = 'error';
            }
            $stmt->close();
        }
    }
}

end_form:
$connection->close();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow" style="width: 400px;">
            <div class="card-body text-center">
                <h5 class="card-title">Sign Up</h5>

                <!-- Display Feedback Message -->
                <?php if ($message): ?>
                    <div class="alert alert-<?php echo $message_type === 'success' ? 'success' : 'danger'; ?>" role="alert">
                        <?php echo $message; ?>
                    </div>
                <?php endif; ?>

                <form action="signup.php" method="POST">
                    <div class="mb-3">
                        <label for="first_name" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="first_name" name="first_name" required>
                    </div>
                    <div class="mb-3">
                        <label for="last_name" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="last_name" name="last_name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="role" class="form-label">Role</label>
                        <select class="form-control" id="role" name="role" required>
                            <option value="">Select a Role</option>
                            <option value="Program Coordinator of the university">Program Coordinator of the university</option>
                            <option value="Dean/Rector/Director of the university">Dean/Rector/Director of the university</option>
                            <option value="CQA Director of the university">CQA Director of the university</option>
                            <option value="Vice Chancellor of the university">Vice Chancellor of the university</option>
                            <option value="Head of the QAC-UGC Department">Head of the QAC-UGC Department</option>
                            <option value="UGC - Finance Department">UGC - Finance Department</option>
                            <option value="UGC - HR Department">UGC - HR Department</option>
                            <option value="UGC - IDD Department">UGC - IDD Department</option>
                            <option value="UGC - Legal Department">UGC - Legal Department</option>
                            <option value="UGC - Academic Department">UGC - Academic Department</option>
                            <option value="UGC - Admission Department">UGC - Admission Department</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="university" class="form-label">University</label>
                        <input type="text" class="form-control" id="university" name="university" required>
                    </div>
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirm_password" class="form-label">Confirm Password</label>
                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Sign Up</button>
                </form>
                <div class="text-center mt-3">
                    <span>Already have an account? </span><a href="login.php">Login</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const roleSelect = document.getElementById("role");
        const universityInput = document.getElementById("university");

    roleSelect.addEventListener("change", function () {
        const ugcRoles = [
            "Head of the QAC-UGC Department",
            "UGC - Finance Department",
            "UGC - HR Department",
            "UGC - IDD Department",
            "UGC - Legal Department",
            "UGC - Academic Department",
            "UGC - Admission Department"
        ];

        if (ugcRoles.includes(this.value)) {
            universityInput.value = "QAC-UGC";
            universityInput.setAttribute("readonly", "true"); // Prevent editing
        } else {
            universityInput.value = "";
            universityInput.removeAttribute("readonly");
        }
    });
});
</script>

</body>
</html>
