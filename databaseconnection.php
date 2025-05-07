<?php

$user = "root";
$password = "";
$database = "acadamic_proposals";
$host = "localhost";
$port = 3306;  // Explicitly specify port 3308

$connection = new mysqli($host, $user, $password, $database, $port); 

// Check the connection
if ($connection->connect_error) {
    die("Unable to connect: " . $connection->connect_error);
}

?>
