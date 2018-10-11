# python_fileinput.py
#
import fileinput

for line in fileinput.input(".config"):
	if fileinput.isfirstline():
		print line