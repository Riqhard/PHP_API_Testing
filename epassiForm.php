<?php
include 'interface.php';

// Replace these with actual values
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $stamp = rand(1000, 65535);
    $total = 0;

    if (isset($_POST['amount'])){
        $amount = $_POST['amount'];
        $total += (double)$amount;

        if (isset($_POST['fee'])){
            $fee = $_POST['fee'];
            $total += (double)$fee;
        }else{
            $fee = "";
        }
        if (isset($_POST['vat_value'])){
            $vat_value = $_POST['vat_value'];
        }else{
            $vat_value = "";
        }
    }
}else{
    $stamp = rand(1000, 65535);
    $amount = "0.00";
    $fee = "0.00";
    $vat_value = "6.00";
    $total = 0;
}

generateEpassiForm($stamp, $amount, $fee, $vat_value);
// Replace these with actual values
$secretKey = "1TRQVUMAUBX4";
$returnUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
$rejectUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
$cancelUrl = "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php";
 
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Epassi Payment Tester</title>
    <link rel="stylesheet" href="style.css">

</head>
<body>
    
<div class="fullContainer">
<h1>Epassi Payment Tester</h1>

    <div class="payment-container">
        <h2>Payment Form</h2>
        <form method="post" action="">
                <label for="amount">Amount:</label><br>
                <input type="number" id="amount" name="amount" step="0.01" required><br><br>
                
                <label for="fee">Fee (Optional):</label><br>
                <input type="number" id="fee" name="fee" step="0.01"><br><br>
                
                <label for="vat_value">VAT Value (Sweden only, eg. 6.0) (Optional):</label><br>
                <input type="number" id="vat_value" name="vat_value" step="0.1"><br><br>
                
                <input type="submit" value="Submit">
        </form>
    </div>

    <div id="payment-details" class="payment-container">
            <h2>Payment Details</h2>
            <p>Amount: <?php echo $amount; ?> €</p>
            <p>Fee: <?php echo $fee; ?> €</p>
            <p>VAT Value: <?php echo $vat_value; ?> %</p>
            <p>Total: <?php echo $total; ?> €</p>
    </div> 



    <div id="payment-container" class="payment-container">
        <h2>Epassi Payment</h2>
        <p>Please review the payment details below and click "Pay with Epassi" to proceed.</p>
        <?php 
        [$ok, $form] = generateEpassiForm($stamp, $amount, $fee, $vat_value);
        if ($ok) {
            echo $form;
        } else {
            echo "<p id='error'><b><i>Invalid amount, fee or VAT value.</i></b></p>";
        }
        
        ?>
    </div>

</div>


</body>
</html>

