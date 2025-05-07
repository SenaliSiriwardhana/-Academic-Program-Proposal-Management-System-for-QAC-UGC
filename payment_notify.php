<?php
require 'databaseconnection.php';

// Verify PayHere notification
$merchant_secret = 'YOUR_MERCHANT_SECRET'; // Replace with actual merchant secret

// Get PayHere notification data
$merchant_id = $_POST['merchant_id'];
$order_id = $_POST['order_id'];
$payment_id = $_POST['payment_id'];
$payhere_amount = $_POST['payhere_amount'];
$payhere_currency = $_POST['payhere_currency'];
$status_code = $_POST['status_code'];
$md5sig = $_POST['md5sig'];

// Generate local hash for verification
$local_md5sig = strtoupper(
    md5(
        $merchant_id . 
        $order_id . 
        $payhere_amount . 
        $payhere_currency . 
        $status_code . 
        strtoupper(md5($merchant_secret))
    )
);

// Verify hash and update payment status
if ($local_md5sig === $md5sig) {
    // Map PayHere status codes to our status
    $payment_status = ($status_code == 2) ? 'completed' : 'failed';
    
    // Update payment status in database
    $stmt = $connection->prepare("UPDATE proposal_payments SET status = ?, payment_id = ? WHERE order_id = ?");
    $stmt->bind_param("sss", $payment_status, $payment_id, $order_id);
    $stmt->execute();
    
    // Log successful notification
    error_log("Payment notification processed: Order ID = $order_id, Status = $payment_status");
} else {
    // Log hash verification failure
    error_log("PayHere notification hash verification failed for order: $order_id");
}

// Always respond with 200 OK to acknowledge receipt
http_response_code(200);