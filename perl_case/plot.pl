#!/usr/bin/perl -w
#利用plot函数老画图；
use strict;
use warnings;

my $pi=3.14;
my $r=5;
my $round=$pi*$r;
plot ($round,0,2*$pi,0.01);