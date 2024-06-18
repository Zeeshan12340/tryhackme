import requests
import urllib.request, urllib.error, urllib.parse

data = "action=" + str(bytes(urllib.request.urlopen('http://localhost/data').read()))
headers = {"Content-Type": "application/x-www-form-urlencoded"}


proxies = {
   'http': 'http://localhost:8080',
   'https': 'http://localhost:8081',
}
r = requests.post('http://10.10.47.169/action.php', headers=headers, data=data, proxies=proxies)

print(r.text)
print(r.headers)
