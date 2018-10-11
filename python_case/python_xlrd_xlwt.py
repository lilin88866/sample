# python_xlrd_xlwt.py
import xlrd
import xlwt

def readexcel(depdict,revList,branch):
	ft_report_analysis="ft_report_analysis_"+branch+".xls"
	rfile=xlrd.open_workbook(ft_report_analysis)
	table = rfile.sheet_by_name("ft_report_analysis")
	oldExcelList={}
	for row in range(0,table.nrows):
		if table.row_values(row)[0:][5].find("@[fixed]")==-1:
				oldExcelList.update({table.row_values(row)[0:][1]:table.row_values(row)[0:]})
	oldExcelList=updateExcelByJenkins(oldExcelList,depdict,branch)
	updateExcel(oldExcelList,branch)
	return oldExcelList

def writeexcel(oldExcelList,branch):
	wbk=xlwt.Workbook()
	sheet = wbk.add_sheet('ft_report_analysis')
	for row in range(len(oldExcelList)):
		for colom in range(len(oldExcelList[oldExcelList.keys()[row]])):
			sheet.write(row,colom,oldExcelList[oldExcelList.keys()[row]][colom]) 
 	wbk.save("ft_report_analysis_"+branch+".xls")
if __name__ == '__main__':
	print xlrd.__doc__