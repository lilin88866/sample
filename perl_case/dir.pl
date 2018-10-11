#!/usr/bin/perl -w
# opendir,readdir ÓÃ·¨

my $dir_to_process = "D:/works/perl_case";
opendir DH, $dir_to_process or die "Cannot open $dir_to_process: $!";
foreach $_ (readdir DH) {
	print "one file in $dir_to_process is $_\n";
}
closedir DH;