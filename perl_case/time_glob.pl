#!/usr/bin/perl -w
#����ʱ��������ʽ��
use strict;
use warnings;
my $time = gmtime;#��ȡ��ǰ��ʱ�䣺Wed Aug 15 05:25:56 2012
print "$time\n";
#localtime


my $timestamp = 1180630098;
my($sec, $min, $hour, $day, $mon, $year, $wday, $yday, $isdst)
= localtime $timestamp;
my $date = localtime;
print "$date\n"; #��ȡ��ǰʱ�䣺Wed Aug 15 13:29:33 2012

#stat
my $filename = undef;
my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size, $atime, $mtime, $ctime, $blksize, $blockes)
= stat;#����ǲ��Ե�
my $stat=stat;
print "$stat\n";
my @all_pl = glob "*.pl"; #glob�������÷���
my @all_file = glob "*"; #glob�������÷���ͬ�ڣ�@all_file =<*>;
print "@all_pl\n";