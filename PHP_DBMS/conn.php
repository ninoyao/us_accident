<?php

$dbhost = '127.0.0.1';
$dbuname = 'root';
$dbpass = '';
$dbname = 'accidents2';


//$dbo = new PDO('mysql:host=abc.com;port=3306;dbname=$dbname, $dbuname, $dbpass);

$dbo = new PDO('mysql:host=' . $dbhost . ';port=3306;dbname=' . $dbname, $dbuname, $dbpass);

?>
