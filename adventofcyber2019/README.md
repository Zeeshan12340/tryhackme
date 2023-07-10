For first day:
	create a user then you will see a cookie.
	create two users and compare their cookie value to get fixed value and just write username before fixed value ecnode it to base64 and you'll have access.

for i in {1..8}; do cat file$i | grep password && echo file$i; done

Always look for backups accessible by everyone \\in /opt or in /var usually

A username is too powerful to describe in its usefulness in OSINT

Always try to decode any weird texts 
system-connections \\too stupid to be useful in real life tho, like a root command executer binary?! it's never that simple.

Try all the exploits in metasploit or if not research more to find a specific vulnerability
head -n <line number> file  shows string at specified line at end of output

Port 2049 nfs service, use "showmount -e <IP>" to list mountable directories.

and "mount -t nfs <IP>:/file/dir /tmp/dir/"

for reflected xss, we used a web server(ruby) on port 8080 and made request to it through js script with document.location 
	\\Honestly, didn;t really get what went down. Maybe, victim server made requests to admin which were sent to our server. Don't want to research rn but I'll probably learn better going forward.