<?php
include_once "payments.php";

$db_server = "localhost";
$db_username = "root";
$db_password = "";
$DB = "store_testing_database";
$port = 3306;

$epassiReturn = "";


try {
    $mysqli = new mysqli($db_server, $db_username, $db_password, $DB, $port);
    if ($mysqli->connect_error) {
        die("Yhteyden muodostaminen epäonnistui: " . $mysqli->connect_error);
        }
    $mysqli->set_charset("utf8");
}
catch (Throwable $e) {
    die("Virhe yhteyden muodostamisessa: " . $e->getMessage());
}

$paymentProcessor = new PaymentProcessor($mysqli, " ", " ", "Button Text", $epassiReturn, $epassiReturn, $epassiReturn);
echo "paymentProcessor loaded<br><hr>";
echo var_dump($paymentProcessor);

?>