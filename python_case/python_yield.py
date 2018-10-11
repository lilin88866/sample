#python_yield.py
import re
lst=[1,2,3,4,5]
# yield must used in function and the function returned as list
# for i in lst:
#     yield 3
    # print i

def gen():
	for i in open("ECL"):
		if re.match("ECL_PDDB",i):
			yield i

print gen().next()
b=gen().close()
# print b.send("hijo")
for i in gen():
        if i.endswith("LNT3.0_PDDB_RADIO_1301_001_00"):
        	print "endswith %s" %(i)
        elif i.startswith("ECL_PDDB_FDD"):
        	print "startswith %s" %(i)
        else:
        	print "not endswith %s" %(i)

# try:
# 	open("eecl")
# except Exception, e:
# 	raise
# else:
# 	print "ok"
# finally:
# 	print "it's ok"


	

