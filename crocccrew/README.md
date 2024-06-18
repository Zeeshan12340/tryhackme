windows dc machine, lots of ports, domain name is COOCTUS

web has dummy page, robots.txt has /db-config.bak, /backdoor.php

/db-config.bak has `db.cooctus.corp`, `C00ctusAdm1n:B4dt0th3b0n3`

we can login anonymously with rpcclient and rdesktop using `rpcclient -U% 10.10.10.10`
and `rdesktop -f -u "" 10.10.10.10`, the lockscreen wallpaper has guest username:login as

`Visitor:GuestLogin!` honestly, kind of a stupid way to give creds for a ctf ¯\_(ツ)_/¯

we do an ldapsearch with `ldapsearch -h 10.10.10.10 -x -s base namingcontexts` to find domain name

then, `ldapsearch -h 10.10.10.10 -x -b 'DC=COOCTUS,DC=CORP` but not much comes up, we do an authenticated one with

`ldapsearch -h 10.10.10.10 -x -b 'DC=COOCTUS,DC=CORP -D 'COOCTUS\Visitor' -W > ldap_croccrew.txt`
this gives us the planted username

