<?php
// Enable error reporting (for debugging, remove in production)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Your secret MAC key
$secretKey = "1TRQVUMAUBX4"; // Replace with your actual MAC key

// Check if request is a POST request
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    die("Invalid request method.");
}

// Collect data from POST request
$stamp = $_POST['STAMP'] ?? null;
$paid = $_POST['PAID'] ?? null;
$received_mac = $_POST['MAC'] ?? null;

if (!$stamp || !$paid || !$received_mac) {
    echo "Invalid request: Missing parameters." . var_dump($_POST);
    die("Missing required parameters.");
}

// Generate MAC to verify authenticity
$generated_mac = hash("sha512", "$stamp&$paid&$secretKey");

// Validate MAC
if (!hash_equals($generated_mac, $received_mac)) {
    die("Payment verification failed: Invalid MAC.");
}

// Store the payment confirmation (you can save it in a database)
file_put_contents("payments.log", "Payment confirmed: STAMP=$stamp, PAID=$paid\n", FILE_APPEND);

// Redirect user to success page
header("Location: success.php");
exit;
?>
