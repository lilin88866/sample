#!/usr/bin/perl -w
#各种时间的输出形式；
use strict;
use warnings;
my $time = gmtime;#获取当前的时间：Wed Aug 15 05:25:56 2012
print "$time\n";
#localtime


my $timestamp = 1180630098;
my($sec, $min, $hour, $day, $mon, $year, $wday, $yday, $isdst)
= localtime $timestamp;
my $date = localtime;
print "$date\n"; #获取当前时间：Wed Aug 15 13:29:33 2012

#stat
my $filename = undef;
my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size, $atime, $mtime, $ctime, $blksize, $blockes)
= stat;#这个是不对的
my $stat=stat;
print "$stat\n";
my @all_pl = glob "*.pl"; #glob函数的用法。
my @all_file = glob "*"; #glob函数的用法，同于：@all_file =<*>;
print "@all_pl\n";