<?php
require_once 'db_test.php';


// Insert functions
function insert_customer($customer_uid, $first_name, $last_name, $address, $postal_code, $city, $email, $phone_number, $birth_date, $language, $encrypted_password, $is_active, $terms_accepted) {
    $query = "INSERT INTO customers (customer_uid, first_name, last_name, address, postal_code, city, email, phone_number, birth_date, language, encrypted_password, is_active, terms_accepted, created_at, updated_at) 
              VALUES ('$customer_uid', '$first_name', '$last_name', '$address', '$postal_code', '$city', '$email', '$phone_number', '$birth_date', '$language', '$encrypted_password', $is_active, $terms_accepted, NOW(), NOW())";
    return mysqli_my_query($query);
}

function insert_order($order_uid, $customer_id, $payment_id, $status, $details, $order_price_excl_vat, $order_price_incl_vat) {
    $query = "INSERT INTO orders (order_uid, customer_id, payment_id, status, details, order_price_excl_vat, order_price_incl_vat, created_at, updated_at) 
              VALUES ('$order_uid', $customer_id, $payment_id, $status, '$details', $order_price_excl_vat, $order_price_incl_vat, NOW(), NOW())";
    return mysqli_my_query($query);
}

function insert_payment($filing_identifier, $payment_status, $payment_provider, $psp_transaction_id, $psp_token) {
    $query = "INSERT INTO payments (filing_identifier, payment_status, payment_provider, psp_transaction_id, psp_token, created_at, updated_at) 
              VALUES ('$filing_identifier', $payment_status, '$payment_provider', '$psp_transaction_id', '$psp_token', NOW(), NOW())";
    return mysqli_my_query($query);
}



// Get functions
function get_order_by_id($order_id) {
    $query = "SELECT * FROM orders WHERE order_id = $order_id";
    return mysqli_my_query($query);
}

function get_payment_by_id($payment_id) {
    $query = "SELECT * FROM payments WHERE payment_id = $payment_id";
    return mysqli_my_query($query);
}

function get_customer_by_id($customer_id) {
    $query = "SELECT * FROM customers WHERE customer_id = $customer_id";
    return mysqli_my_query($query);
}




// Update functions
function update_payment_status($payment_id, $payment_status) {
    $query = "UPDATE payments SET payment_status = $payment_status, updated_at = NOW() WHERE payment_id = $payment_id";
    return mysqli_my_query($query);
}

function update_payment_psp_transaction_id($payment_id, $psp_transaction_id) {
    $query = "UPDATE payments SET psp_transaction_id = '$psp_transaction_id', updated_at = NOW() WHERE payment_id = $payment_id";
    return mysqli_my_query($query);
}

function update_payment_filing_identifier($payment_id, $filing_identifier) {
    $query = "UPDATE payments SET filing_identifier = '$filing_identifier', updated_at = NOW() WHERE payment_id = $payment_id";
    return mysqli_my_query($query);
}

function update_order_status($order_id, $status) {
    $query = "UPDATE orders SET status = $status, updated_at = NOW() WHERE order_id = $order_id";
    return mysqli_my_query($query);
}

function update_order_updated_at($order_id) {
    $query = "UPDATE orders SET updated_at = NOW() WHERE order_id = $order_id";
    return mysqli_my_query($query);
}



?>
