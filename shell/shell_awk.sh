awk:

1.用last取出登陆数据前五行
复制代码 代码如下:
last -n 5

取出账号与登陆者IP，且账号与IP之间以TAB隔开
复制代码 代码如下:
last -n 5 |awk '{print $1 "\t" $3}'

注:$1代表用空格或TAB隔开的第一个字段，以此类推。。
  $0代表该行全部字段
复制代码 代码如下:
last -n 5 |awk '{print $1 "\t lines:" NR "\t columes:" NF}'

注: NF代表每一行的$0的字段总数
   NR代表目前awk所处的是第几行数据
   FS代表目标分隔符，默认为空格

2.在/etc/passwd中以:来作为分段字符，则我们要查阅第三栏小于10以下的数据，并只列出账号与第三栏
复制代码 代码如下:
cat /etc/passwd | awk '{FS=":"} $3<10 {print $1 "\t \t"$3}'

注：查询结果未显示第一行数据，是因为我们虽然定义了FS=":" 但却只能在第二行生效
想读取第一行就需要BEGIN这个关键词:
复制代码 代码如下:
cat /etc/passwd | awk 'BEGIN {FS=":"} $3<10 {print $1 "\t \t"$3}'

df:
比较两个文件的差异:
复制代码 代码如下:
# diff /etc/rc3.d/ /etc/rc5.d/
-------------------
Only in /etc/rc3.d/: K30spice-vdagentd
Only in /etc/rc5.d/: S70spice-vdagentd
-------------------

实例：
1。统计TCP连接状态
复制代码 代码如下:
netstat -na | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
/^tcp/

过滤出以tcp开头的行，“^”为正则表达式用法，以...开头，这里是过滤出以tcp开头的行。
S[]
定义了一个名叫S的数组，在awk中，数组下标通常从 1 开始，而不是 0。
NF
当前记录里域个数，默认以空格分隔，如上所示的记录，NF域个数等于
$NF
表示一行的最后一个域的值，如上所示的记录，$NF也就是$6，表示第6个字段的值，也就是SYN_RECV或TIME_WAIT等。
S[$NF]
表示数组元素的值，如上所示的记录，就是S[TIME_WAIT]状态的连接数
++S[$NF]
表示把某个数加一，如上所示的记录，就是把S[TIME_WAIT]状态的连接数加一
结果就是显示S数组中最终的数组值
例：S[TIME_WAIT]=最终值 S[TESTABLISHED]=最终值
END
for(key in S)
遍历S[]数组
print key,”\t”,S[key]
打印数组的键和值，中间用\t制表符分割，显示好一些。



#7. ps命令输出所有进程的user和命令信息，将结果传递给sed命令，sed将删除ps的title部分。
#8. egrep过滤所有进程记录中，包含指定用户列表的进程记录，再将过滤后的结果传递给sort命令。
#9. sort命令中的-b选项将忽略前置空格，并以user，再以进程名排序，将结果传递个uniq命令。
#10.uniq命令将合并重复记录，-c选项将会使每条记录前加重复的行数。
#11.第二个sort将再做一次排序，先以user，再以重复计数由大到小，最后以进程名排序。将结果传给awk命令。
#12.awk命令将数据进行格式化，并删除重复的user。
ps -eo user,comm | sed -e 1d | egrep "$userlist" |
sort -b -k1,1 -k2,2 | uniq -c | sort -b -k2,2 -k1nr,1 -k3,3 |
awk ' { user = (lastuser == $2) ? " " : $2;
        lastuser = $2;
        printf("%-15s\t%2d\t%s\n",user,$1,$3)
}'