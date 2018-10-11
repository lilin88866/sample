# python_list.py
########################################################################
#list
# [expr for value in collection ifcondition]
########################################################################
lists = [[i,j] for i in range(3) for j in range(4)]
print lists

print [(x,y) for x in range(5) if x%2==0 for y in range(5) if y %2==1] 
print [name.upper() for name in  ['Bob','Tom','alice','Jerry','Wendy','Smith']  if len(name)>3]  

noprimes= [j for i in range(2, 5) for j in range(i*2, 3, i)]
print noprimes
print [x for x in range(2, 5) if x not in noprimes]


#########################################################################
# dict
# { key_expr: value_expr for value in collection if condition }
#########################################################################
strings = ['import','is','with','if','file','exception'] 
print  {key: val for val,key in enumerate(strings)} 


#########################################################################
#string if condition
#########################################################################
sentence = 'Your mother was a hamster'
vowels = 'aeiou'
nonvowels = ''.join([l for l in sentence if not l in vowels])
print nonvowels

#########################################################################
# dir file lists
#########################################################################
import os
files = [f for f in os.listdir('./') if f.endswith('.txt')]
print files
files = [os.path.join('./', f) for f in os.listdir('./') if f.endswith('.txt')]
print files

#########################################################################
# csv
#########################################################################
# import csv
# data = [ x for x in csv.DictReader(open('test.csv', 'rU'))]
