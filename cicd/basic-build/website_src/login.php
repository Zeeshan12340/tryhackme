<?php
session_start();

$usr_username = $_GET["user"];
$usr_password = $_GET["password"];
if ($usr_username == "admin" && $usr_password == "admin")
{
    session_start();
	$_SESSION["loggedin"] = true;
	$_SESSION["username"] = $usr_username;
	header("location: timekeep.php");
}
?>
