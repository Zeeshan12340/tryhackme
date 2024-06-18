#!/usr/bin/env python3

import os
import zipfile
import exiftool

listoffiles = os.listdir(".")
print(type(listoffiles))

for file in listoffiles:
	print(file)

#with zipfile.ZipFile(".",'r') as zip_ref:
#	zip_ref.extractall('.')

files = ["./"]

with exiftool.ExifTool() as et:
	metadata = et.get_metadata_batch(files)
for d in metadata:
	
	print(d)
	