#!/usr/bin/perl
#使用perl创建数组，并读取数组。

# my @pipe=(1,2,4,8);
my @pipe=("dl","ul","du");
print "@pipe\n";
my $pipeNum=scalar(@pipe);
print "$pipeNum\n";
for (my $i=0;$i<@pipe;$i++)
{
my $pipetyre=$pipe[$i];
print "$pipetyre\n";
}