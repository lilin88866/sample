# python_sort.py
print sorted({1: 'D', 2: 'B', 3: 'B', 4: 'E', 5: 'A'}) #[1, 2, 3, 4, 5]
print sorted("This is a test string from Andrew".split(), key=str.lower) #['a', 'Andrew', 'from', 'is', 'string', 'test', 'This']


student_tuples = [
        ('john', 'A', 15),
        ('jane', 'B', 12),
        ('dave', 'B', 10),
]

print sorted(student_tuples, key=lambda student: student[2])   # sort by age[('dave', 'B', 10), ('jane', 'B', 12), ('john', 'A', 15)] 

