#!/usr/bin/perl -w
#shift ��һ��sub ����func�е�ʹ��
# my @arr=undef;
# ����д�ǲ��Եģ�ʵ�����ǳ�ʼ����һ��������undefԪ�ص����顣��$arr[0]=undef.
# ��ʱ��scalar(@arr)�õ������鳤��Ϊ1.
# ��ʼ����ʱ��Ҫ��my @arr=���� ����;��������ǰ�����һ���ո����
# ��ȷ�ķ���Ϊ��
# my @arr=();


# my @tcpath = ( "D:/branch_RL35/C_Test/MT/SS_RxReceiver1/TestCase","D:/branch_RL35/C_Test/MT/SS_RxReceiver2/TestCase" );
my @tcpath = ("SS_RxReceiver1", "SS_RxReceiver2");
 print "tcpath=@tcpath\n";
my $testsuit_arr = &search_testsuit_list(@tcpath);
sub search_testsuit_list
{
    my @tcpath = shift;  #shift ��Ҫ�������Բ�����ʹ�÷ŵ�$this����$self��ʹ�á�
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