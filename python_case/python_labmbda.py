# python_labmbda.py

# def square_root(x): return math.sqrt(x)==square_root = lambda x: math.sqrt(x)

# lambda par:expression

sum = lambda x, y:   x + y   #  def sum(x,y): return x + y
out = lambda   *x:   sys.stdout.write(" ".join(map(str,x)))
# lambda event, name=button8.getLabel(): self.onButton(event, name)

# python_lanbda.py

# lambda [arg1[,arg2,arg3....argN]]:expression(return value)
# lambda arg:return

def add(x,y):return x+y
add2 = lambda x,y:x+y
print add2(1,2)     #3


foo = [2, 18, 9, 22, 17, 24, 8, 12, 27]

print filter(lambda x: x % 3 == 0, foo) #[18, 9, 24, 12, 27]

print map(lambda x: x * 2 + 10, foo) #[14, 46, 28, 54, 44, 58, 26, 34, 64]