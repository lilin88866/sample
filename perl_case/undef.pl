#!/usr/bin/perl                                                                 
                                                                                                                                                            
                                                                                
# use strict;                                                                     
# use warnings;    

#��һЩ�������
# my $n = undef;
# my $sum = undef;
# print "$n\n";
while($n < 10){
print "n=$n;\nsum=$sum.\n ";
$sum += $n;
$n +=2;#��һ������
}
print "The total was $sum.$n.\n";