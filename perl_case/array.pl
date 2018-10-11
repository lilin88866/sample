#!/usr/bin/perl
#使用perl创建矩阵，并且对矩阵进行操作。

use Data::Dumper;
my @matrix;
my $array1="array1.txt";

open A1,"<$array1" or die;
my @array1=<A1>;
close A1;

my $lines;
for (my $i=0,$i < $array1,$i++)
{
    $lines = $array1[$i];
    print "i=$i\n";
    if ( $lines =~ /\s+?(\W.*)/ )
    {
        $mat_name = $1;
    } else {
        chomp($lines);
        my (@row) = split( /\s+/,$lines );
        print "lilinok$lines";
        push @$mat_name,\@row;
        # print dumper(\@$mat_name);
        # print "lilin : @$mat_name";
    }
}
