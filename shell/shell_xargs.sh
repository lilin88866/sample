# shell_xargs.sh

# xargs命令是给其他命令传递参数的一个过滤器，也是组合多个命令的一个工具。
# 它擅长将标准输入数据转换成命令行参数，xargs能够处理管道或者stdin并将其转换成特定命令的命令参数。
# xargs也可以将单行或多行文本输入转换为其他格式，例如多行变单行，单行变多行。xargs的默认命令是echo，空格是默认定界符。
# 这意味着通过管道传递给xargs的输入将会包含换行和空白，不过通过xargs的处理，换行和空白将被空格取代。xargs是构建单行命令的重要组件之一。



1、多行变成单行
#******************************************************
-bash-3.2# cat test.txt

a b c d e f

g o p q

-bash-3.2# cat test.txt |xargs

# a b c d e f g o p q

 

 

2、单行变成多行
#******************************************************
-bash-3.2# cat test.txt

a b c d e f g o p q

-bash-3.2# cat test.txt |xargs -n 2

# a b

# c d

# e f

# g o

# p q

 

 

3、删除某个重复的字符来做定界符
#**********************************************
-bash-3.2# cat test.txt

Aaaagttttgyyyygcccc

-bash-3.2# cat test.txt |xargs -d g

# aaaa tttt yyyy cccc

 

 

4、删除某个重复的字符来做定界符后，变成多行
#**********************************************************************
-bash-3.2# cat test.txt |xargs -d g -n 2

# aaaa tttt

# yyyy cccc

 

5、用find找出文件以txt后缀，并使用xargs将这些文件删除
#********************************************************************************
-bash-3.2# find /root/ -name "*.txt" -print        #查找

# /root/2.txt

# /root/1.txt

# /root/3.txt

# /root/4.txt

-bash-3.2# find /root/ -name "*.txt" -print0 |xargs -0 rm -rf   #查找并删除

-bash-3.2# find /root/ -name "*.txt" -print          #再次查找没有

 

 

6、查找普通文件中包括thxy这个单词的

-bash-3.2# find /root/ -type f -print |xargs grep "thxy"

# /root/1.doc:thxy

 

 

7、查找权限为644的文件，并使用xargs给所有加上x权限

-bash-3.2# find /root/ -perm 644 -print

# /root/1.c

# /root/5.c

# /root/2.doc

# /root/3.doc

# /root/1.doc

# /root/2.c

# /root/4.doc

# /root/4.c

# /root/3.c

-bash-3.2# find /root/ -perm 644 -print|xargs chmod a+x

-bash-3.2# find /root/ -perm 755 -print

# /root/1.c

# /root/5.c

# /root/2.doc

# /root/3.doc

# /root/1.doc

# /root/2.c

# /root/4.doc

# /root/4.c

# /root/3.c

8、ps -ef|grep LOCAL=NO|grep -v grep|cut -c 9-15|xargs kill -9

运行这条命令将会杀掉所有含有关键字"LOCAL=NO"的进程:

管道符"|"用来隔开两个命令，管道符左边命令的输出会作为管道符右边命令的输入。

"ps -ef" 是linux里查看所有进程的命令。这时检索出的进程将作为下一条命令"grep LOCAL=NO"的输入。

"grep LOCAL=NO" 的输出结果是，所有含有关键字"LOCAL=NO"的进程。

"grep -v grep" 是在列出的进程中去除含有关键字"grep"的进程。

"cut -c 9-15" 是截取输入行的第9个字符到第15个字符，而这正好是进程号PID。

"xargs kill -9" 中的 xargs 命令是用来把前面命令的输出结果（PID）作为"kill -9"命令的参数，并执行该命令。"kill -9"会强行杀掉指定进程。

其它类似的情况，只需要修改"grep LOCAL=NO"中的关键字部分就可以了。

另一种方法，使用awk

ps x|grep gas|grep -v grep |awk '{print $1}'|xargs kill -9

另：

xargs 与find 命令合用的时候，find 把匹配到得命令传递给xargs ,xargs 每次只获取一部分文件，而不是全部。分批处理。

xargs则只有一个进程、但xargs 处理是否分批 ，批次大小，也会受系统些可调参数影响。