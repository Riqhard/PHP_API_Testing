

<html>
<head>
  <title>epassi response tester</title>
</head>
 
<body>
  <h1>epassi response tester</h1>
 
  <?php
  if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['STAMP']) && isset($_POST['PAID']) && isset($_POST['MAC'])) {
      echo "Payment confirmation received<br>";
      echo "Confirmation contents: <br><hr>";
      echo "STAMP: " . $_POST['STAMP'] . "<br>";
      echo "PAID: " . $_POST['PAID'] . "<br>";
      echo "MAC: " . $_POST['MAC'] . "<br>";
    } else if (isset($_POST['error'])) {
      echo "Payment rejected<br>";
      echo "Rejection error: " . $_POST['error'] . "<br>";
    } else {
      echo "Payment canceled or other some such<br>";
      echo "Response dump: <br><hr>";
      echo var_dump($_POST);
    }
    }
?>
 
Form for testing the response handling:
 
<form action="payment_confirm.php" method="post">
  <input type="hidden" name="STAMP" value="123456">
  <input type="hidden" name="PAID" value="true">
  <input type="hidden" name="MAC" value="1234567890">
  <input type="submit" value="Test return">
</form>
 
<form action="payment_confirm.php" method="post">
  <input type="hidden" name="error" value="error message">
  <input type="submit" value="Test reject">
</form>
 
<form action="payment_confirm.php" method="post">
  <input type="hidden" name="cancel" value="true">
  <input type="submit" value="Test cancel">
</form>
 
 
</body>
</html>