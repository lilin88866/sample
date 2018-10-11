class A(object):
	"""docstring for A"""
	def __init__(self, arg):
		super(A, self).__init__()
		self.arg = arg
		self.__AA=3
		self.AA=4
C=A("B").AA
print C
B=A("B").__AA
print B

		