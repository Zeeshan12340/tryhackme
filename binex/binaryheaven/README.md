download files and start analyzing in ghidra
ghidra showed ptrace which checks for debuggers and exits

Angel_A:
		started analysis in gdb
		gdb file
		r #run, b main #breakpoint at main, n #next, info locals, p *<mem_addr> #print address,
		list main #pdf @main
		Going through code in r2 #literally reading the f**nglines,
		we see 
			'xor eax, 4
			movsx eax, al
			add eax, 8
			cmp edx, eax'
		the string it uses is '0x55bc5f900060 ; U"kym~humr"'
		so just take 'kym~humr' on cyberchef and do 'SUB' with hex and key 8
		and XOR with hex and key 4
Angel_B:
	this is not a binary written in a "usual" language; it's written in Golang pdf @sym.main.main
	password is written in plain text as a comment, just had to find the sym.main.main function
Binex_binary:
	stack-based Buffer overflow
	the strcpy function doesn’t perform any bounds checking implicitly; thus, we will be able to write more than 256 characters into the variable buffer and buffer overflow occurs. A stack-based buffer overflow vulnerability can be exploited by overwriting the return address of a function on the stack.
		use cyclic command to generate payload `cyclic 100 > /tmp/inp`
		\
		"Put the pattern in temporary file, open the binary in gdb and run it with supplying that pattern. This will cause segfault. Take the value it gave and use cyclic -l value to find the offset."
		use the exploit given by 'pwntools'
Root:
	We can see that on line 17, the code is running the echo command specifically from the env variable. Which means this binary is potentially affected by environment variable manimupation attack
