#!/bin/bash
cat ./dict | while read line
do
	echo $line
	ssh -tt -i key $line@$1
	echo "letmein"
done

