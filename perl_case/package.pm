#!/usr/bin/perl  
# 怎样进行一个package的定义以及调用 package.pl调用了这个脚本
package package;#必须要有这样的结构。。。

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


1   # 这句话是必须的一句话，否则整个package就会出错