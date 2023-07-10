#!/usr/bin/env python3
import requests

url = 'http://10.10.169.100:3000'

flag = ''
v, n = '', ''

while v != 'end' and n != 'end':
    r = requests.get('%s/%s' % (url, n))
    print(r.text)
    j = r.json()
    v, n = j['value'], j['next']
    flag += v

print(flag[:-3])