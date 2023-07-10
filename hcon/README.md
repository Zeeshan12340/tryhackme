standard ssh and two web services, port 80 has a simple register/login form,
/admin has a apk file(need reversing) and we get a hint for a possible username below:
#Administrator for / is: administratorhc0nwithyhackme
#remember, remember the famous group 3301 to solve this, the secret IV wait for you!
login: administratorhc0nwithyhackme   password: p4ssw0rd

port 8080 has a werird base64 encoded string, dirbusting gave nothing, nothing on headers/cookies
`RwO9+7tuGJ3nc1cIhN4E31WV/qeYGLURrcS7K+Af85w=`
