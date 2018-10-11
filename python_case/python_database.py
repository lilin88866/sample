# python_database.py
database_host="10.97.125.163"
database_username="root"
database_password="root"
database_db="big_testline"

def databaseConnect(self):
	conn = testReportDb.connect(database_host,database_username,database_password,database_db,connect_timeout=10)
	cur  = conn.cursor()
	return cur,conn


cur,conn=databaseConnect()

sql="INSERT ulphy_pronto_info (Problem_Report_ID,Problem_ID,Title,RD_Information,PR_Reported_Date,Week_of_PR_Reported_Date,Year_Month_of_PR_Reported_Date,State,Group_In_Charge,Author_Group,Severity,SW_Build,`Release`,Product,From_Electra,Reported_by,Discovered,Type,Priority,TOP_Importance,Customer,Feature,insertDay) values ("+str(lists).replace("u\"","\"").replace("u'","'").strip("[|]")+")"
print sql
cur.execute(sql)
conn.commit()
cur.close()
conn.close()

sql = "select Problem_Report_ID,Problem_ID,Title,`Release`,State,PR_Reported_Date,TOP_Importance, datediff(insertDay, PR_Reported_Date) as difday ,RD_Information from ulphy_pronto_info where `State` in ('New','Investigating','First Correction Complete','First Correction Ready For Testing') and `Release`='"+Release+"' and insertDay='"+currentDay+"' order by `Release` "
# print sql
cur.execute(sql)
values=cur.fetchall()