<?php
include 'interface.php';

// Replace these with actual values
$stamp = rand(1000, 65535);
$site = "77190";
$amount = "4.30";
$fee = "5.00";
$vat_value = "6.00";

$stamp = hash("sha512", $stamp);

// Replace these with actual values
$secretKey = "1TRQVUMAUBX4";
$returnUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
$rejectUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
$cancelUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
 
// Construct the MAC string based on available values
if (!empty($fee) && !empty($vat_value)) {
    $dataString = "$stamp&$site&$amount&$fee&$vat_value&$secretKey";
} elseif (!empty($fee)) {
    $dataString = "$stamp&$site&$amount&$fee&$secretKey";
} elseif (!empty($vat_value)) {
    $dataString = "$stamp&$site&$amount&$vat_value&$secretKey";
} else {
    $dataString = "$stamp&$site&$amount&$secretKey";
}


 
// Generate SHA-512 hash
$mac = hash("sha512", $dataString);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Epassi Payment</title>
    <link rel="stylesheet" href="style.css">

</head>
<body>

<div id="payment-container" class="payment-container">
    <h2>Epassi Payment</h2>
    <p>Please review the payment details below and click "Pay with Epassi" to proceed.</p>
    <?php 
    [$ok, $form] = generateEpassiForm($stamp, $amount, $fee, $vat_value);
    if ($ok) {
        echo $form;
    } else {
        echo "<p>Invalid amount, fee or VAT value.</p>";
    }
    
    ?>
</div>



</body>
</html>

