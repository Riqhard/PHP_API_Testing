<?php
error_reporting(E_ALL);
$PALVELIN = $_SERVER['HTTP_HOST']."/";



//HOST PASS USER MYSQL_...

$DB = "sarjakuva_seuranta";

$LOCAL = in_array($_SERVER['REMOTE_ADDR'],array('127.0.0.1','REMOTE_ADDR' => '::1'));
if ($LOCAL) {	
    $tunnukset = "../../tunnukset.php";
    if (file_exists($tunnukset)){
        include_once("../../tunnukset.php");
        } 
    else {
        die("Tiedostoa ei löydy, ota yhteys ylläpitoon.");
        } 
        
    $PALVELU = "SarjakuvaSeuranta/";
    $db_server = $db_server_local;
    $db_username = $db_username_local; 
    $db_password = $db_password_local;
    $marvel_APIKEYPUBLIC = $marvel_APIKEYPUBLIC_local;
    $marvel_APIKEY = $marvel_APIKEY_local;
    $port = "3306";
    }


?>