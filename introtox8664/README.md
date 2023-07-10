'''
Room Intro to x86 64

Default ssh login

Username:tryhackme Password:reismyfavl33t

'''
use below command to open assembly terminal

r2 -d <filename>

aaa \\analyze all flags afl \\lists all functions

e asm.syntax=att \\switch to AT&T syntax instead of intel syntax

pdf @main \\print disassembly function 

movq $3 rax \\It would move the constant 3 to the register

izz \\prints all strings info strings iA iM ie

s prints current memory address s+ 12 s- 5  sr rax


Find clear text password with izz
set breakpoint with db at compare statement(strcmp or cmp), use dc to run unitl breakpoint and px @rsi(or other memory location(not sure yet!))

also, check value with pdf @main of cmp location,  cmp eax, 0x137c  0x137c is the password

set breakpoints at jle and mov dword(not sure why this one?)

px @rbp-0x24