import requests

url = 'http://yearofthedog.thm'

for _ in range(100):
	req = requests.get(url)	

	number = req.text[551] + req.text[552]
	print(number + ':' + req.headers['Set-Cookie'].split('=')[1].split(';')[0])
	f = open('id.txt','a')
	f.write(number + ':' + req.headers['Set-Cookie'].split('=')[1].split(';')[0])
	f.write('\n')
	f.close()