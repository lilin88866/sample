# coding=gb2312
# -*- coding: gb2312 -*-
print 李林
import MySQLdb
import time
conn=MySQLdb.connect(host="127.0.0.1",user="root",passwd="1",db="lilin",charset="utf8")
cursor = conn.cursor()

# create
cursor.execute("create table test(name char(20),age int)")

# describe
cursor.execute("describe test")
print cursor.fetchall()

# param and %s
sql = "insert into test (name,age) values(%s,%s)" 
param = ('li',90)
cursor.execute(sql,param)
conn.commit()

# insert
cursor.execute("insert into test (name,age) values('p',2)")

# update
cursor.execute("update test set name='q' where name='p'")
conn.commit()

#select
cursor.execute("select * from test")
cursor.fetchone()
for row in cursor.fetchall():
    print row
    # (u'q', 2L)
#select param %s
select_sql = "select test.name,test.age from test where test.age=%s"
select_param = (2)
cursor.execute(select_sql,select_param)
print cursor.fetchall() #((u'q', 2L),) tuple
for row in cursor.fetchall():
    print row[0]
    print row[-1]
    print row
    # q
    # 2
    # (u'q', 2L) tuple( , )


# delete
cursor.execute("delete from test where name='q'")

# alter
cursor.execute("alter table test drop column name")
conn.commit()

#drop
cursor.execute("drop table test")
conn.commit()
cursor.close()
conn.close()

print tuple('abc') #('a', 'b', 'c')
print list('abc')  #['a', 'b', 'c']

print tuple(['abc'])#('abc',)
print list(['abc']) #['abc']

copy = tuple('abc')
print copy  #('a', 'b', 'c')