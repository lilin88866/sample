# python_os_path.py
import os

# walk()函数的语法结构：

#         [ (当前目录列表），（子目录列表），（文件列表）]os.walk(树状结构文件夹名称）

#         os.walk()返回一个由3个tuple类型的元素组成的列表。
#         索引值为0的表元素是文件夹名称，据此可以知道当前在处理的文件夹是哪一个。
#         索引值为1的表元素是下一层文件夹列表，用来了解在此文件夹中还有几个下层文件夹，分别叫什么名字。
#         索引值为2的元素是本文件夹内所有的文件列表，列出此文件夹中所有的文件名。
#         由返回值的列表数据，组合出所有往下的树状目录结构的内容。
print os.walk(os.getcwd())
print[os.path.join(root,file) for root,dirs,files in os.walk(os.getcwd()) for file in files]
