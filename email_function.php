<?php
// Import PHPMailer classes into the global namespace
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

// This check prevents errors if the file is included multiple times.
if (!class_exists('Dotenv\Dotenv')) {
    require __DIR__ . '/vendor/autoload.php';
    $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
    $dotenv->load();
}

function send_email($to_email, $to_name, $subject, $body) {
    $mail = new PHPMailer(true);

    try {
        // --- Server settings ---
        // IMPORTANT: These settings are for Gmail. You MUST change them for your mail server.
        $mail->isSMTP();
        $mail->Host       = $_ENV['SMTP_HOST'];; // Your SMTP server
        $mail->SMTPAuth   = true;
        $mail->Username   = $_ENV['SMTP_USERNAME']; // Your SMTP username
        $mail->Password   = $_ENV['SMTP_APP_PASSWORD'];   // Your SMTP password (for Gmail, this is an "App Password")
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
        $mail->Port       = $_ENV['SMTP_PORT'];

        // --- Recipients ---
        $mail->setFrom($_ENV['MAIL_FROM_ADDRESS'], $_ENV['MAIL_TITLE']);
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