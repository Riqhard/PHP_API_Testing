<?php
include 'interface.php';

// Replace these with actual values
$stamp = rand(1000, 65535);
$site = "77190";
$amount = "4.30";
$fee = "5.0";
$vat_value = "6.0";



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
    <script>
        function updatePaymentContainer() {
            var paymentMethod = document.getElementById("payment_method").value;
            var paymentContainer = document.getElementById("payment-container");

            if (paymentMethod === "Pankkikortti") {
                paymentContainer.innerHTML = "<h2>Pankkikortti Payment</h2><p>Please review the payment details below and click 'Pay with Pankkikortti' to proceed.</p>";
            } else if (paymentMethod === "WismaPay") {
                paymentContainer.innerHTML = "<h2>WismaPay Payment</h2><p>Please review the payment details below and click 'Pay with WismaPay' to proceed.</p>";
            } else if (paymentMethod === "Epassi") {
                paymentContainer.innerHTML = "<h2>Epassi Payment</h2><p>Please review the payment details below and click 'Pay with Epassi' to proceed.</p>";
            }
        }
    </script>

</head>
<body>
<div class="payment-container2">
        <div id="payment-container" class="payment-container">
            <h2>Epassi Payment</h2>
            <p>Please review the payment details below and click "Pay with Epassi" to proceed.</p>
        </div>
        <select id="payment_method" name="payment_method" required onchange="updatePaymentContainer()">
            <option value="Pankkikortti">Pankkikortti</option>
            <option value="WismaPay">VismaPay</option>
            <option value="Epassi">Epassi</option>
    </select>
    <?php echo $form = generateEpassiForm($stamp, $amount, $fee, $vat_value); ?>
</div>

<!-- Payment Form  Old and working
<hr>
<div class="payment-container">
<h2>Epassi Payment version 0.1</h2>
<p>Older version that works.</p>

<form action="https://prodstaging.Epassi.fi/e_payments/v2" method="post">
    <input type="hidden" name="STAMP" value="<?php echo htmlspecialchars($stamp); ?>" />
    <input type="hidden" name="SITE" value="<?php echo htmlspecialchars($site); ?>" />
    <input type="hidden" name="AMOUNT" value="<?php echo htmlspecialchars($amount); ?>" />
    <input type="hidden" name="FEE" value="<?php echo htmlspecialchars($fee); ?>" />
    <input type="hidden" name="VAT_VALUE" value="<?php echo htmlspecialchars($vat_value); ?>" />
    <input type="hidden" name="REJECT" value="<?php echo htmlspecialchars($rejectUrl); ?>" />
    <input type="hidden" name="CANCEL" value="<?php echo htmlspecialchars($cancelUrl); ?>" />
    <input type="hidden" name="RETURN" value="<?php echo htmlspecialchars($returnUrl); ?>" />
    <input type="hidden" name="MAC" value="<?php echo htmlspecialchars($mac); ?>" />
    <input type="submit" value="Pay with Epassi" />
</form>

</div>
-->

</body>
</html>

