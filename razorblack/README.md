enum4linux gave a domain name(tried different tld dunno how forgot thm)
nfs share on 2049 gives steven's flag
also got a list of usernames from xlsx file

administrator@raz0rblack.thm
twilliams@raz0rblack.thm:roastpotatoes

lvetrova@raz0rblack.thm
sbradley@raz0rblack.thm

pre-auth doesn't give any other hashes
need to look closer on nmap ports 
smbclient -U 'twilliams%roastpotatoes' -L //10.10.157.225 gives smb shares
