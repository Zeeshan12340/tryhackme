port 7,21,22,23,80,61337 open, 
port 7 is an echo port, can't escape text for command injection, nothing on hacktricks except DOS
port 21, ftp doesn't have anonymous login(or ftpuser:ftppass), need creds to move further here
port 22, standard ssh, need creds
port 23, telnet login, asks for creds
port 80, dummy web port, no dirs or anything interesting
port 61337, flask python web server, login form, template injection on login form, filter bypass needed
the following characters are filtered/blocked,
	`' _ & ;`



