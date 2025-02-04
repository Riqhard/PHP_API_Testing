<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $paymentStatus = $_POST['STATUS'] ?? 'UNKNOWN'; // STATUS could be "OK", "REJECTED", or "CANCELLED"
    $paymentStamp = $_POST['STAMP'] ?? 'N/A';
    
    if ($paymentStatus === 'OK') {
        echo "Payment successful! Transaction ID: " . htmlspecialchars($paymentStamp);
    } elseif ($paymentStatus === 'REJECTED') {
        echo "Payment was rejected.";
    } elseif ($paymentStatus === 'CANCELLED') {
        echo "Payment was cancelled.";
    } else {
        echo "Unknown payment status.";
    }
}

$secretKey = "1TRQVUMAUBX4"; // Test MAC-key

// Get data from Epassi
$stamp = $_POST['STAMP'] ?? null;
$paid = $_POST['PAID'] ?? null;
$received_mac = $_POST['MAC'] ?? null;

if (!$stamp || !$paid || !$received_mac) {
    die("Invalid request: Missing parameters.");
}

// Generate MAC to verify payment authenticity
$generated_mac = hash("sha512", "$stamp&$paid&$secretKey");

// Validate MAC
if (hash_equals($generated_mac, $received_mac)) {
    echo "Payment confirmed! STAMP: $stamp, PAID: $paid";
    // Mark payment as completed in the database
} else {
    die("Payment verification failed: Invalid MAC.");
}
?>

<form action="RETURN" method="post">
 <input name="STAMP" type="hidden" value="6Ql738" />
 <input name="PAID" type="hidden" value="706" />
 <input name="MAC" type="hidden" value="8a4574509927af9864b9cfe724325c77861bd2f02c772b0c85588a64d2d02878bce01d0b9
 bb0fc667c7fc5e0cd1aa8e55d73ede3c048466f5a18797c53390b11" />
 <input type="submit" value="Go back to seller's service" />
 </form>