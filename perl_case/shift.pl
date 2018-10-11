#!/usr/bin/perl -w
#shift 在一个sub 函数func中的使用
# my @arr=undef;
# 这样写是不对的，实际上是初始化了一个仅包含undef元素的数组。即$arr[0]=undef.
# 此时用scalar(@arr)得到的数组长度为1.
# 初始化的时候不要用my @arr=‘’ ‘’;这样数组前面会有一个空格键。
# 正确的方法为：
# my @arr=();


# my @tcpath = ( "D:/branch_RL35/C_Test/MT/SS_RxReceiver1/TestCase","D:/branch_RL35/C_Test/MT/SS_RxReceiver2/TestCase" );
my @tcpath = ("SS_RxReceiver1", "SS_RxReceiver2");
 print "tcpath=@tcpath\n";
my $testsuit_arr = &search_testsuit_list(@tcpath);
sub search_testsuit_list
{
    my @tcpath = shift;  #shift 主要是用作对参数的使用放到$this或者$self中使用。
    print "tcpath=@tcpath\n";
    my @testsuit_list;
    my $file;
    my @search_range;
    for (my $i=0;$i<@tcpath;$i++)
    {
        print "$i\n";
        my $path_ny1 = $tcpath[$i]."/Nyquist1/TestCaseList";
        my $path_ny2 = $tcpath[$i]."/Nyquist2/TestCaseList";
        my $path_ny3 = $tcpath[$i]."/Nyquist3/TestCaseList";
        print "path_ny1=$path_ny1\n";
    }   
    return \@testsuit_list;
}