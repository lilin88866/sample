#!/usr/bin/perl -w
# argv ÓÃ·¨
use strict;
use warnings;
use IO::File;
eval {
if (!defined $ARGV[0])
{
	die "argv 0 shoud D:/works/perl_case";
}
};
if  ($@)
{
print $_;
}
my @funcs = &find_funcs(@ARGV);
print "funcs=@funcs\n";
sub find_funcs
{
	my @dir;
	my $dir_to_process = "D:/works/perl_case";
	opendir DH, $dir_to_process or die "Cannot open $dir_to_process: $!";
	foreach $_ (readdir DH) {
		print "one file in $dir_to_process is $_\n";
		push @dir,$_;
	}
	closedir DH;
	return @dir;	
}