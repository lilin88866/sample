sed:

插入：

1.将/etc/passwd 的内容列出并打印行号，同时,将2-5行删除显示
复制代码 代码如下:
nl /etc/passwd | sed '2,5d'

注: sed是sed -e的简写, 后接单引号
同上删除第2行
复制代码 代码如下:
nl /etc/passwd | sed '2d'

同上删除第三行到最后一行
复制代码 代码如下:
nl /etc/passwd | sed '3,$d'

2.在第二行后加上一行test

复制代码 代码如下:
nl /etc/passwd | sed '2a test'

在第二行前加上一行test
复制代码 代码如下:
nl /etc/passwd | sed '2i test'

在第二行后加入两行test
复制代码 代码如下:
nl /etc/passwd | sed '2a test \> test'

替换行:

3.将2-5行内容取代为 No 2-5 number

复制代码 代码如下:
nl /etc/passwd | sed '2,5c No 2-5 number'

4 列出/etc/passwd 内第5-7行
复制代码 代码如下:
nl /etc/passwd |sed -n '5,7p'

替换字符串:

sed 's/被替换字符串/新字符串/g'

1.获取本机IP的行
复制代码 代码如下:
/sbin/ifconfig eth0 |grep 'inet addr'

将IP前面的部分予以删除
复制代码 代码如下:
/sbin/ifconfig eth0 |grep 'inet addr'| sed 's/^.*addr://g'

将IP后面的部分删除
复制代码 代码如下:
/sbin/ifconfig eth0 |grep 'inet addr'| sed 's/^.*addr://g'| sed 's/Bcast:.*$//g'
-------------------
192.168.100.74
-------------------

2.用grep将关键词MAN所在行取出来
复制代码 代码如下:
cat /etc/man.config |grep 'MAN'

删除批注行
复制代码 代码如下:
cat /etc/man.config |grep 'MAN'| sed 's/^#.*$//g'

删除空白行
复制代码 代码如下:
cat /etc/man.config |grep 'MAN'| sed 's/^#.*$//g'| sed '/^$/d'

3.利用sed将regular_express.txt内每一行若为.的换成!
注：-i参数会直接修改文本，而并非直接输出
复制代码 代码如下:
sed -i 's/.*\.$/\!/g' regular_express.txt

4.利用sed在文本最后一行加入 #This is a test
注: $代表最后一行 a代表行后添加
复制代码 代码如下:
sed -i '$a #This is a test' regular_express.txt

将selinux配置文件enforcing改成disabled
复制代码 代码如下:
sed -i '6,6c SELINUX=disabled' /etc/selinux/config

延伸正规表示法:
复制代码 代码如下:
grep -v '^$' regular_express.txt |grep -v '^#'

延伸写法:
复制代码 代码如下:
egrep -v '^$'|'^#' regular_express.txt

1. +表示重复一个或一个以上的前一个RE字符

例如：egrep -n 'go+d' regular_express.txt
普通写法: grep -n 'goo*d' regular_express.txt

2. ?表示重复零个或一个前一个RE字符

例如: egrep -n 'go?d' regular_express.txt

3. |表示用或的方式找出数个字符串

例如: egrep -n 'gd|good' regular_express.txt

4. ()表示找出群组字符串

例如: egrep -n 'g(la|oo)d' regular_express.txt
也就是搜寻(glad)或good这两个字符串

5. ()+多个重复群组判别

例如: echo 'AxyzxyzxyzxyzC'|egrep 'A(xyz)+C'

也就是要找开头是A结尾是C 中间有一个以上的'xyz'字符串的意思