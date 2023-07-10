import requests
import json

url = "https://tryhackme.com/api/tasks/"

lines = open("./rooms.txt", "r").readlines()
cookies = {"_csrf":"",
			"AWSALBCORS":"",
			"AWSALB":"",
			"connect.sid":"",
			"cookieconsent_status":"dismiss"} #your personal cookies for checking your tasks

counter = 0
for line in lines:

	url = f"https://tryhackme.com/api/tasks/{line.strip()}" #updated url with a room code

	r = requests.get(url,cookies=cookies)  #get the raw json data
	json_data = json.loads(r.text)      #parse it with json module
	
	for task in json_data['data']:   # looping over tasks in room, key name is `data`
		for question in task['tasksInfo']: #looping over questions in a specific task
			value = question['correct']			#getting value of task, true if correct, false otherwise	

			if  str(value).lower() != 'true':
				print(f"The {url} room has unfinished tasks")
				continue
	counter = counter + 1
	print(f"{counter}: this room is complete {line}", end='')

