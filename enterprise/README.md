a lot of ports open, no domain name provided but enum4linux give "LAB-ENTERPRISE" and rdp gives LAB.ENTERPRISE.THM
web is open(nothing much other than robots.txt troll) and samba has a few interesting open dirs (`Users` and `Docs`)

Docs has two password encrypted documents, tried office2john but hash cracking doesn't seem to work

LAB-ADMIN user has `credentials` file in "AppData/Local/Microsoft/Credentials/", need a key(policy.vpol) for decrypting.

users are "`Administrator, 'All Users', atlbitbucket, bitbucket, Default, 'Default User', LAB-ADMIN, Public`"
'console history.txt' for `LAB-ADMIN` has the following creds:

`replication:101RepAdmin123!!` checked creds against samba,winrm, docx files

port 7990 has a web service running "ATLASSIAN"	
nik:ToastyBoi!
bitbucket:littleredbucket
