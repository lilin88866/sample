#!/usr/bin/perl  
# ��������һ��package�Ķ����Լ����� package.pl����������ű�
package package;#����Ҫ�������Ľṹ������

my $c;
sub add{
    my ($a,$b)=@_;
    $c=$a+$b;
    print "dev:$c...\n";
}
sub dev{
    my ($a,$b)=@_;
    $c=$a-$b;
    print "dev:$c...\n";
}


1   # ��仰�Ǳ����һ�仰����������package�ͻ����