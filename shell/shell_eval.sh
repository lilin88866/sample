# shell_eval.sh
var=name  
res=`eval echo '$'"$var"`
echo ${res}

echo $(eval cat 'a.sh')