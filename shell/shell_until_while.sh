# shell_until_while.sh
while循环：适用于循环次数未知的场景，要有退出条件
语法：
    while CONDITION; do
      statement
      ...
    done
    
计算100以内所有正整数的和

#!/bin/bash
declare -i I=1
declare -i SUM=0

while [ $I -le 100 ]; do
  let SUM+=$I
  let I++
done

echo $SUM

until 循环格式为：

until command
do
   Statement(s) to be executed until command is true
done

command 一般为条件表达式，如果返回值为 false，则继续执行循环体内的语句，否则跳出循环。