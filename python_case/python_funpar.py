def funPar(a,b):
	connects=locals()
	for i in xrange(1,10):
		connects['a%s'%i] = i
	return a+b
def fun1(third,funPar,*par):
	return third+funPar(*par)
if __name__ == '__main__':
	print fun1(5,funPar,1,2)