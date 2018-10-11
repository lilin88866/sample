# python_struct.py
import struct

bins=''.join(struct.pack("<I",int(dat,16)) for dat in ["abcdefff","abcdefff","abcdefff","abcdefff","abcdefff","abcdefff"])

print bins
with open("bins","w") as binhandle:
	binhandle.write(bins)

# bb=struct.unpack("ihb",bb)
# print bb
print ("*"*10)

a="llll.ooo"
b=a.split(".")[0]
print b
print str(tuple([1, u'TMSTD06_Mixed_UDconf2_4PIPE', 'pucchAckDtxTestResults.avgProcessingDelay.avgProcessingDelay.1.test', '7839.23809524', 'trunk']))
print int(7839.53809524)
print int("45365")

