<?php
// Import PHPMailer classes into the global namespace
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

// --- Load Composer's autoloader ---
require 'vendor/autoload.php'; 
// --- OR If you downloaded manually, use these lines instead ---
// require 'PHPMailer/Exception.php';
// require 'PHPMailer/PHPMailer.php';
// require 'PHPMailer/SMTP.php';

function send_email($to_email, $to_name, $subject, $body) {
    $mail = new PHPMailer(true);

    try {
        // --- Server settings ---
        // IMPORTANT: These settings are for Gmail. You MUST change them for your mail server.
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com'; // Your SMTP server
        $mail->SMTPAuth   = true;
        $mail->Username   = 'REMOVED'; // Your SMTP username
        $mail->Password   = 'REMOVED';    // Your SMTP password (for Gmail, this is an "App Password")
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
        $mail->Port       = 465;

        // --- Recipients ---
        $mail->setFrom('REMOVED', 'Academic Program Proposal Management System QAC-UGC');
        $mail->addAddress($to_email, $to_name);

        // --- Content ---
        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body    = $body;
        $mail->AltBody = strip_tags($body); // A plain text version of the email

        $mail->send();
        return true; // Success
    } catch (Exception $e) {
        // Log the error. Don't show it to the public user.
        error_log("PHPMailer Error: {$mail->ErrorInfo}");
        return false; // Failure
    }
}
?>