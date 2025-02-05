<?php
include 'interface.php';

// Replace these with actual values
$stamp = rand(1000, 65535);
$site = "77190";
$amount = "4.30";
$fee = "5.0";
$vat_value = "6.0";


$form = generateEpassiForm($stamp, $site, $amount, $fee, $vat_value);




echo "STAMP: " . $stamp;
echo "<br>";
echo "SITE: " . $site;
echo "<br>";
echo "AMOUNT: " . $amount;
echo "<br>";
echo "FEE: " . $fee;
echo "<br>";
echo "VAT_VALUE: " . $vat_value;
echo "<br>";
echo "FORM: " . $form;

?>