#!/usr/bin/perl -w
#子函数的引用；
use strict;
use warnings;

my $sub_hello=&hello("lilin");
print "没有引用$sub_hello\n";
# D:\works\perl_case>use.pl
# lilin,ok,hello!
# 没有引用lilin

my $sub_hello=\&hello("lilin");
print "引用$sub_hello\n";
# D:\works\perl_case>use.pl
# lilin,ok,hello!
# 引用SCALAR(0x3dada4)

my $sub_hello=\&hello;
#没有任何输出！

my @array=qw/1 2 3/;
my $sub_hello=\&hello(\@array);
print "ok\n$sub_hello\n";
# REF(0x37ae64)
# ARRAY(0x321cfc),ok,hello!

my $sub_hello=\&hello(@array);
print "$sub_hello\n";
# SCALAR(0x3aaee4)
# 1,ok,hello!

my $sub_hello=&hello(@array);
print "$sub_hello\n";
# 1
# 1,ok,hello!

my $sub_hello=&hello(\@array);
print "ok\n$sub_hello\n";
# ARRAY(0x2c1cbc)
# 1,ok,hello!
sub hello
{
    my ($name)=@_;        #这里的子例程中使用传进来的参数要用()括起来的。
    print "$name,ok,hello!\n";
    return ($name);
}

my $anonimos=sub{
    print "ok,hello!\n";
};          #这里有一个分号！
print "匿名引用$anonimos\n";
#匿名引用CODE(0x2e420ec)