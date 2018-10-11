#!/usr/bin/perl -w

########################################################################################
#
# Divide report as regression/unstable/newfeature three type
# Combine MT 2/4/8 SCT 2/4/8 report
#
# Parameter:  [type]: MT or SCT
#             [antenna]: 1 or 2 or 4 or 8 or ALL
#
# reverse('?'),  May 2011, Zhou Ting
#

use strict;
use POSIX qw/strftime/;
use Cwd;
use IO::File;

if(!defined $ARGV[0] || $ARGV[0] !~ /SCT/)
{
    die "First parameter should be SCT.\n";
}

our $testtype = $ARGV[0];

if(!defined $ARGV[1] || ($ARGV[1] !~ /1/ && $ARGV[1] !~ /2/ && $ARGV[1] !~ /4/ && $ARGV[1] !~ /8/ && $ARGV[1] !~ /ALL/))
{
    die "Second parameter should be 1 or 2 or 4 or 8 or ALL.\n";
}

our $antenna = $ARGV[1];

if(!defined $ARGV[2])
{
    die "Second parameter should be 2/3/4 .\n";
}

our $dsp_num = $ARGV[2];

our $report = $testtype." ".$antenna."PIPE";
our $label = $testtype.$antenna;

print "$testtype, $antenna, $dsp_num\n";
our $directory = &getcwd;

my $currentWeek = &GetCurrentWK;
print "$currentWeek\n";
our $grep = "C:\\cygwin\\bin\\grep.exe";
our $sed = "C:\\cygwin\\bin\\sed.exe";
our $awk = "C:\\cygwin\\bin\\gawk.exe";

our $sumtxt = "SCT".$antenna."PIPE.txt";
open (SCTPOOL, ">$sumtxt") or die "could not open $sumtxt for writing!";

our $notrun = "NOTRUN".$antenna."PIPE.txt";
open (NOTRUN, ">$notrun") or die "could not open $notrun for writing!";

our $test_result = "test_result.txt";
my $total = 0;
my $pass = 0;
my $failed = 0;
my $nottest = 0;

my $reg_file = "reg_".$testtype."_".$antenna."PIPE.txt";
my $nef_file = "nef_".$testtype."_".$antenna."PIPE.txt";
unlink $reg_file;
unlink $nef_file;
my $case_file = "case.txt";
open (CASE, $case_file) or die "Could not open file $case_file for writing: !#";
foreach(<CASE>)
{
    $_ =~ s/\r//g;  
	if ($dsp_num != 2)	
	{
		next if ($_ =~ /.*2DSP.*/i);
	}
    chomp $_; 
	my @col = split(/\t/,$_);
	my $len = @col;
	my $id = $col[0];
	my $case = $col[1];
    $case =~ s/ //g;
    my $pipe = $col[2];
	my $pools = $col[3];
	my $type = $col[4];
	my $owner = $col[5];
	my $story = $col[6];
	my $index = 7;
    for($index; $index < $len - 1; $index++)
	{
		$story = $story.=" $col[$index]";
	}
	my $plan = $col[-1];
	next if ($type !~ /$testtype/);
	next if ($pipe ne $antenna && $antenna ne "ALL");
	&CreateSUMFile($case, $pipe, $pools, $testtype, $owner, $story, $plan);
}

close NOTRUN;
close SCTPOOL;

our $notregis = "NOTREGIS".$antenna."PIPE.txt";
open (NOTREGIS, ">$notregis") or die "could not open $notregis for writing!";

my $reportfile = "summary_".$testtype."_".$antenna."PIPE.txt";
open(RUN,$reportfile) or die "Could not open file $reportfile: !#";
foreach(<RUN>){
    $_ =~ s/\r//g;                                                                     
    chomp $_; 
	my @col = split(/,/,$_);
    my $name = $col[0];
	my $exist = `$grep -w '$name' $sumtxt`;
	if (!defined $exist || $exist eq "")
	{
	    print NOTREGIS "$col[0],$col[1],$col[2],$col[3],$col[4],$col[5],$col[6],$col[7],$col[8]\n";
	}
}
close RUN;
close NOTREGIS;

our $sumhtml = "summary.html";

&PrintHtml;

open (TEST_RES, ">$test_result")  or die "could not open $test_result for writing!";
print TEST_RES "result=Total:$total;Pass:$pass;Fail:$failed;NoRun:$nottest.\n";
if ($total == $pass)
{
    print TEST_RES "[Result]:all passed!\n";
}
else
{
    print TEST_RES "[Result]:test failed!\n";
}

close TEST_RES;

sub CreateSUMFile
{
   my ($casename, $pipe, $pooltype, $testtype, $owner, $story, $plan) = @_;
   my ($result) = &GetCaseInfo($casename, $pipe, $testtype);
   if ($result eq "-\t-\t-\t-\t-\t-\t-\tNotTest" && $pooltype ne "NewFeature")
	{
		print NOTRUN "$story\t$casename\t$pooltype\t$owner\t$plan\n";
	}
	else
	{
		if ($dsp_num == 2)
		{
			if($casename =~ /.*2DSP.*/i){
			print SCTPOOL "$story\t$casename\t$result\t$pooltype\t$owner\t$plan\n";
			} else {
			next;
			}
		} else {
			print SCTPOOL "$story\t$casename\t$result\t$pooltype\t$owner\t$plan\n";
		}
	}
}


sub GetCaseInfo
{
    my ($case, $pipe, $testtype) = @_;
    
    my $result;
	
	my ($pusch, $pucch, $prach, $srs, $calibration, $cell, $reason, $tests);
    
    my $report_file = "summary_".$testtype."_".$pipe."pipe.txt";

    $pusch = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$2}'`;
	if (!defined $pusch || $pusch eq "")
	{
	    $result = "-\t-\t-\t-\t-\t-\t-\tNotTest";
		return $result;
	}
	$pucch = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$3}'`;
	$prach = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$4}'`;
	$srs = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$5}'`;
	$calibration = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$6}'`;
    $cell = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$7}'`;
	$reason = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$8}'`;
	$tests = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$9}'`;
	
	$result = "$pusch\t$pucch\t$prach\t$srs\t$calibration\t$cell\t$reason\t$tests";
    return $result;
}

sub PrintHtml
{
    our $sumtxt;
	
	my $totalregression = 0;
	my $passregression = 0;
	my $failregression = 0;
	my $notestregression = 0;
	my $passregression_percentage = 0;
	my $failregression_percentage = 0;
	my $notestregression_percentage = 0;
	my $totalunstable = 0;
	my $passunstable = 0;
	my $failunstable = 0;
	my $notestunstable = 0;
	my $passunstable_percentage = 0;
	my $failunstable_percentage = 0;
	my $notestunstable_percentage = 0;
	my $totalnewfeature = 0;
	my $passnewfeature = 0;
	my $failnewfeature = 0;
	my $notestnewfeature = 0;
	my $passnewfeature_percentage = 0;
	my $failnewfeature_percentage = 0;
	my $notestnewfeature_percentage = 0;
	
	$totalregression = `$grep -c '\tRegression' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$passregression = `$grep -c 'PASS\tRegression' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$failregression = `$grep -c 'FAIL\tRegression' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$notestregression = `$grep -c 'NotTest\tRegression' $sumtxt | $awk -F: '{printf \$1}'`;
	
    $total = $total + $totalregression;
    $pass = $pass + $passregression;
    $failed = $failed + $failregression;
    $nottest = $nottest + $notestregression;
    
	if ($totalregression == 0)
	{
	    $passregression_percentage = 100;
		$failregression_percentage = 0;
        $notestregression_percentage = 0;
	}
	else
	{
	    $passregression_percentage = $passregression/$totalregression*100;
	    $failregression_percentage = $failregression/$totalregression*100-0.1;
		$notestregression_percentage = $notestregression/$totalregression*100-0.1;
	}
		
	$totalunstable = `$grep -c '\tUnstable' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$passunstable = `$grep -c 'PASS\tUnstable' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$failunstable = `$grep -c 'FAIL\tUnstable' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$notestunstable = `$grep -c 'NotTest\tUnstable' $sumtxt | $awk -F: '{printf \$1}'`;
	
    $total = $total + $totalunstable;
    $pass = $pass + $passunstable;
    $failed = $failed + $failunstable;
    $nottest = $nottest + $notestunstable;
    
	if ($totalunstable == 0)
	{
	    $passunstable_percentage = 100;
	    $failunstable_percentage = 0;
	    $notestunstable_percentage = 0;
	}
	else
	{
	    $passunstable_percentage = $passunstable/$totalunstable*100;
	    $failunstable_percentage = $failunstable/$totalunstable*100-0.01;
	    $notestunstable_percentage = $notestunstable/$totalunstable*100-0.01;
	}
	
	$totalnewfeature = `$grep -c '\tNewFeature' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$passnewfeature = `$grep -c 'PASS\tNewFeature' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$failnewfeature = `$grep -c 'FAIL\tNewFeature' $sumtxt | $awk -F: '{printf \$1}'`;
	
	$notestnewfeature = `$grep -c 'NotTest\tNewFeature' $sumtxt | $awk -F: '{printf \$1}'`;

    $total = $total + $totalnewfeature;
    $pass = $pass + $passnewfeature;
    $failed = $failed + $failnewfeature;
    $nottest = $nottest + $notestnewfeature;
    
	if ($totalnewfeature == 0)
	{
	    $passnewfeature_percentage = 100;
	    $failnewfeature_percentage = 0;
	    $notestnewfeature_percentage = 0;
	}
	else
	{
	    $passnewfeature_percentage = $passnewfeature/$totalnewfeature*100;
	    $failnewfeature_percentage = $failnewfeature/$totalnewfeature*100-0.01;
	    $notestnewfeature_percentage = $notestnewfeature/$totalnewfeature*100-0.01;
	}
	if (($totalregression - $passregression) > 0 )
	{
	    open (FAIL, ">fail.txt") or die "Could not open fail.txt for writing!";
		print FAIL " ";
	}
	elsif (($totalunstable - $passunstable) > 0 )
	{
		open (FAIL, ">fail.txt") or die "Could not open fail.txt for writing!";
		print FAIL " ";
	}
	elsif (($failregression + $failunstable + $failnewfeature) > 0 )
	{
		open (FAIL, ">fail.txt") or die "Could not open fail.txt for writing!";
		print FAIL " ";
	}		
			
	open (SUM, ">$sumhtml") or die "Could not open $sumhtml for writing: $!";
	print SUM "<HTML>\n";
	print SUM "<HEAD></HEAD>\n";
	print SUM "<BODY>\n";
	
	print SUM "<h4><a name=\"$label\"><FONT size=6 color=\"#000000\" face=\"arial\"><B>$report Report</B></FONT></a></h4>\n";
	
	print SUM "<TABLE border=\"1\" cellspacing=\"0\" cellpadding=\"4\" style=\"border: 1px solid black; border-collapse: collapse;empty-cells: show;margin: 0px 1px; \">\n";
	print SUM "<TR bgcolor=\"#C6C6C6\">\n";
	print SUM "<TH style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">Pool</TH>\n";
	print SUM "<TH style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">Total</TH>\n";
	print SUM "<TH style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">Pass</TH>\n";
	print SUM "<TH style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">Fail</TH>\n";
	print SUM "<TH style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">Not Test</TH>\n";
	print SUM "<TH style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">Percentage</TH>\n";
	print SUM "<TH style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">Graph</TH>\n";
	print SUM "</TR>\n";
	print SUM "<TR>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\"><FONT color=\"#191970\"><B>Regression</B></FONT></TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$totalregression</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$passregression</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$failregression</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$notestregression</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$passregression_percentage%</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">\n";
	print SUM "<div style=\"position: relative;border: 1px solid black;width: 11em;height: 0.75em;padding: 0px;background: #E9E9E9;\">\n";
	print SUM "<b style=\"width: $passregression_percentage%; background: #00f000;\" title=\"$passregression_percentage%\"></b>\n";
	print SUM "<b style=\"width: $failregression_percentage%; background: red;\" title=\"$failregression_percentage%\"></b>\n";
	print SUM "<b style=\"width: $notestregression_percentage%;background: #808080;\" title=\"$notestregression_percentage%\"></b>\n";
	print SUM "</div>\n";
	print SUM "</TD>\n";
	print SUM "</TR>\n";
	print SUM "<TR>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\"><FONT color=\"#191970\"><B>Unstable</B></FONT></TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$totalunstable</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$passunstable</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$failunstable</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$notestunstable</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$passunstable_percentage%</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">\n";
	print SUM "<div style=\"position: relative;border: 1px solid black;width: 11em;height: 0.75em;padding: 0px;background: #E9E9E9;\">\n";
	print SUM "<b style=\"width: $passunstable_percentage%; background: #00f000;\" title=\"$passunstable_percentage%\"></b>\n";
	print SUM "<b style=\"width: $failunstable_percentage%;background: red;\" title=\"$failunstable_percentage%\"></b>\n";
	print SUM "<b style=\"width: $notestunstable_percentage%;background: #808080;\" title=\"$notestunstable_percentage%\"></b>\n";
	print SUM "</div>\n";
	print SUM "</TD>\n";
	print SUM "</TR>\n";
	print SUM "<TR>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\"><FONT color=\"#191970\"><B>New Feature</B></FONT></TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$totalnewfeature</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$passnewfeature</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$failnewfeature</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$notestnewfeature</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;text-align: center;\">$passnewfeature_percentage%</TD>\n";
	print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">\n";
	print SUM "<div style=\"position: relative;border: 1px solid black;width: 11em;height: 0.75em;padding: 0px;background: #E9E9E9;\">\n";
	print SUM "<b style=\"width: $passnewfeature_percentage%; background: #00f000;\" title=\"$passnewfeature_percentage%\"></b>\n";
	print SUM "<b style=\"width: $failnewfeature_percentage%;background: red;\" title=\"$failnewfeature_percentage%\"></b>\n";
	print SUM "<b style=\"width: $notestnewfeature_percentage%;background: #808080;\" title=\"$notestnewfeature_percentage%\"></b>\n";
	print SUM "</div>\n";
	print SUM "</TD>\n";
	print SUM "</TR>\n";
	print SUM "</TABLE>\n";
    
	print SUM "<Font face = \"Verdana\"><h4><FONT size=5 color=\"red\" face=\"arial\"><B> Registered but not run:</B></FONT></h4>\n";
	open (NOTRUN,$notrun) or die "Could not open file $notrun: !#";
	foreach(<NOTRUN>){
		$_ =~ s/\r//g;                                                                     
		chomp $_; 
		my @col = split(/\t/,$_);
		my $name = $col[1];


		if (!defined $name || $name eq "")
		{
			# print NOTREGIS "$col[0],$col[1],$col[2],$col[3],$col[4],$col[5],$col[6],$col[7]\n";
		} else {

			if (($dsp_num == 2) && ($name =~ /(.*2DSP.*)/i))
			{
				$name = $1;
				print SUM "<Font face = \"Verdana\"><h4><FONT size=4 color=\"#red\" face=\"arial\">$col[0],$col[1],$col[2],$col[3],$col[4]</FONT></h4>\n"
			}
			if ($dsp_num != 2 && !($name =~ /(.*2DSP.*)/i)) 
			{
				print SUM "<Font face = \"Verdana\"><h4><FONT size=4 color=\"#red\" face=\"arial\">$col[0],$col[1],$col[2],$col[3],$col[4]</FONT></h4>\n"
			}
		
		}
	}
	close NOTRUN;
	
	print SUM "<Font face = \"Verdana\"><h4><FONT size=5 color=\"red\" face=\"arial\"><B> Run but not registered:</B></FONT></h4>\n";
	open (NOTREGIS,$notregis) or die "Could not open file $notrun: !#";
	foreach(<NOTREGIS>){
		$_ =~ s/\r//g;                                                                     
		chomp $_; 
		my @col = split(/,/,$_);
		my $name = $col[0];

		if (!defined $name || $name eq "")
		{
			# print NOTREGIS "$col[0],$col[1],$col[2],$col[3],$col[4],$col[5],$col[6],$col[7]\n";
		} else {
			if ($dsp_num != 2 && !($name =~ /(.*2DSP.*)/i)) 
			{
				print SUM "<Font face = \"Verdana\"><h4><FONT size=4 color=\"#red\" face=\"arial\">$col[0],$col[1],$col[2],$col[3],$col[4],$col[5],$col[6],$col[7],$col[8]</FONT></h4>\n"
			}
			if (($dsp_num == 2) && ($name =~ /(.*2DSP.*)/i))
			{
				$name = $1;
				print SUM "<Font face = \"Verdana\"><h4><FONT size=4 color=\"#red\" face=\"arial\">$col[0],$col[1],$col[2],$col[3],$col[4],$col[5],$col[6],$col[7],$col[8]</FONT></h4>\n"
			}
		}
	}
	close NOTRUN;
	
	&SortPersonName;
	
	my $sumtxtpath = "$directory\/$sumtxt";
	my $sumfh = new IO::File;
	$sumfh->open($sumtxtpath) or die "Could not open file $sumtxtpath to write";	
	my @file = <$sumfh>;	
	close $sumfh;
	@file = &preprocess(@file);
	if ($totalregression != 0)
	{
	    print SUM "<Font face = \"Verdana\"><h4><FONT size=5 color=\"#191970\" face=\"arial\"><B> - regression pool</B></FONT></h4>\n";
		&printHead;
        open REF ,">>$reg_file" or die "Could not open file $reg_file for writing:";
		foreach(@file)
		{
			next unless s/Regression//;
			my @value = split(/\t/);
            print REF "$value[1],$value[9]\n";
			print SUM "<TR>\n";
			&printTd(\@value);
			print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align=\"center\"><Font color = \"Black\">$currentWeek</TD>\n";
			print SUM "</TR>\n";
		}
		close REF;
		print SUM "</TABLE>\n";
	}
	if ($totalunstable != 0)
	{
	    print SUM "<Font face = \"Verdana\"><h4><FONT size=5 color=\"#191970\" face=\"arial\"><B> - unstable pool</B></FONT></h4>\n";
		&printHead;
		foreach(@file)
		{
			next unless s/Unstable//;
			my @value = split(/\t/);
			print SUM "<TR>\n";
			&printTd(\@value);
			print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align=\"center\"><Font color = \"Black\">$currentWeek</TD>\n";
			print SUM "</TR>\n";
		}
		
		print SUM "</TABLE>\n";
		
	}
	if ($totalnewfeature != 0)
	{
		print SUM "<Font face = \"Verdana\"><h4><FONT size=5 color=\"#191970\" face=\"arial\"><B> - newfeature pool</B></FONT></h4>\n";
		&printHead;
                open NEF ,">>$nef_file" or die "Could not open file $nef_file for writing:";
        
		foreach(@file)
		{
			if (($dsp_num != 2))
			{
				next unless ((s/NewFeature//) && !($_ =~ /(.*2DSP.*)/i));
			}
			if (($dsp_num == 2))
			{
				next unless ((s/NewFeature//) && ($_ =~ /(.*2DSP.*)/i));
			}
			# next unless s/NewFeature//;
			my @value = split(/\t/);
			print SUM "<TR>\n";
			&printTd(\@value);
			print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align=\"center\"><Font color = \"Black\">$currentWeek</TD>\n";
			print SUM "</TR>\n";
            print NEF "$value[1],$value[9]\n";
		}
		close NEF;
		print SUM "</TABLE>\n";
		
	}
	print SUM "</BODY>\n";
	print SUM "</HTML>\n";
    close SUM;
}

sub printHead
{
        print SUM "<TABLE border=\"1\" cellspacing=\"0\" cellpadding=\"4\" style=\"border: 1px solid black; border-collapse: collapse;empty-cells: show;margin: 0px 1px;\">\n";
		print SUM "<TR>\n";
		print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Requirement</b></TD>\n";
		print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Test case name</b></TD>\n";
        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>PUSCH</b></TD>\n";
        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>PUCCH</b></TD>\n";
        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>PRACH</b></TD>\n";
        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>SRS</b></TD>\n";
        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Calibration</b></TD>\n";
        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Cell Meas</b></TD>\n";
        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Reason</b></TD>\n";
        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Test PASS/FAIL</b></TD>\n";
		print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Owner</b></TD>\n";
		print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Plan week</b></TD>\n";
		print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align = center><b>Current week</b></TD>\n";
        print SUM "</TR>\n";
}

sub printTd
{
    my $aref = shift;
	
    foreach(@$aref)
	{
	
        if ($_ =~ /PASS/)
        {
            print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align=\"center\"><Font color = \"Green\">$_</TD>\n";
        }
        elsif ($_ =~ /FAIL/)
        {
            print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align=\"center\"><Font color = \"Red\">$_</TD>\n";
        }
	    elsif ($_ =~ /NotTest/)
        {
			print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align=\"center\"><Font color = \"Black\">$_</TD>\n";
        }
	    elsif ($_ eq "-")
	    {
	        print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align=\"center\"><Font color = \"Brown\">$_</TD>\n";
	    }
	    elsif ($_ =~ /Regression/ || $_ =~ /Unstable/ || $_ =~ /NewFeature/ || $_ eq '')
	    {
	        next;
        }
	    elsif ($_ =~ /TM/)
	    {
	        print SUM "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\">$_</TD>\n";
	    }
		elsif ($_ =~ /wk/)
	    {
	        print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\" align=\"center\"><Font color = \"Black\">$_</TD>\n";
	    }
	    else
	    {
	        print SUM  "<TD style=\"border: 1px solid black;padding: 1px 4px;margin: 0px;\"><Font color = \"Blue\">$_</TD>\n";
	    }
	}
}

sub GetC
{
    my($excel, $sheetName, $valueC) = @_;
	
	my $returnC;
    
    my ($workexcel, $workbook, $worksheet);
   
    $workexcel = new Spreadsheet::ParseExcel;
   
    $workbook = $workexcel->Parse($excel);
	
    $worksheet = $workbook->worksheet($sheetName);

    for(my $iC = $worksheet->{MinCol} ; defined $worksheet->{MaxCol} && $iC <= $worksheet->{MaxCol} ; $iC++)
    {
        for(my $iR = $worksheet->{MinRow} ; defined $worksheet->{MaxRow} && $iR <= $worksheet->{MaxRow} ; $iR++)
        {
		    my $workcell = $worksheet->{Cells}[$iR][$iC];
			if (!defined $workcell) 
            {
                next;
            }
            my $value = $workcell->Value;
            if ($value =~ /^$valueC/)
            {
                $returnC = $iC;
		    	last;
            }
		}
    }
    return $returnC;
}

sub preprocess                                                                                
{                                                                                             
    my (@lines) = @_;                                                                         
    my @out;                                                                                  
    for (my $i = 0; $i < @lines; ++$i)                                                        
    {                                                                                         
        my $line = $lines[$i]; 
        $line =~ s/\r//g;                                                                     
        chomp $line;                                                                          
        while ($line =~ /\\$/ && ++$i < @lines)                                               
        {                                                                                     
            $line =~ s/\\$//;                                                                 
            $line .= $lines[$i];                                                              
            $line =~ s/\r//g;                                                                 
            chomp $line;                                                                      
        }                                                                                     
        push @out, $line;                                                                     
    }                                                                                         
    return @out;                                                                              
}

sub GetCurrentWK
{

    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year += 1900; 
    ++$mon; 
    my $yy = strftime ("%y", localtime(time));
    my $currentWeek = int(($yday+1-$wday)/7);
	if ($wday != 0)
	{
        $currentWeek +=1;
	}
    $currentWeek = sprintf "%2dwk%02d" , $yy, $currentWeek;  
    return $currentWeek; 	
}

sub SortPersonName
{
    open(SUMTXT, $sumtxt) or die "Could not open file $sumtxt to read";
	open(TMP, ">>sorttmp.txt")  or die "Could not open tmp file to write";
	
    my %hash_line;
	my @key_name;
    while(<SUMTXT>)
	{
	    @key_name = split(/\t/,$_);
	    push(@{$hash_line{$key_name[-2]}},$_);
	}
	close(SUMTXT);
	
    my @item;
	foreach my $group (keys %hash_line)
	{
	    @item = sort(@{$hash_line{$group}});
	    foreach (@item)
		{
		    print TMP "$_";
		}
	}
	
	close(TMP);
	
	rename $sumtxt, "$sumtxt"."_old";
	rename "sorttmp.txt",$sumtxt;
}










