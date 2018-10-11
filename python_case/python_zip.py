a=[1,2,3,4]
b=[4,5,6,7]

print zip(a,b)    #[(1, 4), (2, 5), (3, 6), (4, 7)]

print zip(*zip(a,b))    #[(1, 2, 3, 4), (4, 5, 6, 7)]

print zip(*[iter(a)]*2)    #[(1, 2), (3, 4)]

print zip(*[iter(a[i:]) for i in range(3)])  #[(1, 2, 3), (2, 3, 4)]
for g in [iter(a[i:]) for i in range(3)]:
	print g.next()

a='0x12'
print int(a,0)
for index,x in enumerate(range(10)):
	print index,x

if "v" or "b" in ["a","b","c"]:
	print "ok"
else:
	print "nok"
teststr='0x000001db'
print int(teststr,0)