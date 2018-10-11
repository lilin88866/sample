class ClassName:
	"""docstring for ClassName"""
	def __init__(self):
		pass
	def __protectFun(self):
		print "__ means this fun is __protectFun,"
		pass
	def callProtectFun(self):
		self.__protectFun()
		pass

class CallFun:
	"""docstring for CallFun"""
	def __init__(self,name="lilin"):
		print name,"__init__"
	def CallProtectFun(self):
		callClassName=ClassName()
		# callClassName.__protectFun() #this fun can not be called
		print "lilin"
		pass
if __name__ == '__main__':

	classCall=ClassName()
	classCall.callProtectFun()
	CallFun=CallFun()
	CallFun.CallProtectFun()
	for x in xrange(0,2):
		print x
					
		