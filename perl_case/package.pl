#!/usr/bin/perl -w
#ʹ��һ���Լ������pm�ļ�
use strict;
use warnings;
use package;# �Լ������pm�ļ�Ҫ��use������


BEGIN                   #                                                        
{                                                                               
    push @INC, "./";    #     ��Щ��������������packageҪ�õ��ǵ�ǰĿ¼�µ�package��                                                  
                                                                                
};                      #

my $add=package1::add(3,1);
my $dev=package1::dev(3,1);
