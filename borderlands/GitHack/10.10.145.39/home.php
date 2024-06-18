<?php

session_start();
require_once("functions.php");

$conn = setup_db_connection();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true)
{
    header("Location: index.php");
    die();
}

echo ("<p>Click on a link below to view the document properties</p>");


$stmt = $conn -> prepare('SELECT documentid, documentname, location FROM documents');

$stmt -> execute();
$stmt -> store_result();
$stmt -> bind_result($documentid, $document_name, $location);

$resultsArray = [];
echo ("<ul>");
while ($stmt -> fetch()) {
    echo ('<li><a href="api.php?documentid='.$documentid.'&amp;apikey=WEBLhvOJAH8d50Z4y5G5g4McG1GMGD">'.$document_name.'</a></li>');
    $resultsArray[] = array("documentid" => $documentid, "documentname" => $document_name, "location" => $location);
}
echo ("</ul>");

/*
if (isset($_GET['documentid']) && is_numeric($_GET['documentid']))
{
    foreach ($resultsArray as $result)
    {
        if ($result["documentid"] == $_GET['documentid'])
        {
            echo "<p>Enter the new name for the document: ".$result['documentname']."</p>";
            echo ('<form method="GET" action="api.php">');
            echo ('<input type="hidden" id="documentid" name="documentid" value="'.$_GET['documentid'].'" />');
            echo ('<input type="hidden" id="apikey" name="apikey" value="WEBLhvOJAH8d50Z4y5G5g4McG1GMGD" />');
            echo ('<input type="text" id="newname" name="newname" />');
            echo ('<input type="submit" />');
        }
    }
}
*/

?>