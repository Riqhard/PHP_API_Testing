<?php
// Replace these with actual values
$secretKey = "1TRQVUMAUBX4";
$stamp = "test1234";
$site = "77190";
$amount = "4.30";
$fee = "5.75";
$vat_value = "6.0";
$returnUrl = "https://yourwebsite.com/payment_confirm.php";
$rejectUrl = "https://yourwebsite.com/payment_failed.php";
$cancelUrl = "https://yourwebsite.com/payment_cancelled.php";

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
// echo mac
echo "Generated MAC: " . $mac;

?>

<!-- Payment Form -->
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