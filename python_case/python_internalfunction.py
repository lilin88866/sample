import gc,sys,random,datetime,os,glob,stat
print oct(10)
print range(10)
print sorted({"a":"1","c":"2","b":"3"})
print gc.get_count()
print sys.copyright,sys.argv,sys.exc_info(),sys.path
print random.random(),random.sample(range(20),5)

def amap(i):
	if i%2==0:
		i=i+1
		print i
		yield i

amap=map(amap, range(10))
areduce=reduce(amap, (4,))
# afilter=filter(amap, [1,2,3])
print amap,areduce
class withclass():
	"""docstring for withclass"""
	def __init__(self):
		print "__init__"
	def __exit__():
		print "__exit__"

	def withfun(self):
		for x in xrange(1,10):
			yield x
			# return x

# with withclass().withfun() as value:
# 	print value
string="asdf"
lnCelId=1
print "***********%s" %(type(lnCelId))
lnCelId=str(lnCelId) if type(lnCelId)==int else lnCelId
print "***********%s" %(type(lnCelId))
print "***********%s" %(type(string))
if type(1) ==int:
	print "ok"
print string.upper()
print "***********%s" %(type(string))
#format
print('#' * 40)
print('{0},I\'m {1},{message}'.format('Hello','Hongten',message = 'This is a test message!'))
print('I\'m {},{}'.format('Hongten','Welcome to my space!'))
print('#' * 40)
import math
print('The value of PI is approximately {}.'.format(math.pi))
print('The value of PI is approximately {!r}.'.format(math.pi))
print('The value of PI is approximately {0:.3f}.'.format(math.pi))

print datetime.date(1983,05,23),datetime.date.today(),datetime.time(23,59,59),datetime.time()

for x,y,z in [[1,2,3]]:
	print x,y,z


print os.getcwd(),os.chdir(os.getcwd()),os.getpid()
fd=open(".config","a")
print fd,os.stat(".config"),os.fstat(2)
print os.pipe()
print glob.glob("D:\*\C_Test\*\Libraries\*.pyc")
print os.path.split("D:\\BJ_TRUNK\\C_Test\\PHY_UL_Robot_TestENV\\Libraries\\BtsExceptions.pyc")
print os.path.splitext("D:\\BJ_TRUNK\\C_Test\\PHY_UL_Robot_TestENV\\Libraries\\BtsExceptions.pyc")

print os.stat("D:\\BJ_TRUNK\\C_Test\\PHY_UL_Robot_TestENV\\Libraries\\BtsExceptions.pyc")
# c=os.dup2(fd.fileno(),1)

# print "========",c
import string
print string.atoi("1267", 10)