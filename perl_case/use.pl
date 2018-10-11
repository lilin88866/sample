#!/usr/bin/perl -w
#�Ӻ��������ã�
use strict;
use warnings;

my $sub_hello=&hello("lilin");
print "û������$sub_hello\n";
# D:\works\perl_case>use.pl
# lilin,ok,hello!
# û������lilin

my $sub_hello=\&hello("lilin");
print "����$sub_hello\n";
# D:\works\perl_case>use.pl
# lilin,ok,hello!
# ����SCALAR(0x3dada4)

my $sub_hello=\&hello;
#û���κ������

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
    my ($name)=@_;        #�������������ʹ�ô������Ĳ���Ҫ��()�������ġ�
    print "$name,ok,hello!\n";
    return ($name);
}

my $anonimos=sub{
    print "ok,hello!\n";
};          #������һ���ֺţ�
print "��������$anonimos\n";
#��������CODE(0x2e420ec)