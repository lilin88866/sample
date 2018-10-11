# shell_tr_sample.sh
echo aaacccddd | tr -s [a-z]
acd
echo aaacccddd | tr -s [abc]
acddd

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