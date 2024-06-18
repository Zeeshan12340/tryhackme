#!/usr/bin/env python3


import requests, sys 

if len(sys.argv) == 1:
	print('Format: script.py <IP>')
	exit()
else:
	ip=sys.argv[1]
print({ip})
for api_key in range(1,100,2):
	print(f'api_key {api_key}')

	html = requests.get(f'http://{ip}/api/{api_key}') 

	print(html.text)