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
} #��������ִ����ʱ��perl�����Զ��˳��������ִ���±ߵĳ���Ȼ�󽫴������Ϣ����$@���ȥ��
