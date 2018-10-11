class Classself(object):
	"""docstring for Classself"""
	def __init__(self):
		self.arg = "arg"
		self.called_by_class_self_var = {
		"lilin":2,
		"linde":3
		}
	def function(self):
		print "lilin"
	def call_function(self):
		self.function()
		self.__privateFun()
		self._otherFunCanNotCall.name
	def __privateFun(self):
		print "private can not call from class extenal"
	def _otherFunCanNotCall(self):
		name="lilin"
		print "_otherFunCanNotCall can not call from class extenal"	,name
if __name__ == '__main__':
	ClassNameObj=Classself()
	ClassNameObj.call_function()
	# ClassNameObj.__privateFun()
	ClassNameObj._otherFunCanNotCall()