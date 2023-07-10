num = 711

f = open('pairs.txt','w')
for i in range(num):
	v1 = num - i; # v1 goes from 711 to 1
	if v1 < 100:
		continue
	for j in range(num):
		v2 = j
		if v2 < 100:
			continue
		for k in range(num):
			v3 = k;
			if v3 < 100:
				continue
			for l in range(num):
				v4 = l
				if v4 < 100:
					continue
				if (v1 + v2 + v3 + v4 == 711):
					f.write(f"{v1}, {v2}, {v3}, {v4}\n")
					print(f"solution values are: {v1}, {v2}, {v3}, {v4}")
					#exit()

f.close()
