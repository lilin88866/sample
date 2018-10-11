class Base(object):
	def __init__(self):
		print 'Base create'
class childA(Base):
	def __init__(self):
		print 'creat A ',
		super(Base, self).__init__()
		print 'leave A '
class childB(Base):
	def __init__(self):
		print 'creat B ',
		super(Base, self).__init__()
		print 'leave b'
class childC(childA, childB):
	def __init__(self):
  		print "creat c",
  		super(childB,self).__init__()
  		print "leave c"
 
    class parent1(object):  
        def __init__(self):  
            print 'is parent1'  
            print 'goes parent1'  
      
    class parent2(object):  
        def __init__(self):  
            print 'is parent2'  
            print 'goes parent2'  
      
    class child1(parent1):  
        def __init__(self):  
            print'is child1'  
            parent.__init__(self)  
            print 'goes child1'  
      
    class child2 (parent1) :  
        def __init__(self):  
            print 'is child2'  
            parent.__init__(self)  
            print 'goes child2'  
      
    class child3(parent2):  
        def __init__(self):  
            print 'is child3'  
            parent2.__init__(self)  
            print 'goes child3'  
      
    class grandson(child3,child2,child1):  
        def __init__(self):  
            print 'is grandson'  
            child1.__init__(self)  
            child2.__init__(self)  
            child3.__init__(self)  
            print'goes grandson'  
      
      
    if __name__=='__main__':  
        grandson()  
if __name__ == '__main__':
	print "nihao"
	# base = Base()
	a = childA()
	b = childB()
	c = childC()