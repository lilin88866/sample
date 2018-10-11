import csv

def readCsv(fileName):
	

	csvWrite = csv.writer(file(fileName,"wb"))
	csvWrite = csvWrite.writerow(["lilin"])
	lines = [range(3) for i in range(5)]
	for line in lines:
	    csvWrite.writerow(line)

	csvFileContent = csv.reader(file(fileName,"rb"))
	print type(csvFileContent)
	commoNum = None
	for line in csvFileContent:
		commoNum = len(line)-1
		print commoNum
def readFileColomn(csvFile):
	csvFileContent = open(csvFile,'rb')
	with open(csvFile) as f:
		line = f.read()
		print line.split(",")


if __name__ == '__main__':

	csvFile = r"D:\study\python_case\ULPHY_SCT_eparams_single_pucch_TL15A_CP_3cell_Comp_UDconf1.csv"
	readFileColomn(csvFile)