<?php
// Start session if needed
session_start();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Cancelled</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        .container { max-width: 400px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; background: #f8f8f8; }
        a { display: block; margin-top: 20px; color: #007bff; text-decoration: none; }
    </style>
</head>
<body>

<div class="container">
    <h2>Payment Cancelled</h2>
    <p>You have cancelled your payment. If this was a mistake, you can try again.</p>
    <a href="checkout.php">Try Again</a>
    <a href="index.php">Go Back to Homepage</a>
</div>

</body>
</html>