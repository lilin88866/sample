 Python datetime模块的datetime类

datetime模块定义了下面这几个类：

datetime.date：表示日期的类。常用的属性有year, month, day.

datetime.time：表示时间的类。常用的属性有hour, minute, second, microsecond.

datetime.datetime：表示日期时间。

datetime.timedelta：表示时间间隔,即两个时间点之间的长度。

datetime.tzinfo：与时区有关的相关信息

 

datetime类

datetime是date与time的结合体,包括date与time的所有信息。

它的构造函数如下：datetime.datetime (year, month, day[ , hour[ , minute[ , second[ , microsecond[ , tzinfo]]]]] ),各参数的含义与date、time的构造函数中的一样,要注意参数值的范围。

datetime类定义的类属性与方法：

datetime.min、datetime.max：datetime所能表示的最小值与最大值；

datetime.resolution：datetime最小单位；

datetime.today()：返回一个表示当前本地时间的datetime对象；

datetime.now([tz])：返回一个表示当前本地时间的datetime对象,如果提供了参数tz,则获取tz参数所指时区的本地时间；

datetime.utcnow()：返回一个当前utc时间的datetime对象；

datetime.fromtimestamp(timestamp[, tz])：根据时间戮创建一个datetime对象,参数tz指定时区信息；

datetime.utcfromtimestamp(timestamp)：根据时间戮创建一个datetime对象；

datetime.combine(date, time)：根据date和time,创建一个datetime对象；

datetime.strptime(date_string, format)：将格式字符串转换为datetime对象；

使用例子：

from datetime import *
import time
>>> print 'datetime.max:', datetime.max
datetime.max: 9999-12-31 23:59:59.999999
>>> print 'datetime.min:', datetime.min
datetime.min: 0001-01-01 00:00:00
>>> print 'datetime.resolution:', datetime.resolution
datetime.resolution: 0:00:00.000001
>>> print 'today():', datetime.today()
today(): 2012-02-24 22:17:36.945862
>>> print 'now():', datetime.now()
now(): 2012-02-24 22:17:36.966896
>>> print 'utcnow():', datetime.utcnow()
utcnow(): 2012-02-24 14:17:36.976883

datetime类提供的实例方法与属性：

datetime.year、month、day、hour、minute、second、microsecond、tzinfo：datetime.date()：获取date对象；

datetime.time()：获取time对象；

datetime.replace ([ year[ , month[ , day[ , hour[ , minute[ , second[ , microsecond[ , tzinfo]]]]]]]] )：

datetime.timetuple()

datetime.utctimetuple()

datetime.toordinal()

datetime.weekday()

datetime.isocalendar()

datetime.isoformat ([ sep] )

datetime.ctime()：返回一个日期时间的C格式字符串,等效于time.ctime(time.mktime(dt.timetuple()))；

datetime.strftime(format)

像date一样,也可以对两个datetime对象进行比较,或者相减返回一个时间间隔对象,或者日期时间加上一个间隔返回一个新的日期时间对象。