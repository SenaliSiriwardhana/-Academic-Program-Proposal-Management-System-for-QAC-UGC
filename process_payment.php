<?php
session_start();
require 'databaseconnection.php';

// Get proposal ID and user details
$proposal_id = $_SESSION['proposal_id'] ?? null;
$user_id = $_SESSION['id'] ?? null;

if (!$proposal_id || !$user_id) {
    die("Invalid session data");
}




// Payment configuration
$merchant_id = "1229748";  // Replace with actual PayHere merchant ID
$merchant_secret = "NDE3NzcyMTEyMDM5MjI1NTU5MDAzNjQ1Njk5MjkzMDUwNDAzMTc2"; // Replace with actual PayHere merchant secret
$payment_amount = 1000.00; // Payment amount in LKR
$currency = "LKR";

// Generate unique order ID
$order_id = 'PROP_' . $proposal_id . '_' . time();

// Customer details from session
$customer_name = $_SESSION['first_name'] ?? 'Customer';
$customer_email = $_SESSION['email'] ?? '';

// Payment notification URL
$notify_url = "http://" . $_SERVER['HTTP_HOST'] . "/qac_ugc/payment_notify.php";
$return_url = "http://" . $_SERVER['HTTP_HOST'] . "/qac_ugc/new_proposal_section.php?proposal_id=" . $_SESSION['proposal_id']. "&edit=true";
$cancel_url = "http://" . $_SERVER['HTTP_HOST'] . "/qac_ugc/new_proposal_section.php?proposal_id=" . $_SESSION['proposal_id']. "&edit=true";

// Store payment initiation in database
$stmt = $connection->prepare("INSERT INTO proposal_payments (proposal_id, user_id, order_id, amount, status) VALUES (?, ?, ?, ?, 'pending')");
$stmt->bind_param("iisd", $proposal_id, $user_id, $order_id, $payment_amount);
$stmt->execute();

// Generate hash
$hash = strtoupper(
    md5(
        $merchant_id . 
        $order_id . 
        number_format($payment_amount, 2, '.', '') . 
        $currency .  
        strtoupper(md5($merchant_secret)) 
    ) 
);

// Payment form data - Required Fields
$payment_data = [
    'merchant_id' => $merchant_id,
    'return_url' => $return_url,
    'cancel_url' => $cancel_url,
    'notify_url' => $notify_url,
    'order_id' => $order_id,
    'items' => 'Proposal Resubmission Fee',
    'currency' => $currency,
    'amount' => $payment_amount,
    'first_name' => $customer_name,
    'last_name' => $_SESSION['last_name'] ?? 'Customer',
    'email' => $customer_email,
    'phone' => $_SESSION['phone'] ?? '0000000000',
    'address' => $_SESSION['university'] ?? 'Not Provided',
    'city' => $_SESSION['city'] ?? 'Not Provided',
    'country' => 'Sri Lanka',
    'hash' => $hash
];

// Redirect to PayHere
?>
<!DOCTYPE html>
<html>
<head>
    <title>Processing Payment...</title>
</head>
<body>
    <form id="payment_form" method="post" action="https://sandbox.payhere.lk/pay/checkout">
        <?php foreach($payment_data as $key => $value): ?>
            <input type="hidden" name="<?php echo $key; ?>" value="<?php echo htmlspecialchars($value); ?>">
        <?php endforeach; ?>
    </form>
    <script>
            document.addEventListener('DOMContentLoaded', function() {
                setTimeout(function() {
                    document.getElementById('payment_form').submit();
                }, 500); // Small delay to ensure everything is loaded
            });
        </script>
</body>
</html>