<?php

# Define constants
define("EPASSI_API_URL", "https://prodstaging.Epassi.fi/e_payments/v2");

# API payment rejection errors
define("ERROR_INVALID_REQ", "INVALID_REQUEST");
define("ERROR_INVALID_SIGNATURE", "INVALID_REQUEST_SIGNATURE");
define("ERROR_SITE_ERR", "SITE_DOES_NOT_EXIST");

# Some default texts used

define("ERROR_INVALID_REQ_TEXT", "Rejected: Malformed payment form");
define("ERROR_INVALID_SIGNATURE_TEXT", "MAC signature is invalid");
define("ERROR_SITE_ERR_TEXT", "Provided site login is incorrect");

define("PAY_BUTTON_TEXT", "Pay with Epassi");

# Set the testing flag to true to use the test credentials
define("TESTING", true);  

# Load secret key from environment variable
if (TESTING) {
    define("MAC", "1TRQVUMAUBX4");
    define("SITE", "77190");
    define("RETURN_URL", "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php");
    define("CANCEL_URL", "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php");
    define("REJECT_URL", "https://kilpimaari-htc3def2dpckc4ht.westeurope-01.azurewebsites.net/payment_confirm.php");
} else {

    # Load constants from environment variables
    # NOTE: EPASSI_KEY and EPASSI_LOGIN might need renaming for clarity

    define("MAC", getenv("EPASSI_KEY"));
    define("SITE", getenv("EPASSI_LOGIN"));
    define("RETURN_URL", getenv("RETURN_URL"));
    define("CANCEL_URL", getenv("CANCEL_URL"));
    define("REJECT_URL", getenv("REJECT_URL"));
}


# sha512 generator, returns hash
function generateSHA512($stamp, $site, $amount, $fee = "", $vatValue = "") {
  if (!empty($fee) && !empty($vatValue)) {
      return hash('sha512', $stamp . $site . $amount . $fee . $vatValue . MAC);
  } else if (!empty($fee)) {
      return hash('sha512', $stamp . $site . $amount . $fee . MAC);
  } else if (!empty($vatValue)) {
      return hash('sha512', $stamp . $site . $amount . $vatValue . MAC);
  } 

  return hash('sha512', $stamp . $site . $amount . $macKey);
} 


# sha512 verifier, returns true or false
# Note that MAC is the epassi secret key. sha512 should be what the API refers to as MAC. Not confusing at all...
function verifySHA512($sha512, $stamp, $paid) {
    $hash = hash('sha512', $stamp . $paid . MAC);
    if ($hash == $sha512) {
        return true;
    }
    return false;
}


# function to check if the payment was rejected or cancelled. Returns array [OK, stamp, error]
function checkRejection($parameters) {
    $error = "";
    $stamp = "";
    if (isset($parameters['stamp'])) {
        $stamp = $parameters['stamp'];
        if (isset($parameters['error'])) {
            $error = $parameters['error'];
        }
    } else {
        return [false, null, null];
    }
    return [true, $stamp, $error];
}


# function to check the error type. Returns [OK, error_description]
function checkErrorType($error) {
    if ($error == ERROR_INVALID_REQ) {
        return [true, ERROR_INVALID_REQ_TEXT];
    } else if ($error == ERROR_INVALID_SIGNATURE) {
        return [true, ERROR_INVALID_SIGNATURE_TEXT];
    } else if ($error == ERROR_SITE_ERR) {
        return [true, ERROR_SITE_ERR_TEXT];
    }
    return [false, null];
}


# function to check if the error is valid. Returns true or false
function isErrorValid($error) {
    if ($error == ERROR_INVALID_REQ || $error == ERROR_INVALID_SIGNATURE || $error == ERROR_SITE_ERR) {
        return true;
    }
    return false;
}



# function to generate the epassi HTML-form. Returns the form as a string
function generateEpassiForm($stamp, $amount, $fee = "", $vatValue = "", $buttonText = PAY_BUTTON_TEXT) {
    $form = "<form action='" . EPASSI_API_URL . "' method='post'>";
    $form .= "<input type='hidden' name='STAMP' value='" . $stamp . "'>";
    $form .= "<input type='hidden' name='SITE' value='" . SITE . "'>";
    $form .= "<input type='hidden' name='AMOUNT' value='" . $amount . "'>";
    $form .= "<input type='hidden' name='FEE' value='" . $fee . "'>";               # If fee is empty, should the field be included?
    $form .= "<input type='hidden' name='VAT_VALUE' value='" . $vatValue . "'>";    # If vatValue is empty, should the field be included?
    $form .= "<input type='hidden' name='REJECT' value='" . REJECT_URL . "'>";
    $form .= "<input type='hidden' name='CANCEL' value='" . CANCEL_URL . "'>";
    $form .= "<input type='hidden' name='RETURN' value='" . RETURN_URL . "'>";
    $form .= "<input type='hidden' name='MAC' value='" . generateSHA512($stamp, $site, $amount, $fee, $vatValue) . "'>";
    $form .= "<input type='submit' value='" . $buttonText . "'>";
    $form .= "</form>";
    return $form;
}


?>

