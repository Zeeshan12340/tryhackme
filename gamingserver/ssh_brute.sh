#!/bin/bash
cat /root/TryHackMe/gamingserver/dict | while read line
do
	echo $line
	ssh -tt -i id_rsa $line@10.10.212.177
	echo "letmein"
done

