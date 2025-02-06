<?php
include 'interface.php';



if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $stamp = rand(1000, 65535);
    $amount = $_POST['amount'];
    $fee = $_POST['fee'];
    $vat_value = $_POST['vat_value'];

    generateEpassiForm($stamp, $amount, $fee, $vat_value);
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>ePassi Form</title>
</head>
<body>
    <form method="post" action="">
        <label for="amount">Amount:</label>
        <input type="number" id="amount" name="amount" step="0.01" required><br><br>
        
        <label for="fee">Fee:</label>
        <input type="number" id="fee" name="fee" step="0.01"><br><br>
        
        <label for="vat_value">VAT Value:</label>
        <input type="number" id="vat_value" name="vat_value" step="0.01"><br><br>
        
        <input type="submit" value="Submit">
    </form>
</body>
</html>