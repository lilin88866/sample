class baseClass(object):
	def init(self):
		self.name="baseClass"
		print "baseClass"
	def baseClassFun(self):
		self.init()
		print self.name
class childClass(baseClass):
	def init(self):
		self.name="childClass"
		print "childClass",self.name

if __name__ == '__main__':
	call=childClass()
	call.init()
	call.baseClassFun()
	bclass = baseClass()
	bclass.baseClassFun()
		
	
		