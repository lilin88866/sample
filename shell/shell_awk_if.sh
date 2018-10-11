##################################################################
# action

# { print $0; } # prints $0. In this case, equivalent to 'print' alone
# { exit; } # ends the program
# { next; } # skips to the next line of input
# { a=$1; b=$0 } # variable assignment
# { c[$1] = $2 } # variable assignment (array)

# { if (BOOLEAN) { ACTION }
# else if (BOOLEAN) { ACTION }
# else { ACTION }
# }
# { for (i=1; i<x; i++) { ACTION } }
# { for (item in c) { ACTION } }
###################################################################
# function() call
# { somecall($2) }
###################################################################

who| awk  '$3=="2017-05-02" {print $1,$2,$3}'
who| awk  '{if($3=="2017-05-02" && $1~/j.*/) print $1,$2,$3}'
ls -l | awk 'BEGIN {print "========================"} {($9~/(^u.*)/) print $9} END {print "------------------"}'
ls -l | awk 'BEGIN {print "========================"} {if($9~/(^u.*)/) print $9} END {print "------------------"}'

ls -l | awk 'BEGIN {print "========================"} {file=$9; if(file~/^u.*/) print file} END {print "------------------"}'
ls -l | awk 'BEGIN {print "========================"} {file=$9; if(file~/^u.*/) $10="change"; print file} END {print "------"}'

ls -l | awk 'BEGIN {"date" | getline  d; print d} {file=$9; if(file~/^u.*/) $10="change"; print file} END {print "------"}'
# awk '{array=["1","2","3"];For (element in ["1","2","3"] ) {print element}}' error