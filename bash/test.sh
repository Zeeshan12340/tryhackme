#!/bin/bash

name=$1
filename=$0
echo "$name and $filename"

transport=('car' 'train' 'bike' 'bus')
echo "${transport[@]}"
unset transport[1]
transport[1]='trainride'
echo "${transport[1]}"
