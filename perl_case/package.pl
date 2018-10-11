#!/usr/bin/perl -w
#使用一个自己定义的pm文件
use strict;
use warnings;
use package;# 自己定义的pm文件要用use声明。


BEGIN                   #                                                        
{                                                                               
    push @INC, "./";    #     这些是用来进行声明package要用的是当前目录下的package。                                                  
                                                                                
};                      #

my $add=package1::add(3,1);
my $dev=package1::dev(3,1);
