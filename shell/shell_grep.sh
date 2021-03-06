   1.  grep退出状态：
    0: 表示成功；
    1: 表示在所提供的文件无法找到匹配的pattern；
    2: 表示参数中提供的文件不存在。
    见如下示例：
    /> grep 'root' /etc/passwd
    root:x:0:0:root:/root:/bin/bash
    operator:x:11:0:operator:/root:/sbin/nologin
    /> echo $?
    0
    
    /> grep 'root1' /etc/passwd  #用户root1并不存在
    /> echo $?
    1
    
    /> grep 'root' /etc/passwd1  #这里的/etc/passwd1文件并不存在
    grep: /etc/passwd1: No such file or directory
    /> echo $?
    2
    
   2.  grep中应用正则表达式的实例：
    需要说明的是下面所涉及的正则表达式在上一篇中已经给出了详细的说明，因此在看下面例子的时候，可以与前一篇的正则说明部分结合着看。
    /> cat testfile
    northwest        NW      Charles Main           3.0     .98     3       34
    western           WE       Sharon Gray          5.3     .97     5       23
    southwest       SW       Lewis Dalsass         2.7     .8       2       18
    southern         SO       Suan Chin               5.1     .95     4       15
    southeast       SE        Patricia Hemenway    4.0     .7       4       17
    eastern           EA        TB Savage              4.4     .84     5       20
    northeast        NE        AM Main Jr.              5.1     .94     3       13
    north              NO       Margot Weber          4.5     .89     5       9
    central            CT        Ann Stephens          5.7     .94     5       13

   
    /> grep NW testfile     #打印出testfile中所有包含NW的行。
    northwest       NW      Charles Main        3.0     .98     3       34
    
    /> grep '^n' testfile   #打印出以n开头的行。
    northwest       NW      Charles Main        3.0     .98     3       34
    northeast        NE       AM Main Jr.          5.1     .94     3       13
    north              NO      Margot Weber      4.5     .89     5       9
    
    /> grep '4$' testfile   #打印出以4结尾的行。
    northwest       NW      Charles Main        3.0     .98     3       34
    
    /> grep '5\..' testfile #打印出第一个字符是5，后面跟着一个.字符，再后面是任意字符的行。
    western         WE      Sharon Gray         5.3     .97     5       23
    southern        SO      Suan Chin             5.1     .95     4       15
    northeast       NE      AM Main Jr.            5.1     .94     3       13
    central           CT      Ann Stephens        5.7     .94     5       13
    
    /> grep '\.5' testfile  #打印出所有包含.5的行。
    north           NO      Margot Weber        4.5     .89     5       9

    /> grep '^[we]' testfile #打印出所有以w或e开头的行。
    western         WE      Sharon Gray         5.3     .97     5       23
    eastern          EA      TB Savage            4.4     .84     5       20
    
    /> grep '[^0-9]' testfile #打印出所有不是以0-9开头的行。
    northwest       NW     Charles Main             3.0     .98      3       34
    western          WE      Sharon Gray             5.3     .97     5       23
    southwest       SW     Lewis Dalsass           2.7     .8       2       18
    southern         SO      Suan Chin                5.1     .95     4       15
    southeast        SE      Patricia Hemenway     4.0     .7      4       17
    eastern           EA      TB Savage                4.4     .84     5       20
    northeast        NE      AM Main Jr.                5.1     .94     3       13
    north              NO      Margot Weber           4.5     .89     5       9
    central            CT      Ann Stephens            5.7     .94     5       13

    /> grep '[A-Z][A-Z] [A-Z]' testfile #打印出所有包含前两个字符是大写字符，后面紧跟一个空格及一个大写字母的行。
    eastern          EA      TB Savage       4.4     .84     5       20
    northeast       NE      AM Main Jr.      5.1     .94     3       13
    注：在执行以上命令时，如果不能得到预期的结果，即grep忽略了大小写，导致这一问题的原因很可能是当前环境的本地化的设置问题。对于以上命令，如果我将当前语言设置为en_US的时候，它会打印出所有的行，当我将其修改为中文环境时，就能得到我现在的输出了。
    /> export LANG=zh_CN  #设置当前的语言环境为中文。
    /> export LANG=en_US  #设置当前的语言环境为美国。
    /> export LANG=en_Br  #设置当前的语言环境为英国。
    
    /> grep '[a-z]\{9\}' testfile #打印所有包含每个字符串至少有9个连续小写字符的字符串的行。
    northwest        NW      Charles Main          3.0     .98     3       34
    southwest       SW      Lewis Dalsass         2.7     .8       2       18
    southeast        SE      Patricia Hemenway   4.0     .7       4       17
    northeast        NE      AM Main Jr.              5.1     .94     3       13
    
    #第一个字符是3，紧跟着一个句点，然后是任意一个数字，然后是任意个任意字符，然后又是一个3，然后是制表符，然后又是一个3，需要说明的是，下面正则中的\1表示\(3\)。
    /> grep '\(3\)\.[0-9].*\1    *\1' testfile
    northwest       NW      Charles Main        3.0     .98     3       34
    
    /> grep '\<north' testfile    #打印所有以north开头的单词的行。
    northwest       NW      Charles Main          3.0     .98     3       34
    northeast        NE       AM Main Jr.            5.1     .94     3       13
    north              NO      Margot Weber        4.5     .89     5       9
    
    /> grep '\<north\>' testfile  #打印所有包含单词north的行。
    north           NO      Margot Weber        4.5     .89     5       9
    
    /> grep '^n\w*' testfile      #第一个字符是n，后面是任意字母或者数字。
    northwest       NW     Charles Main          3.0     .98     3       34
    northeast        NE      AM Main Jr.            5.1     .94     3       13
    north             NO      Margot Weber        4.5     .89     5       9
    
    3.  扩展grep(grep -E 或者 egrep)：
    使用扩展grep的主要好处是增加了额外的正则表达式元字符集。下面我们还是继续使用实例来演示扩展grep。
    /> egrep 'NW|EA' testfile     #打印所有包含NW或EA的行。如果不是使用egrep，而是grep，将不会有结果查出。
    northwest       NW      Charles Main        3.0     .98     3       34
    eastern         EA      TB Savage           4.4     .84     5       20
    
    /> grep 'NW\|EA' testfile     #对于标准grep，如果在扩展元字符前面加\，grep会自动启用扩展选项-E。
    northwest       NW      Charles Main        3.0     .98     3       34
    eastern           EA       TB Savage           4.4     .84     5       20
    
    /> egrep '3+' testfile
    /> grep -E '3+' testfile
    /> grep '3\+' testfile        #这3条命令将会打印出相同的结果，即所有包含一个或多个3的行。
    northwest       NW      Charles Main         3.0     .98     3       34
    western          WE      Sharon Gray         5.3     .97     5       23
    northeast        NE       AM Main Jr.           5.1     .94     3       13
    central            CT       Ann Stephens       5.7     .94     5       13
    
    /> egrep '2\.?[0-9]' testfile
    /> grep -E '2\.?[0-9]' testfile
    /> grep '2\.\?[0-9]' testfile #首先含有2字符，其后紧跟着0个或1个点，后面再是0和9之间的数字。
    western         WE       Sharon Gray          5.3     .97     5       23
    southwest      SW      Lewis Dalsass         2.7     .8      2       18
    eastern          EA       TB Savage             4.4     .84     5       20
    
    /> egrep '(no)+' testfile
    /> grep -E '(no)+' testfile
    /> grep '\(no\)\+' testfile   #3个命令返回相同结果，即打印一个或者多个连续的no的行。
    northwest       NW      Charles Main        3.0     .98     3       34
    northeast        NE       AM Main Jr.          5.1     .94     3       13
    north              NO      Margot Weber      4.5     .89     5       9
    
    /> grep -E '\w+\W+[ABC]' testfile #首先是一个或者多个字母，紧跟着一个或者多个非字母数字，最后一个是ABC中的一个。
    northwest       NW     Charles Main       3.0     .98     3       34
    southern        SO      Suan Chin           5.1     .95     4       15
    northeast       NE      AM Main Jr.          5.1     .94     3       13
    central           CT      Ann Stephens      5.7     .94     5       13
    
    /> egrep '[Ss](h|u)' testfile
    /> grep -E '[Ss](h|u)' testfile
    /> grep '[Ss]\(h\|u\)' testfile   #3个命令返回相同结果，即以S或s开头，紧跟着h或者u的行。
    western         WE      Sharon Gray       5.3     .97     5       23
    southern        SO      Suan Chin          5.1     .95     4       15
    
    /> egrep 'w(es)t.*\1' testfile    #west开头，其中es为\1的值，后面紧跟着任意数量的任意字符，最后还有一个es出现在该行。
    northwest       NW      Charles Main        3.0     .98     3       34
   

    4.  grep选项：
    这里先列出grep常用的命令行选项：
选项 	说明
-c 	只显示有多少行匹配，而不具体显示匹配的行。
-h 	不显示文件名。
-i 	在字符串比较的时候忽略大小写。
-l 	只显示包含匹配模板的行的文件名清单。
-L 	只显示不包含匹配模板的行的文件名清单。
-n 	在每一行前面打印该行在文件中的行数。
-v 	反向检索，只显示不匹配的行。
-w 	只显示完整单词的匹配。
-x 	只显示完整行的匹配。
-r/-R 	如果文件参数是目录，该选项将递归搜索该目录下的所有子目录和文件。

    /> grep -n '^south' testfile  #-n选项在每一个匹配行的前面打印行号。
    3:southwest     SW      Lewis Dalsass         2.7     .8      2       18
    4:southern       SO      Suan Chin               5.1     .95     4       15
    5:southeast      SE      Patricia Hemenway    4.0     .7      4       17

    /> grep -i 'pat' testfile     #-i选项关闭了大小写敏感。
    southeast       SE      Patricia Hemenway       4.0     .7      4       17

    /> grep -v 'Suan Chin' testfile #打印所有不包含Suan Chin的行。
    northwest       NW      Charles Main          3.0     .98     3       34
    western          WE      Sharon Gray           5.3     .97    5       23
    southwest       SW      Lewis Dalsass        2.7     .8      2       18
    southeast        SE      Patricia Hemenway   4.0     .7      4       17
    eastern           EA      TB Savage              4.4     .84     5       20
    northeast        NE      AM Main Jr.             5.1     .94     3       13
    north              NO      Margot Weber        4.5     .89     5       9
    central            CT      Ann Stephens         5.7     .94     5       13

    /> grep -l 'ss' testfile  #-l使得grep只打印匹配的文件名，而不打印匹配的行。
    testfile

    /> grep -c 'west' testfile #-c使得grep只打印有多少匹配模板的行。
    3

    /> grep -w 'north' testfile #-w只打印整个单词匹配的行。
    north           NO      Margot Weber    4.5     .89     5       9

    /> grep -C 2 Patricia testfile #打印匹配行及其上下各两行。
    southwest      SW     Lewis Dalsass         2.7     .8       2       18
    southern        SO      Suan Chin              5.1     .95     4       15
    southeast       SE      Patricia Hemenway   4.0     .7      4       17
    eastern          EA      TB Savage              4.4     .84     5       20
    northeast       NE      AM Main Jr.             5.1     .94     3       13

    /> grep -B 2 Patricia testfile #打印匹配行及其前两行。
    southwest      SW      Lewis Dalsass         2.7     .8      2       18
    southern        SO      Suan Chin               5.1     .95    4       15
    southeast       SE      Patricia Hemenway   4.0     .7      4       17

    /> grep -A 2 Patricia testfile #打印匹配行及其后两行。
    southeast       SE      Patricia Hemenway   4.0     .7      4       17
    eastern           EA      TB Savage              4.4     .84     5       20
    northeast       NE       AM Main Jr.             5.1     .94     3       13