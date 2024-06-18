import os

moodle_location = "/var/www/html/"
backup_location = "/tmp/backup/"

os.system("/usr/bin/rm -rf " + backup_location + "*")

for (root,dirs,files) in os.walk(moodle_location):
 for file in files:
  os.system('/usr/bin/cp "' + root + '/' + file  + '" ' + backup_location)
