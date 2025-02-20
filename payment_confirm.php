<?php
include 'interface.php';



$secretKey = "1TRQVUMAUBX4";
$returnUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
$rejectUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
$cancelUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";


$epassi = new EpassiVerifier("key", True);

?>


<html>
<head>
  <title>epassi response tester</title>
</head>
 
<body>
  <h1>epassi response tester</h1>
 
  <?php

  if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    echo "You got Post<br>";
    [$ok, $stamp, $paid] = $epassi->verifyPaymentConfirmation($_POST);
    echo "You got Verified<br>";
    if ($ok) {
      echo "Payment confirmation received<br>";
      echo "Confirmation contents: <br><hr>";
      echo "STAMP: " . $stamp . "<br>";
      echo "PAID: " . $paid . "<br>";
      echo "MAC: " . $_POST['MAC'] . "<hr>";
    }else{
      echo "Invalid<br>";
    }
  }elseif($_SERVER['REQUEST_METHOD'] == 'GET'){
    
    echo "You got Get<br>";
    [$ok, $stamp, $error]= $epassi->checkRejection($_GET);
    echo "You got Rejected<br>";
    if ($ok) {
      echo "<b>Contents: <br><hr>";
      echo "STAMP: " . $stamp . "<br>";
      echo "Error: " . $error . "<hr></b>";
    }else{
      echo "Invalid<br>";
    }
  }
  echo "<i>POST contents<hr>";
  echo "MAC: " . $_POST['MAC'] . "<br>";
  echo "PAID: " . $_POST['PAID'] . "<br>";
  echo "STAMP: " . $_POST['STAMP'] . "<br></i>";
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