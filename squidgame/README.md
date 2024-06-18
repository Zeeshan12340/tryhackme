doc files, huh?

Resources/tools:
	The skills/tools to be tested and needed to eliminate the five attackers in this room are Oletools, Oledump, OfficeMalwareScanner, CyberChef, and hybrid-analysis.com 

Attacker1.doc:
	Upload file to hybrid-analysis.com and see first windows report, under "Suspicious Indicators" -> "Anti-Reverse Engineering"
	copy encoded string to cyberchef, base64 decode, remove whitespace and null bytes, extract urls

	search for exe, %ProgramData%(pretty common apparently), second link from above
	olevba gives AutoExec
	Using oledump gives the Macro stream(M letter) and its name

Attacker2.doc:
	use oledump to list strings with macros, use -i to see size (bytes) of the compiled code, largest size from previous output
	`oledump -s 16 -v attacker2.doc` to list shell commands used
	use strings command with grep to answer questions
	
