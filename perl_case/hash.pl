#!/usr/bin/perl -w
#define hash
use strict;
use warnings;
use Cwd;
use IO::File;

my $fred_num = 0;
my $barney_num = 0;
my $dino_num = 0;
my $wilma = 0;

my %hashs = ("fred" => "fredss","barney" => "barney1","dino" => "dino1","wilma" => "wilma");
my @hashs ;
my %lilin;
my $hash_bak = \%hashs;
my $a= "ok";
$hashs{dony}=$a;
#push @%lilin,$a;
# print "lilin==${lilin{lilin}}\n";
print "$hashs{dony}\n";
print "ok\n";
# print "hash_bak==$hash_bak\n";
# print "hash_bak=$hash_bak->{dino}\n";
# print "$hashs{fred}\n";
# push @hashs,%hashs;
# print "arry ==@hashs\n";
# print " my name is $hashs{'fred'} \n";
for (my $i = 0; $i < @hashs ; $i++) 
{
	if ( $i eq 2) 
	{
		my $hash = $hashs[2];
		print "hash = $hash \n";
	}
}

my $miming = {"fred" => "fredss","barney" => "barney1","dino" => "dino1","wilma" => "wilma"};
# my %hashs = ("fred" => "fredss","barney" => "barney1","dino" => "dino1","wilma" => "wilma");
$miming->{person} = "lilin";
$hashs{tujun}="tj";
push @hashs,\$miming;
print "debug :$miming->{fred}\n";
print "hashs==@hashs\n";
# &list($miming,"a");

my $lilin =&list(\$miming);
print "lilin=$lilin \n";
sub list()
{
	my ($list,$a) = @_;
	my $value;
	my $shif=shift;
	# my $shift = %$shif;
	print "shif=$$list\n";
	foreach  $_ (values %$$list)
	{
		$value=$_;
		print "$_\n";
	}
	@$a=1;
	print "a==@$a\n";
	return $value;
}

