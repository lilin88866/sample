#!/usr/bin/perl -w
#define hash
use strict;
use warnings;
use Cwd;
use IO::File;
my $cmd = "eavl.txt";
my $fh = new IO::File;
eval {
$fh->open($cmd) or die "Could not open file $cmd";
};
if ($@) {
print "$@\n";
} #当命令出现错误的时候perl不会自动退出还会继续执行下边的程序，然后将错误的信息放在$@里边去。
