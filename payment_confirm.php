<?php
include_once "payment_system/payments.php";



$secretKey = "1TRQVUMAUBX4";
$returnUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
$rejectUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
$cancelUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {  
  echo var_dump($_POST);
}elseif ($_SERVER["REQUEST_METHOD"] == "GET") {
  echo var_dump($_GET);
}
?>


<html>
<head>
  <title>epassi response tester</title>
</head>
 
<body>
  <h1>epassi response tester</h1>
 
  <?php

  
?>
 
Form for testing the response handling:
 
<form action="payment_confirm.php" method="post">
  <input type="hidden" name="STAMP" value="123456">
  <input type="hidden" name="PAID" value="1235.00">
  <input type="hidden" name="MAC" value="1234567890">
  <input type="submit" value="Test return">
</form>
 
<form action="payment_confirm.php" method="get">
  <input type="hidden" name="error" value="error message">
  <input type="submit" value="Test reject">
</form>
 
<form action="payment_confirm.php" method="get">
  <input type="hidden" name="cancel" value="true">
  <input type="submit" value="Test cancel">
</form>
 
 
</body>
</html>