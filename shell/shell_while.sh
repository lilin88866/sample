# shell_while.sh
#1. 先将ls -l命令的结果通过管道传给grep命令作为管道输入。
#2. grep命令过滤掉包含total的行，之后再通过管道将数据传给while循环。
#3. while read line命令从grep的输出中读取数据。注意，while是管道的最后一个命令，将在子Shell中运行。
ls -l | grep -v total | while read line
do
  #4. all变量是在while块内声明并赋值的。
  all="$all $line"
  echo $line
done

#5. 由于上面的all变量在while内声明并初始化，而while内的命令都是在子Shell中运行，包括all变量的赋值，因此该变量的值将不会传递到while块外，因为块外地命令是它的父Shell中执行。


#1. 这里我们已经将命令的结果重定向到一个临时文件中。
ls -l | grep -v total > outfile
while read line
do
  #2. all变量是在while块内声明并赋值的。
  all="$all $line"
  echo $line
  #3. 通过重定向输入的方式，将临时文件中的内容传递给while循环。
done < outfile
#4. 删除该临时文件。
rm -f outfile
#5. 在while块内声明和赋值的all变量，其值在循环外部仍然有效。
echo "all = " $all

 #1. 将命令的结果传给一个变量    
OUTFILE=`ls -l | grep -v total`
while read line
do
  all="$all $line"
  echo $line
done <<EOF
#2. 将该变量作为该循环的HERE文档输入。
$OUTFILE
EOF
#3. 在循环外部输出循环内声明并初始化的变量all的值。
echo "all = " $all




