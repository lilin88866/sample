#!/usr/bin/perl -w
#利用plot函数老画图；
use strict;
use warnings;
my $subcase="subcase.txt";
my $ats_result="ats_result.txt";
my $res="result.txt";

# open RES,">$res" or die;
open SUBCASE,"<$subcase" or die;
open ATS,"<$ats_result"or die;
my @subcase=<SUBCASE>;
my @ats=<ATS>;
close ATS;

for (my $i=0;$i<@subcase;$i++)
{
    my $sbu_lines=$subcase[$i];
    my $atslines;
    for (my $j=0;$j<@ats;$j++)
    {
       $atslines=$ats[$j];
       if ($atslines=~/SubtestCaseResult: \w.*/) 
       {
            next;
       } else {
            print ATS "SubtestCaseResult: Fail";
       }
       if ($atslines=~/SubtestCaseReason: \w.*/)
       {
            next;
       } else {
            print ATS "SubtestCaseResult:$@";
       }
       if ($atslines=~/SubtestCaseTimeStamp: \d.*/)
       {
            next;
       } else {
            print ATS "SubtestCaseResult:time";
       }
        
    }

}

close SUBCASE;
close ATS;