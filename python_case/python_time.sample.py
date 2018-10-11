import time,datetime
time.localtime()
print time.asctime(time.localtime())
print time.ctime(time.time())
# Wed Oct 26 16:45:08 2016
a="Jun 29 10:21:08 2017"
print time.mktime((datetime.datetime.strptime(a,'%b %d %H:%M:%S %Y')).timetuple())