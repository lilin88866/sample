import glob,fnmatch,os

for file in glob.glob("*.py"):
	print file

for file in os.listdir(os.getcwd()):
	if fnmatch.fnmatch(file,"*.py"):
		print file