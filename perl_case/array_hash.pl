#!/usr/bin/perl
#ʹ��perl�������󣬲��ҶԾ�����в�����

use Data::Dumper;
my $teacher = {name=>lipin,age=>sh,lesson=>shuxue,stu=>[]};
my $student = {name=>liuming,age=>six};
push @{$teacher->{stu}},$student;
# print Dumper(\$teacher);
my $a=1;
my $b=2;
*b=*a;
print "$b";