#!/usr/bin/perl -w
#����ĳ��·���µ��ļ�����
use strict;
use warnings;

my $dir_to_process = "D:/branch_RL35";
opendir DH, $dir_to_process or die "Cannot open $dir_to_process: $!";
foreach my $file(readdir DH) {
print "One file in $dir_to_process is $file\n";
}
closedir DH;
