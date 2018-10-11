#!/usr/bin/ksh

#数字段形式
for i in {1..10}
do
   echo $i
done

#详细列出（字符且项数不多）
for File in 1 2 3 4 5
do
    echo $File
done

#对存在的文件进行循环
for shname in `ls *.sh`
do
          name=`echo "$shname" | awk -F. '{print $1}'`          
          echo $name
done

#查找循环（ls数据量太大的时候也可以用这种方法）
for shname in `find . -type f -name "*.sh"`
do
          name=`echo "$shname" | awk -F/ '{print $2}'`         
          echo $name
done

#((语法循环--有点像C语法，但记得双括号
for((i=1;i<100;i++))
do
    if((i%3==0))
    then
        echo $i
        continue
    fi
done

#seq形式 起始从1开始
for i in `seq 100`
do
    if((i%3==0))
    then
        echo $i
        continue
    fi
done

#while循环注意为方括号[],且注意空格
min=1
max=100
while [ $min -le $max ]
do
    echo $min
    min=`expr $min + 1`
done  

#双括号形式，内部结构有点像C的语法，注意赋值：i=$(($i+1))
i=1
while(($i<100))
do
    if(($i%4==0))
    then
        echo $i
    fi
    i=$(($i+1))
done

#从配置文件读取，并可以控制进程数量
MAX_RUN_NUM=8
cat cfg/res_card_partition.cfg |grep -v '^$'|grep -v "#" | grep -v grep |while read partition
do       
                nohup sh inv_res_card_process.sh $partition >log/resCard$partition.log 2>&1 &              
                while [ 1 -eq 1 ]
                do
                                psNum=`ps -ef | grep "inv_res_card_process" | grep -v "grep" | wc -l`
                                if [ $psNum -ge $MAX_RUN_NUM ]
                                then
                                              sleep 5
                                else
                                              break
                                 fi                                       
                done               
done


# 三.循环控制语句
# break 命令不执行当前循环体内break下面的语句从当前循环退出.
# continue 命令是程序在本循体内忽略下面的语句,从循环头开始执行

将单列显示转换为多列显示
#*******************************************************************************************************************
#1. passwd文件中，有可能在一行内出现一个或者多个空格字符，因此在直接使用cat命令的结果时，for循环会被空格字符切开，从而导致一行的文本被当做多次for循环的输入，这样我们不得不在sed命令中，将cat输出的每行文本进行全局替换，将空格字符替换为%20。事实上，我们当然可以将cat /etc/passwd的输出以管道的形式传递给cut命令，这里之所以这样写，主要是为了演示一旦出现类似的问题该如果巧妙的处理。
#2. 这里将for循环的输出以管道的形式传递给sort命令，sort命令将基于user排序。
#3. -xargs -n 2是这个技巧的重点，它将sort的输出进行合并，-n选项后面的数字参数将提示xargs命令将多少次输出合并为一次输出，并传递给其后面的命令。在本例中，xargs会将从sort得到的每两行数据合并为一行，中间用空格符分离，之后再将合并后的数据传递给后面的awk命令。事实上，对于awk而言，你也可以简单的认为xargs减少了对它(awk)的一半调用。
#4. 如果打算在一行内显示3行或更多的行，可以将-n后面的数字修改为3或其它更高的数字。你还可以修改awk中的print命令，使用更为复杂打印输出命令，以得到更为可读的输出效果。
for line in `cat /etc/passwd | sed 's/ /%20/g'`
do
    user=`echo $line | cut -d: -f1`
    echo $user
done | \
    sort -k1,1 | \
    xargs -n 2 | \
    awk '{print $1, $2}'
#*******************************************************************************************************************

将文件的输出格式化为指定的宽度
#************************************************************************************************************************
#1. 这里我们将缺省宽度设置为75，如果超过该宽度，将考虑折行显示，否则直接在一行中全部打印输出。这里只是为了演示方便，事实上，你完全可以将该值作为脚本或函数的参数传入，那样你将会得到更高的灵活性。    
my_width=75
#2. for循环的读取列表来自于脚本的参数。
#3. 在获取lines和chars变量时，sed命令用于过滤掉多余的空格字符。
#4. 在if的条件判断中${#line}用于获取line变量的字符长度，这是Shell内置的规则。
#5. fmt -w 80命令会将echo输出的整行数据根据其命令选项指定的宽度(80个字符)进行折行显示，再将折行后的数据以多行的形式传递给sed命令。
#6. sed在收到fmt命令的格式化输出后，将会在折行后的第一行头部添加两个空格，在其余行的头部添加一个加号和一个空格以表示差别。
for input; do
    lines=`wc -l < $input | sed 's/ //g'`
    chars=`wc -c < $input | sed 's/ //g'`
    owner=`ls -l $input | awk '{print $3}'`
    echo "-------------------------------------------------------------------------------"
    echo "File $input ($lines lines, $chars characters, owned by $owner):"
    echo "-------------------------------------------------------------------------------"
    while read line; do
        if [ ${#line} -gt $my_width ]; then
            echo "$line" | fmt -w 80 | sed -e '1s/^/  /' -e '2,$s/^/+ /'
        else
            echo "  $line"
        fi
    done < $input
    echo "-------------------------------------------------------------------------------"
done | more

#***********************************************************************************************************************


监控指定目录下磁盘使用空间过大的用户
#****************************************************************************************************************************
 #1. 该脚本仅用于演示一种处理技巧，其中很多阈值都是可以通过脚本参来初始化的，如limited_qutoa和dirs等变量。
limited_quota=200
dirs="/home /usr /var"
#2. 以冒号作为分隔符，截取passwd文件的第一和第三字段，然后将输出传递给awk命令。
#3. awk中的$2表示的是uid，其中1-99是系统保留用户，>=100的uid才是我们自己创建的用户，awk通过print输出所有的用户名给for循环。
#4. 注意echo命令的输出是由八个单词构成，同时由于-n选项，echo命令并不输出换行符。
#5. 之所以使用find命令，也是为了考虑以点(DOT)开头的隐藏文件。这里的find将在指定目录列表内，搜索指定用户的，类型为普通文件的文件。并通过-ls选项输出找到文件的详细信息。其中输出的详细信息的第七列为文件大小列。
#6. 通过awk命令累加find输出的第七列，最后再在自己的END块中将sum的值用MB计算并输出。该命令的输出将会与上面echo命令的输出合并作为for循环的输出传递给后面的awk命令。这里需要指出的是，该awk的输出就是后面awk命令的$9，因为echo仅仅输出的8个单词。
#7. 从for循环管道获取数据的awk命令，由于awk命令执行的动作是用双引号括起的，所以表示域字段的变量的前缀$符号，需要用\进行转义。变量$limited_quota变量将会自动完成命令替换，从而构成该awk命令的最终动作参数。
for name in `cut -d: -f1,3 /etc/passwd | awk -F: '$2 > 99 {print $1}'`
do
    echo -n "User $name exceeds disk quota. Disk Usage is: "
    find $dirs -user $name -type f -ls |\
          awk '{ sum += $7 } END { print sum / (1024*1024) " MB" }'
done | awk "\$9 > $limited_quota { print \$0 }"
#************************************************************************************************************************



