def splitFile(fromfile):
	partnum=0
	inputfile = open(fromfile,'rb')
	while True:
		chunk = inputfile.read(logFileMaxSize)
		if not chunk:             
			break
		partnum += 1
		filename = "sortedLog%003d.log"%(partnum)
		fileHandle = open(filename,'wb')
		fileHandle.write(chunk)
		filterLog(filename)
		fileHandle.close()
	inputfile.close()
def sortLog1(logFile):
	with open (sortedLog,"w") as sortedLogHandle:
		sortedContent= "".join(sorted(open (combinedLog,"r").readlines(),key=lambda line:getTime(line)))
		sortedLogHandle.write(sortedContent)
	if os.path.getsize(sortedLog)>logFileMaxSize:
		splitFile(sortedLog)
		os.remove(sortedLog)