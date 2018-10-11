#！/bin/bash  
name=yushuang  
var=name  
res=`eval echo '$'"$var"`
echo ${res}
res=$(eval echo '$'"$var")
echo $res
work_dir=`pwd`

work_dir=`echo $work_dir | sed 's/\//_/g'`
file_count=`ls | wc -l`

echo "work_dir = " $work_dir
echo "file_count = " $file_count

eval echo "BASE${work_dir}_$file_count = " '$BASE'${work_dir}_$file_count


