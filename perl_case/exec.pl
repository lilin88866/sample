#!/usr/bin/perl -w
#ecec��system������
use strict;
use warnings;
#exec �÷�
# D:\works\perl_case>exec.pl

# D:\works\perl_case>The current date is: 2012/08/15 ����
# Enter the new date: (yy-mm-dd)
# D:\works\perl_case>

exec "date";#exec��cd��һ��·���£����᷵�ص�ԭ����perl��

#system�÷�
# D:\works\perl_case>exec.pl
# The current date is: 2012/08/15 ����
# Enter the new date: (yy-mm-dd)
system ("date");#systemֻ���ڸ�perl·����ִ�С�
