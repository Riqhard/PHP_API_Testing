<?php
// Start session if needed
session_start();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Failed</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        .container { max-width: 400px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; background: #ffe6e6; }
        a { display: block; margin-top: 20px; color: #d9534f; text-decoration: none; }
    </style>
</head>
<body>

<div class="container">
    <h2>Payment Failed</h2>
    <p>Unfortunately, your payment was not successful. Please try again or contact support.</p>
    <a href="checkout.php">Retry Payment</a>
    <a href="contact.php">Contact Support</a>
</div>

</body>
</html>