Windows machine involving crackmapexec and "openfire".

main website has "reset password" feature, which resets the password of user "lilyle" as we know
the dog's name from the image

`lilyle:ChangeMe#1234`

these give smb access, from where we find two shares, one looks to be random files, with NTUSER.DAT having
!Do not use this registry key
{374DE290-123F-4565-9164-39C4925E467B}

and the other has "spark" application, which after setting trust certificates and second option in spark 
allows login with the above user creds.

we can also login to the xmpp client with "lilyle" creds.
https://www.cve.org/CVERecord?id=CVE-2020-12772 

by finding the cve needed, we see a poc on github that simply needs a message sent to the user with an img tag
that has a src to our responder, and responder running locally to catch the hash.
`buse:uzunLM+3131`