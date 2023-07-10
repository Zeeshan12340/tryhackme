nmap showed many ports.
ftp had image which gave txt file with steghide \\ no password required

txt had shadow file, i.e., $6$ hash of user charlie

nmap vuln scan showed port 113 had link to key_rev_key file binary

running key_rev_key required a correct name but opening with nano showed the stored key

hashcat showed charlie password is cn7824

should've tried gobuster first, it showed home.php which has rce

id_rsa named as teleport \\can;t believe i didn't check the contents!!

ssh as charlie with id_rsa, sudo -l shows vi 

gtfobins sudo vi -c ':!/bin/sh' /dev/null to get root