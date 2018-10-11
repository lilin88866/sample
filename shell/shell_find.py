# shell_find.py
  find
find pathname -options [-print -exec -ok]

find . -regex ".*\(\.txt\|\.pdf\)$"  基于正则表达式匹配文件路径


find . -type f -name "*.txt" -delete   删除当前目录下所有.txt文件


让我们来看看该命令的参数：
pathname find命令所查找的目录路径。例如用.来表示当前目录，用/来表示系统根目录。
-print find命令将匹配的文件输出到标准输出。
-exec find命令对匹配的文件执行该参数所给出的shell命令。相应命令的形式为'command' {} \;，注意{}和\；之间的空格，同时两个{}之间没有空格,
注意一定有分号结尾。
0) -ok 和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行
find . -name "datafile" -ctime -1 -exec ls -l {} \; 找到文件名为datafile*, 同时创建实际为1天之内的文件, 然后显示他们的明细.
find . -name "datafile" -ctime -1 -exec rm -f {} \; 找到文件名为datafile*, 同时创建实际为1天之内的文件, 然后删除他们.

find . -name "datafile" -ctime -1 -ok ls -l {} \; 这两个例子和上面的唯一区别就是-ok会在每个文件被执行命令时提示用户, 更加安全.
find . -name "datafile" -ctime -1 -ok rm -f {} \;

1) find . -name   基于文件名查找,但是文件名的大小写敏感.   
find . -name "datafile*"

2) find . -iname  基于文件名查找,但是文件名的大小写不敏感.
find . -iname "datafile*"

3) find . -maxdepth 2 -name fred 找出文件名为fred,其中find搜索的目录深度为2(距当前目录), 其中当前目录被视为第一层.

4) find . -perm 644 -maxdepth 3 -name "datafile*"  (表示权限为644的, 搜索的目录深度为3, 名字为datafile*的文件)

5) find . -path "./rw" -prune -o -name "datafile*" 列出所有不在./rw及其子目录下文件名为datafile*的文件。
find . -path "./dir*" 列出所有符合dir*的目录及其目录的文件.
find . \( -path "./d1" -o -path "./d2" \) -prune -o -name "datafile*" 列出所有不在./d1和d2及其子目录下文件名为datafile*的文件。

6) find . -user ydev 找出所有属主用户为ydev的文件。
find . ! -user ydev 找出所有属主用户不为ydev的文件， 注意!和-user之间的空格。

7) find . -nouser    找出所有没有属主用户的文件，换句话就是，主用户可能已经被删除。

8) find . -group ydev 找出所有属主用户组为ydev的文件。

9) find . -nogroup    找出所有没有属主用户组的文件，换句话就是，主用户组可能已经被删除。

10) find . -mtime -3[+3] 找出修改数据时间在3日之内[之外]的文件。
find . -mmin  -3[+3] 找出修改数据时间在3分钟之内[之外]的文件。
find . -atime -3[+3] 找出访问时间在3日之内[之外]的文件。
find . -amin  -3[+3] 找出访问时间在3分钟之内[之外]的文件。
find . -ctime -3[+3] 找出修改状态时间在3日之内[之外]的文件。
find . -cmin  -3[+3] 找出修改状态时间在3分钟之内[之外]的文件。

11) find . -newer eldest_file ! -newer newest_file 找出文件的更改时间 between eldest_file and newest_file。
find . -newer file     找出所有比file的更改时间更新的文件
find . ! -newer file 找出所有比file的更改时间更老的文件

12) find . -type d    找出文件类型为目录的文件。
find . ! -type d  找出文件类型为非目录的文件。
b - 块设备文件。
d - 目录。
c - 字符设备文件。
p - 管道文件。
l - 符号链接文件。
f - 普通文件。

13) find . -size [+/-]100[c/k/M/G] 表示文件的长度为等于[大于/小于]100块[字节/k/M/G]的文件。

14) find . -empty 查找所有的空文件或者空目录.

15) find . -type f | xargs grep "ABC"
使用xargs和-exec的区别是, -exec可能会为每个搜索出的file,启动一个新的进程执行-exec的操作, 而xargs都是在一个进程内完成, 效率更高.
