nmap scan of all ports shows port 15065 which shows user "Dan" and port 16109 which has jpeg picture.

#A script shows a possible user "123456789" \\probably an error

Jpeg picture extracted with steghide and no password gives "pasta:pastaisdynamic" which is ssh username and password.

/usr/bin/vim.basic is running with root privliges so we edit /etc/passwd with vim.basic to set a new password($1$DPv8c6NO$ShW/x3m4REiG9UoEe5q.H1) for root b/w first & second colon.

su friend into root