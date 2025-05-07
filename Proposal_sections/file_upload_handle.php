<?php
session_start();

/**
 * Handles file upload and stores the full URL in the session.Because , after download the pdf , file uploades will not show. 
 *
 * @param string $fileKey - The input name in the HTML form
 * @param string $uploadDir - The directory where files should be stored
 * @param string $sessionKey - The session key for storing the file link
 * @return string - The full file URL or an empty string on failure
 */
function handleFileUpload($fileKey, $uploadDir, $sessionKey) {
    // Ensure the upload directory exists
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    if (!empty($_FILES[$fileKey]['name'])) {
        if ($_FILES[$fileKey]['error'] !== UPLOAD_ERR_OK) {
            return $_SESSION[$sessionKey][$fileKey] ?? ''; // Keep previous file if new one fails
        }

        $fileName = time() . "_" . basename($_FILES[$fileKey]["name"]);
        $filePath = $uploadDir . $fileName;

        if (move_uploaded_file($_FILES[$fileKey]["tmp_name"], $filePath)) {
            // Store full URL instead of relative path
            $_SESSION[$sessionKey][$fileKey] = "http://localhost/qac_ugc/Proposal_sections/uploads/" . $fileName;
            return $_SESSION[$sessionKey][$fileKey];
        } else {
            return $_SESSION[$sessionKey][$fileKey] ?? ''; // Keep previous file if upload fails
        }
    }

    return $_SESSION[$sessionKey][$fileKey] ?? ''; // Return existing session value if no new upload
}
