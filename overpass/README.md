Analyze pcap file and write http in filter to get url
	
there is an upload.php, analyze it to get the reverse shell.

In search option, search "nc" to get session history \\nc transfers command in plain text!!

see github package used, crack shadow file with john --wordlist shadow.txt

For default hash, run ./backdoor -h to get default hash.

see src code, main.go to see hardcoded salt( at the end of code)

see hash in nc history

append salt to end of hash wih $hash:$salt and crack with hashcat mode 1710

login with james@<IP> -p 2222 \\backdoor port with november16

.suid_bash is found which gives root shell with ./.suid_bash -p