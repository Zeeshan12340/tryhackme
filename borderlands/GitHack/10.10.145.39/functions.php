<?php

function setup_db_connection()
{
    $db_servername = "localhost";
    $db_username = "root";
    $db_password = "CCv4@he2MaHbIP7mB89TNKdei0VZ0Y";
    $db_name = "myfirstwebsite";

    // Create connection
    $conn = new mysqli($db_servername, $db_username, $db_password, $db_name);

    // Check connection
    if ($conn->connect_error) {
        die("failed to connect to the database. Something has gone horribly wrong...: " . $conn->connect_error);
    }else{
        return $conn;
    }
}

function ShowDocuments ($conn) 
{
    echo ("<p>Below you will find a list of documents that are available to download</p>");

    echo ("<ul>");

    $stmt = $conn -> prepare('SELECT documentname, location FROM documents');

    $stmt -> execute();
    $stmt -> store_result();
    $stmt -> bind_result($document_name, $location);
    
    while ($stmt -> fetch()) {
        echo ('<li><a href="'.$location.'">'.$document_name.'</a></li>');
    }
    echo ("</ul>");
}

function ShowLoggedOutView ($conn)
{
    echo ("<p>Welcome to our site. Please bear with us whilst we get everything up and running.</p>");
    
    /*
    $options = [
        'salt' => 'wWeyIzGcD7TVwZ7y7d3UCRIMYK'
    ];
    echo password_hash("hello", PASSWORD_BCRYPT, $options);
    */

    ShowDocuments($conn);


    echo ("<p>login below to edit documents</p>");

    echo ('<form method="POST">');
    echo ('username: <input type="text" name="username" id="username"><br />');
    echo ('password: <input type="password" name="password" id="password"><br />');
    echo ('<input type="submit">');
}

function CheckLogon ($conn)
{
    $options = [
        'salt' => 'wWeyIzGcD7TVwZ7y7d3UCRIMYK'
    ];
    //do logon check
    $username = $_POST['username'];
    $password = password_hash($_POST['password'], PASSWORD_BCRYPT, $options);

    $stmt = $conn->prepare("SELECT userid FROM users WHERE username=? AND password=?");
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();
    $stmt -> store_result();

    if ($stmt->num_rows == 1) {
        //echo ("logged on successfully");
        $_SESSION['loggedin'] = true;
        header("Location: home.php");
        die();
    }else{
        echo ("bad username or password");
    }
}

function UpdateDocumentName($conn, $documentid, $documentName)
{
    $sql = "update documents SET documentname='".$documentName."' WHERE documentid=".$documentid;
    //echo $sql;
    if (mysqli_query($conn, $sql)) {
        echo ('Document renamed. Click <a href="home.php">here</a> to go back');
    }else{
        echo ('Sorry. There was a problem renaming the document. Click <a href="home.php">here</a> to go back');
    }
}

function GetDocumentDetails($conn, $documentid)
{
    $sql = "select documentid, documentname, location from documents where documentid=".$documentid;
    //echo $sql;
    $result = mysqli_query($conn, $sql) or die(mysqli_error($conn));

    if (mysqli_num_rows($result) === 1) {
        return mysqli_fetch_assoc($result);
    } else {
        return null;
    }
}

?>