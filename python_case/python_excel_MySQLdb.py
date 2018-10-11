import xlrd
import MySQLdb




# read cell value from excel
def get_row_col(excel):

	for row in range (excel.nrows):
		for col in range (excel.ncols):
			print row,excel.cell(row,col).value

	# connect db
def read_excel_data_to_db():

	conn=MySQLdb.connect(host="127.0.0.1",user="root",passwd="1",db="lilin",charset="utf8")
	cursor = conn.cursor()
	# cursor.execute("create table excel1(col int,value char(20),value1 char(20))")
	cursor.execute("describe excel1")
	print cursor.fetchall()

	for row in range (excel.nrows):
			values =  row,excel.cell(row,1).value
			param = (row,excel.cell(row,0).value,excel.cell(row,1).value)
			sql = "insert into excel1 (col,value,value1) values(%s,%s,%s)"
			cursor.execute(sql,param)
			conn.commit()
	# read row into database
	# for row in range (excel.nrows):
	# 	for col in range (excel.ncols):
	# 		values =  row,excel.cell(row,col).value
	# 		param = (row,excel.cell(row,col).value)
	# 		sql = "insert into excel (row,value) values(%s,%s)"
	# 		cursor.execute(sql,param)
	# 		conn.commit()
	cursor.close()
	conn.close()

if __name__ == '__main__':
	# create index and obtain an worksheet orderly
	rfile = xlrd.open_workbook("test.xls")
	for index in range (0,2):
		excel = rfile.sheet_by_index(index)
		print excel
		# get_row_col(excel)
		read_excel_data_to_db()

