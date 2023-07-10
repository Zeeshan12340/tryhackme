3 ports, 21, 80, 1337(ssh)
ftp:
	ftp doesn't have anonymous login
	"fptuser" bruteforeced with hydra gave "love4ever"
	different files, data-4 had id_rsa and note which gave ssh username

web:
	web has sub directories /webmasters and robots.txt
	there is also /webmasters/admin and /webmasters/backups
	after logging in, /backups had backups.zip
ssh:
	id_rsa cracked with john gave ssh password 'bluelove'

	listing condor user gave a base64-encoded link and user flag

	link had image to be decrypted with Mnemonic script which gave password 'pasificbell1981'
	baron samedit