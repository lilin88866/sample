#!/usr/bin/perl -w
#定义一个列表，然后把列表放到一个数组，然后再把另一个列表放到前一个列表中，其中另一个列表也是一个数组；
use strict;
use warnings;
use Data::Dumper;
my @array;
my $array;
my $hash={hash1 => "hash1",hash2 => "hash2",hash5=>[]};
my $subhash={subhash1 => "subhash11",subhash2 => "subhash2",subhash5 => []};
push @array,$hash;
push @{$hash->{hash5}},$subhash;
print Dumper(\@array);
#输出的@array。
# $VAR1 = [
          # {
            # 'hash2' => 'hash2',
            # 'hash5' => [
                         # {
                           # 'subhash5' => [],
                           # 'subhash2' => 'subhash2',
                           # 'subhash1' => 'subhash11'
                         # }
                       # ],
            # 'hash1' => 'hash1'
          # }
        # ];

print Dumper(\@{$array->{hash5}});
push @{$array->{hash5}}, $subhash;
print Dumper(\@{$array->{hash5}});

# $VAR1 = [];
# $VAR1 = [
          # {
            # 'subhash5' => [],
            # 'subhash2' => 'subhash2',
            # 'subhash1' => 'subhash11'
          # }
        # ];

for (my $i=0; $i < @{$hash->{hash5}} ; $i++)
{
	
	my $lilin=values $hash->{subhash1};
	print "lilin==$lilin\n";
}
