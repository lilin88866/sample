import xmllib
# have something wrong
class Parser(xmllib.XMLParser):
	def __init__(self, file=None):
		xmllib.XMLParser.__init__(self)
		if file:
			a=self.load(file)
			print a
	def load(self, file):
		while 1:
			s = file.read()
			if not s:
				break
			
		aa=self.feed(s)
		print aa
		# self.close()
	def start_quotation(self, attrs):
		print "id =>", attrs.get("id")
		raise EOFError
try:
	c = Parser()
	c.load(open("TL16_PHY_RX_0000_000157_000000.xml"))
except EOFError:
	pass
