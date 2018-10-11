# python_list_tuple.py

L = [2,3,1,4]
L.sort()
print L

L.sort(reverse=True)
print L

L = [('b',6),('a',1),('c',3),('d',4)]
L.sort(key=lambda x:x[0]) 
print L
L.sort(key=lambda x:x[1]) 
print L
D=[3,6]

diff= list(set(L)^set(D))
print diff,"----"

print list(set(L).difference(set(D)))


L.append(var)  #追加元素
L.insert(index,var)
L.pop(var)   #返回最后一个元素，并从list中删除之
L.remove(var)  #删除第一次出现的该元素
L.count(var)  #该元素在列表中出现的个数
L.index(var)  #该元素的位置,无则抛异常 
L.extend(list) #追加list，即合并list到L上
L.sort()    #排序
L.reverse()   #倒序
list 操作符:,+,*，关键字del
a[1:]    #片段操作符，用于子list的提取
[1,2]+[3,4] #为[1,2,3,4]。同extend()
[2]*4    #为[2,2,2,2]
del L[1]  #删除指定下标的元素
del L[1:3] #删除指定下标范围的元素