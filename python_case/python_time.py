

    # 在Python中，通常有这几种方式来表示时间：
    # 1）时间戳 
    # 2）格式化的时间字符串 
    # 3）元组（struct_time）共九个元素。由于Python的time模块实现主要调用C库，所以各个平台可能有所不同。
    # # UTC（Coordinated Universal Time，世界协调时）亦即格林威治天文时间，世界标准时间。在中国为UTC+8。DST（Daylight Saving Time）即夏令时。
    # 时间戳（timestamp）的方式：通常来说，时间戳表示的是从1970年1月1日00:00:00开始按秒计算的偏移量。我们运行“type(time.time())”，返回的是float类型。返回时间戳方式的函数主要有time()，clock()等。
    # 元组（struct_time）方式：struct_time元组共有9个元素，返回struct_time的函数主要有gmtime()，localtime()，strptime()。下面列出这种方式元组中的几个元素：


a="2016-11-11 16:36:03.741"
b='2016-11-11 16:36:03.639'
import time
timeArray = time.strptime(a, "%Y-%m-%d %H:%M:%S.%f")
print timeArray
timeArray2= time.strptime(b, "%Y-%m-%d %H:%M:%S.%f")
print time.mktime(timeArray),time.mktime(timeArray2),time.mktime(timeArray2)-time.mktime(timeArray)

print time.time()#1491987396.87
print time.localtime()#time.struct_time(tm_year=2017, tm_mon=4, tm_mday=12, tm_hour=16, tm_min=57, tm_sec=15, tm_wday=2, tm_yday=102, tm_isdst=0)
print time.strftime("%Y-%d-%H",time.localtime())

import time

# 生成timestamp
time.time()
# 1477471508.05
#struct_time to timestamp
time.mktime(time.localtime())

#生成struct_time
# timestamp to struct_time 本地时间
time.localtime()
time.localtime(time.time())
# time.struct_time(tm_year=2016, tm_mon=10, tm_mday=26, tm_hour=16, tm_min=45, tm_sec=8, tm_wday=2, tm_yday=300, tm_isdst=0)

# timestamp to struct_time 格林威治时间
time.gmtime()
time.gmtime(time.time())
# time.struct_time(tm_year=2016, tm_mon=10, tm_mday=26, tm_hour=8, tm_min=45, tm_sec=8, tm_wday=2, tm_yday=300, tm_isdst=0)

#format_time to struct_time
time.strptime('2011-05-05 16:37:06', '%Y-%m-%d %X')
# time.struct_time(tm_year=2011, tm_mon=5, tm_mday=5, tm_hour=16, tm_min=37, tm_sec=6, tm_wday=3, tm_yday=125, tm_isdst=-1)

#生成format_time
#struct_time to format_time
time.strftime("%Y-%m-%d %X")
time.strftime("%Y-%m-%d %X",time.localtime())
# 2016-10-26 16:48:41


#生成固定格式的时间表示格式
time.asctime(time.localtime())
time.ctime(time.time())
# Wed Oct 26 16:45:08 2016