# shell_tr.sh
tr [选项]… 集合1 [集合2]

选项说明：

-c, -C, –complement 用集合1中的字符串替换，要求字符集为ASCII。

-d, –delete 删除集合1中的字符而不是转换

-s, –squeeze-repeats 删除所有重复出现字符序列，只保留第一个；即将重复出现字符串压缩为一个字符串。

-t, –truncate-set1 先删除第一字符集较第二字符集多出的字符

字符集合的范围：

\NNN 八进制值的字符 NNN (1 to 3 为八进制值的字符)
\\ 反斜杠
\a Ctrl-G 铃声
\b Ctrl-H 退格符
\f Ctrl-L 走行换页
\n Ctrl-J 新行
\r Ctrl-M 回车
\t Ctrl-I tab键
\v Ctrl-X 水平制表符
CHAR1-CHAR2 从CHAR1 到 CHAR2的所有字符按照ASCII字符的顺序
[CHAR*] in SET2, copies of CHAR until length of SET1
[CHAR*REPEAT] REPEAT copies of CHAR, REPEAT octal if starting with 0
[:alnum:] 所有的字母和数字
[:alpha:] 所有字母
[:blank:] 水平制表符，空白等
[:cntrl:] 所有控制字符
[:digit:] 所有的数字
[:graph:] 所有可打印字符，不包括空格
[:lower:] 所有的小写字符
[:print:] 所有可打印字符，包括空格
[:punct:] 所有的标点字符
[:space:] 所有的横向或纵向的空白
[:upper:] 所有大写字母

tr（translate缩写）主要用于删除文件中的控制字符，或进行字符转换。
语法：tr [–c/d/s/t] [SET1] [SET2]
SET1: 字符集1
SET2：字符集2
-c:complement，用SET2替换SET1中没有包含的字符
-d:delete，删除SET1中所有的字符，不转换
-s: squeeze-repeats，压缩SET1中重复的字符
-t: truncate-set1，将SET1用SET2转换，一般缺省为-t
 
1、去除重复的字符
#将连续的几个相同字符压缩为一个字符
$ echo aaacccddd | tr -s [a-z]
acd
$ echo aaacccddd | tr -s [abc]
acddd
 
2、删除空白行
#删除空白行就是删除换行符/n
#注意：这些空白行上只有回车符，没有空格符
$ cat test.txt
I love linux!
                                                                                                                          
                                                                                                                          
Hello World!
                                                                                                                          
Shell is worthy to been studied
 
#这里用换行符的转义字符\n
#注意：此处用-s删除了多余的换行符，如果用-d，则会删除所有的换行符          



tr,用来从标准输入中通过替换/删除进行字符转换

主要用于删除文件中的控制字符或进行字符转换

 

使用时，提供两个字符串，串1：用于查询，串2：用于处理各种转换；串1的字符被映射到串2上，然后转换开始

 

主要用途：1.大小写转换

                    2.去除控制字符

                    3.删除字符

 

命令格式：

tr –c –d –s [“str_from”] [“str_to”] file

-c，用字符串1中字符集的补集替换此字符集，要求字符集为ASCII

-d，删除字符串1中所有输入字符串

-s，删除所有重复出现字符序列，只保留一个，即重复字符串压缩为一个

 

字符范围——tr，可以指定字符串列表或范围作为形成字符串的模式，似正则，但不是正则。

[a-z] [A-Z] [0-9]    /octal一个三位八进制数，对应有效ＡＳＣＩＩ字符

[s*n]字符s出现n次

 

tr 中特定字符的不同表达方式

/a
	

Ctrl-g铃声
	

/007

/b
	

Ctrl-h退格
	

/010

/f
	

Ctrl-l走纸模式
	

/014

/n
	

Ctrl-J新行
	

/012

/r
	

Ctrl-M回车
	

/015

/t
	

Ctrl-I tab键
	

/011

/v
	

Ctrl-x
	

/030

 

 

1.       去除所有重复字符【只保留一个】

$tr –s “[a-z]” < oops.txt

2.       去除空行

$tr –s “[/012]” <oops.txt

$tr –s “[/n]” <oops.txt

3.       小写转大写

$echo “AbcdefG” | tr “[a-z]” “[A-Z]”

$echo “AbcdefG” | tr “[:lower:]” “[:upper:]”

4.       删除指定字符串

$tr –cs “[a-z][A-Z]” “[/012*]” < data.txt

将非字母字符转为新行  -s压缩重复的字符

5.       转换控制字符

$tr –s “[/136]” “[/011*]” < start.txt

6.       快速转换

$tr –s “[/r]” “[/n]” < input.txt

7.       匹配多于一个字符

$tr “[0*4]” “*”< input.txt
