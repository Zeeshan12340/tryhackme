thm.png on apache2 default page

change hex header to that of jpg "FF D8 FF E0	00 10 4A 46		49 46 00 01"

this image showed a hidden dir /th1s_1s_h1dd3n
which we bruteforced with python script to get secret username

Which was ironically not a hash but steghide password of thm.jpg

extracted thm.jpg with username gave hidden.txt which had rot username joker

Machine image file extracted with steghide gave password.txt which had ssh password of joker

find /bin -perm -4000 showed screen 4.5.0, googling exploit gave exploit.sh which can be used for local privesc to get root.

