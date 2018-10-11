#!/usr/bin/perl                                                                 
                                                                                                                                                            
                                                                                
# use strict;                                                                     
# use warnings;    

#将一些基数相加
# my $n = undef;
# my $sum = undef;
# print "$n\n";
while($n < 10){
print "n=$n;\nsum=$sum.\n ";
$sum += $n;
$n +=2;#下一个奇数
}
print "The total was $sum.$n.\n";