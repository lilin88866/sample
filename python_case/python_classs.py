class humen(object):
    def __init__(self,name,eye=2,age=None):
        self.name = name
        self.eye = eye
        self.age = age
        print ini humen self.name,self.eye,self.age

    def action(self):
        print "%s has %u eye,and %u years old" %(self.name,self.eye,self.age)

class father(humen):
    def action(self):
        print "this is %s,a father" %(self.name)

class son(father):
    def action(self):
        print "this is %s,a son" %self.name
def actiont(hm):
    return hm.action()

def main():
    one = humen("one",2,20)
    tom = father('tom')
    david = son('david')
    actiont(one)
    actiont(tom)
    actiont(david)
if __name__ == '__main__':
    main()