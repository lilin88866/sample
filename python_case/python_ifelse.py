# python_ifelse.py
# d<a?a:c 
a=3
b=4
c=5
d=6
d= d<a and a or c
print d
d=6
d= a if d<a else c
print d

d=6
d= d<a and a+d or c+d
print d

d=6
d= d<a & a+d | c+d
print d
b=str(1)
f=[]
f.append(0)
a={b:f}
print a