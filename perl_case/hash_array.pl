#!/usr/bin/perl -w
#����һ���б�Ȼ����б�ŵ�һ�����飬Ȼ���ٰ���һ���б�ŵ�ǰһ���б��У�������һ���б�Ҳ��һ�����飻
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
#�����@array��
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
