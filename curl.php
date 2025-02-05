<?php

// Prepare the POST data (as a query string)
$queryString = http_build_query([
    "STAMP" => $stamp,
    "SITE" => $site,
    "AMOUNT" => $amount,
    "FEE" => $fee,
    "VAT_VALUE" => $vat_value,
    "REJECT" => $rejectUrl,
    "CANCEL" => $cancelUrl,
    "RETURN" => $returnUrl,
    "MAC" => $mac
]);

// Initialize cURL
$ch = curl_init($epassi_url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postData));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // Disable SSL verification in testing

// Execute the request
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

// Handle response
if ($httpCode == 200) {
    echo "Payment request sent successfully! Response: <br>";
    echo nl2br(htmlspecialchars($response));
} else {
    echo "Error: Failed to send payment request. HTTP Code: $httpCode";
}
?>