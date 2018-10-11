#!/usr/bin/perl -w
#ecec与system的区别；
use strict;
use warnings;
#exec 用法
# D:\works\perl_case>exec.pl

# D:\works\perl_case>The current date is: 2012/08/15 周三
# Enter the new date: (yy-mm-dd)
# D:\works\perl_case>

exec "date";#exec会cd到一个路径下，不会返回到原来的perl中

#system用法
# D:\works\perl_case>exec.pl
# The current date is: 2012/08/15 周三
# Enter the new date: (yy-mm-dd)
system ("date");#system只会在该perl路径下执行。
