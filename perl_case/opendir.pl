#!/usr/bin/perl -w
#读出某个路径下的文件名；
use strict;
use warnings;

my $dir_to_process = "D:/branch_RL35";
opendir DH, $dir_to_process or die "Cannot open $dir_to_process: $!";
foreach my $file(readdir DH) {
print "One file in $dir_to_process is $file\n";
}
closedir DH;
