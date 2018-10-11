def listParam(name):
	print "listParam",name[0],name[1]

# asterrisk(*) collect the rest of param
def asterriskCollectRestParam(num,*other,**hash):
	print "num",num
	print "*other",other
	print "**hash",hash
# global

def globalvarcall():
	global globalvar
	globalvar = globalvar + "hi"
	pass

if __name__ == '__main__':
	name = ["li","lin"]
	listParam(name)
	asterriskCollectRestParam(1,2,3,4,first="lilin",last="li")
	globalvar = "nihao"
	globalvarcall()
	print "globalvarcall:",globalvar