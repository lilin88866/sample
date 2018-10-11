#!/usr/bin/perl -w

########################################################################################
#
# Use DB.
# Divide report as regression/unstable/newfeature three type
# Combine MT 2/4/8 SCT 2/4/8 report
#
# Parameter:  [type]: MT or SCT
#             [antenna]: 2 or 4 or 8 or ALL
#             [domain]: Receiver1 or Receiver2 or Channelizer or Decoder
#
# reverse('?'),  November 2011, Zhou Ting
#
use strict;
use POSIX qw/strftime/;


our $domain = $ARGV[2];

print "$testtype, $antenna\n";

our $grep = "C:\\cygwin\\bin\\grep.exe";
our $sed = "C:\\cygwin\\bin\\sed.exe";
our $awk = "C:\\cygwin\\bin\\gawk.exe";

my $currentWeek = &GetCurrentWK;

our @report;
our @pool;
our @suite;
our @tc;

my $case_file = "case.txt";
open (CASE, $case_file) or die "Could not open file $case_file for writing: !#";

foreach(<CASE>)
{
    $_ =~ s/\r//g;                                                                     
    chomp $_; 
	my @col = split(/\t/,$_);
	my $id = $col[0];
	my $case = $col[1];
	$case =~ s/ //g;
    my $pipe = $col[2];
	my $pools = $col[3];
	my $type = $col[4];
	my $owner = $col[5];
	my $story = $col[6];
	my $plan = $col[7];
	next if ($type !~ /$testtype/);
	next if ($pipe ne $antenna && $antenna ne "ALL");
	if($domain eq "Receiver1" )
	{
	    next if ($type =~ /Channelizer/);
		next if ($type =~ /PucchReceiver/);
        next if ($type =~ /PrachReceiver/);
		next if ($type =~ /Calibration/);
		next if ($type =~ /Decoder/);
	}
	if($domain eq "Receiver2" )
	{
	    next if ($type =~ /Channelizer/);
		next if ($type =~ /PuschReceiver/);
        next if ($type =~ /SrsReceiver/);
		next if ($type =~ /Decoder/);
	}
	if($domain eq "Channelizer" )
	{
	    next if ($type !~ /Channelizer/);
	}
	if($domain eq "Decoder" )
	{
	    next if ($type !~ /Decoder/);
	}
	&CreateDS($case, $pipe, $pools, $testtype, $owner, $story, $plan);
	# &Reg_not_run($type,$pipe,$antenna,$testtype);
	
}

our $sumhtml = "summary_pool".$antenna.".html";

&CreateHtml;

# &Run_not_reg($antenna, $testtype);
sub CreateHtml
{
    our @report;
	our $sumhtml;
	my $sc = {};
    my $tc = {};
    my $suite = {};
    my $pool = {};
    my $report = {};
	
	open (SUM, ">$sumhtml") or die "Could not open $sumhtml for writing: $!";
	print SUM "<HTML>\n";
	print SUM "<HEAD></HEAD>\n";
	print SUM "<BODY>\n";

    for my $rep(0...$#report)
    {
    	for my $rname(keys %{$report[$rep]})
    	{
    	    next if ($rname =~ /^total/);
			next if ($rname =~ /^pass/);
			next if ($rname =~ /^fail/);
			next if ($rname =~ /^notest/);
			my $rt;
			my $rpipe;
            my $label;
			if ($rname =~ /(\w+)(\d+)/)
			{
			    $rt = $1;
				$rt =~ tr/a-z/A-Z/;
				$rpipe = $2."PIPE";
                $label = $rt.$2;
			}
			print SUM "<h4><a name=\"$label\"><FONT size=6 color=\"#000000\" face=\"arial\"><B>$rt $rpipe Report</B></FONT></a></h4>\n";
			print SUM "<Font face = \"Verdana\"><h4><FONT size=5 color=\"red\" face=\"arial\"><B> Run but not registered:</B></FONT></h4>\n";
			&Run_not_reg($antenna, $testtype);
			print SUM "<Font face = \"Verdana\"><h4><FONT size=5 color=\"red\" face=\"arial\"><B> Registered but not run:</B></FONT></h4>\n";
			&Reg_not_run();
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
			for my $po(0...$#{$report[$rep]{$rname}})
    		{
				for my $pname(keys %{$report[$rep]{$rname}[$po]})
    			{
				    if ($pname =~ /^totalregression/)
					{
					    $totalregression = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^passregression/)
					{
					    $passregression = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^failregression/)
					{
					    $failregression = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^notestregression/)
					{
					    $notestregression = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^totalunstable/)
					{
					    $totalunstable = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^passunstable/)
					{
					    $passunstable = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^failunstable/)
					{
					    $failunstable = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^notestunstable/)
					{
					    $notestunstable = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^totalnewfeature/)
					{
					    $totalnewfeature = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^passnewfeature/)
					{
					    $passnewfeature = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^failnewfeature/)
					{
					    $failnewfeature = $report[$rep]{$rname}[$po]{$pname};
					}
					if ($pname =~ /^notestnewfeature/)
					{
					    $notestnewfeature = $report[$rep]{$rname}[$po]{$pname};
					}
				}
			}
			if ($totalregression == 0)
			{
			    $passregression_percentage = 100;
			    $failregression_percentage = 0;
			    $notestregression_percentage = 0;
			}
			else
			{
			    $passregression_percentage = $passregression/$totalregression*100;
			    $failregression_percentage = $failregression/$totalregression*100-0.01;
			    $notestregression_percentage = $notestregression/$totalregression*100-0.01;
			}
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

				
			for my $po(0...$#{$report[$rep]{$rname}})
    		{
				for my $pname(keys %{$report[$rep]{$rname}[$po]})
    			{
				    next if ($pname =~ /^total/);
			        next if ($pname =~ /^pass/);
			        next if ($pname =~ /^fail/);
			        next if ($pname =~ /^notest/);

    				for my $su(0...$#{$report[$rep]{$rname}[$po]{$pname}})
    				{
    				    for my $suname(keys %{$report[$rep]{$rname}[$po]{$pname}[$su]})
    					{

    						 for my $t(0...$#{$report[$rep]{$rname}[$po]{$pname}[$su]{$suname}})
    						 {
    						     my $totaltc = 0;
								 my $passtc = 0;
								 my $failtc = 0;
								 my $notesttc = 0;
								 my $resulttc = 0;
								 my $bgcol = 0;
                                 my $fgcol = 0;
								 for my $tname(keys %{$report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]})
    							 {
								     if ($tname =~ /^total/)
									 {
									     $totaltc = $report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]{$tname};
									 }
			                         if ($tname =~ /^pass/)
									 {
									     $passtc = $report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]{$tname};
									 }
			                         if ($tname =~ /^fail/)
									 {
									     $failtc = $report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]{$tname};
									 }
			                         if ($tname =~ /^notest/)
									 {
									     $notesttc = $report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]{$tname};
									 }
								 }
								 if ($totaltc eq $passtc)
							     {
									 $resulttc = "Pass";
								     $bgcol = "#00FF00";
									 $fgcol = "white";
								 }
								 elsif ($totaltc eq $notesttc)
								 {
									 $resulttc = "Not Test";
									 $bgcol = "#808080";
									 $fgcol = "black";
								 }
								 else 
								 {
									 $resulttc = "Fail";
								     $bgcol = "red";
									 $fgcol = "black";
								 }
								 for my $tname(keys %{$report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]})
    							 {
                                     next if ($tname =~ /^total/);
									 next if ($tname =~ /^pass/);
									 next if ($tname =~ /^fail/);
									 next if ($tname =~ /^notest/);

    								 for my $sc(0...$#{$report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]{$tname}})
    								 {
										 for my $scname(keys %{$report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]{$tname}[$sc]})
    									 {
											if ($report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]{$tname}[$sc]{result} eq "Pass")
											 {
											     my $fontcol = "#00FF00";

												 last;
											 }
											 elsif ($report[$rep]{$rname}[$po]{$pname}[$su]{$suname}[$t]{$tname}[$sc]{result} eq "Not Test")
											 {
											     my $fontcol = "black";

												 last;
											 }
											 else
											 {
											     my $fontcol = "red";

												 last;
											 }
											 
    									 }
    								 }
    							 }
    						 }
    					}
    				}
    			}
    		}
    	}
    }

}


sub CreateDS
{
    my ($casename, $pipe, $pooltype, $testtype, $owner, $story, $plan) = @_;
    my $sc = {};
	my $tc = {};
	my $suite = {};
	my $pool = {};
	my $report = {};
	my $reportflag = 0;
	my $poolflag = 0;
	my $suiteflag = 0;
	my $tcflag = 0;
	$sc->{name} = $casename;
	$sc->{owner} = $owner;
	$sc->{story} = $story;
	$sc->{plan} = $plan;
	my ($result, $reason, $suitename, $tcname) = &GetCaseInfo($casename, $pipe, $testtype);
	$sc->{result} = $result;
	$sc->{reason} = $reason;
	my ($pools, $reporttype);
	if ($pooltype =~ /Regression/)
	{
		$pools = "regression";
		
	}
	elsif ($pooltype =~ /Unstable/)
	{
		$pools = "unstable";
	}
	elsif ($pooltype =~ /NewFeature/)
	{
		$pools = "newfeature";
	}
	if ($testtype eq "MT" && $pipe =~ /2/)
	{
		$reporttype = "mt2";
	}
	if ($testtype eq "MT" && $pipe =~ /4/)
	{
		$reporttype = "mt4";
	}
	if ($testtype eq "MT" && $pipe =~ /8/)
	{
		$reporttype = "mt8";
	}
	
	for my $rep(0...$#report)
	{
		for my $rname(sort keys %{$report[$rep]})
		{
			if ($rname eq $reporttype)
			{
				$report = $report[$rep];
				#print "$reporttype exist\n";
				$reportflag = 1;
				for my $po(0...$#{$report->{$reporttype}})
				{
					for my $pname(sort keys %{$report->{$reporttype}[$po]})
					{
						if ($pname eq $pools)
						{
							$pool = $report->{$reporttype}[$po];
							#print "$pools exist\n";
							$poolflag = 1;
							for my $su(0...$#{$report->{$reporttype}[$po]{$pools}})
							{
								 for my $suname(sort keys %{$report->{$reporttype}[$po]{$pools}[$su]})
								 {
									 if ($suname eq $suitename)
									 {
										 $suite = $report->{$reporttype}[$po]{$pools}[$su];
										 #print "$suitename exist\n";
										 $suiteflag = 1;
										 for my $t(0...$#{$report->{$reporttype}[$po]{$pools}[$su]{$suitename}})
										 {
											 for my $tname(sort keys %{$report->{$reporttype}[$po]{$pools}[$su]{$suitename}[$t]})
											 {
												 if ($tname eq $tcname)
												 {
													 $tc = $report->{$reporttype}[$po]{$pools}[$su]{$suitename}[$t];
													 $tcflag = 1;
													 #print "$tcname exist\n";
													 last;
												 }
											 }
										 }
										 last;
									 }
								 }
							}
							last;
						}
					}
				}
				last;
			}
		}
	
	}
	$report->{"total".$reporttype} ++;
	$pool->{"total".$pools} ++;
	$tc->{"total".$tcname} ++;	
	
	if ($result eq "Pass")
	{
		$report->{"pass".$reporttype} ++;
		$pool->{"pass".$pools} ++;
		$tc->{"pass".$tcname} ++;
	}
	elsif ($result eq "Fail")
	{
		$report->{"fail".$reporttype} ++;
		$pool->{"fail".$pools} ++;
		$tc->{"fail".$tcname} ++;
	}
	elsif ($result eq "Not Test")
	{
		$report->{"notest".$reporttype} ++;
		$pool->{"notest".$pools} ++;
		$tc->{"notest".$tcname} ++;
	}
	
	if ($reportflag == 0)
	{
		
		push @{$tc->{$tcname}} ,$sc;
		push @{$suite->{$suitename}},$tc;
		
		push @{$pool->{$pools}},$suite;
		push @{$report->{$reporttype}},$pool;
		push @report, $report;
	}
	elsif ($poolflag == 0)
	{
		push @{$tc->{$tcname}} ,$sc;
		push @{$suite->{$suitename}},$tc;
		push @{$pool->{$pools}},$suite;
		push @{$report->{$reporttype}},$pool;
	}
	elsif ($suiteflag == 0)
	{
		push @{$tc->{$tcname}} ,$sc;
		push @{$suite->{$suitename}},$tc;
		push @{$pool->{$pools}},$suite;
	}
   elsif ($tcflag == 0)
	{
		push @{$tc->{$tcname}} ,$sc;
		push @{$suite->{$suitename}},$tc;
	}
	else
	{
		push @{$tc->{$tcname}} ,$sc;
	}
}


sub GetCaseInfo
{
    my ($case, $pipe, $testtype) = @_;
    
    my ($result, $reason, $suitename, $tcname);
    
    my $report_file = "summary_".$testtype."_".$pipe."pipe.txt";

    $result = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$4}'`;
	if (!defined $result || $result eq "")
	{
	    $result = "Not Test";
	}
	$reason = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$5\$6\$7}'`;
	if (!defined $reason || $reason eq "")
	{
	    $reason = "Unknown";
	}
	$suitename = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$1}'`;
	if (!defined $suitename || $suitename eq "")
	{
	    $suitename = "Not add to any suite until now";
	}
	$tcname = `$grep '$case,' $report_file | $awk -F "\[,\]" '{printf \$2}'`;
	if (!defined $tcname || $tcname eq "")
	{
	    $tcname = "Not add to any testcaselist until now";
	}
	#print "$result, $reason, $suitename, $tcname\n";

	
    return ($result, $reason, $suitename, $tcname);
}
sub Run_not_reg
{
	my ($pipe,$testtype)=@_;
	my $report_file = "summary_".$testtype."_".$antenna."pipe.txt";
	our $notregis = "NOTREGIS".$antenna."PIPE.txt";
	open NOTREGIS,">$notregis" or die "can not opoen $notregis file.\n";
	open(RUN,$report_file) or die "Could not open file $report_file: !#";
	foreach(<RUN>){
		$_ =~ s/\r//g;                                                                     
		chomp $_; 
		my @col = split(/,/,$_);
		my $name = $col[2];
		my $exist = `$grep -w '$name' $case_file`;
		if (!defined $exist || $exist eq "")
		{
			print NOTREGIS "$col[0],$col[1],$col[2],$col[3],$col[4]\n";
			print SUM "$col[1]:$col[2],$col[3],$col[4].\n";
			
		}
	}
	close RUN;
	close NOTREGIS;
}


sub Reg_not_run
{
	my $report_file = "summary_".$testtype."_".$antenna."pipe.txt";
	our $notrun = "NOTRUN_".$antenna."PIPE.txt";
	open NOTRUN,">$notrun" or die "can not opoen $notrun file.\n";
	open(RUN,$case_file) or die "Could not open file $case_file: !#";
	foreach(<RUN>){
		$_ =~ s/\r//g;                                                                     
		chomp $_; 
		my @col = split(/\t/,$_);
		my $name = $col[1];
		my $pipe = $col[2];
		my $pools = $col[3];
		my $type = $col[4];
		my $owner = $col[5];
		my $story = $col[6];
		my $exist = `$grep '$name,' $report_file`;
		 # $_ =~ s/\r//g;                                                                     

		if($domain eq "Receiver1" )
		{
			next if ($type =~ /Channelizer/);
			next if ($type =~ /PucchReceiver/);
			next if ($type =~ /PrachReceiver/);
			next if ($type =~ /Calibration/);
			next if ($type =~ /Decoder/);
		}
		if($domain eq "Receiver2" )
		{
			next if ($type =~ /Channelizer/);
			next if ($type =~ /PuschReceiver/);
			next if ($type =~ /SrsReceiver/);
			next if ($type =~ /Decoder/);
		}
		if($domain eq "Channelizer" )
		{
			next if ($type !~ /Channelizer/);
		}
		if($domain eq "Decoder" )
		{
			next if ($type !~ /Decoder/);
		}
		next if ($type !~ /$testtype/);
		next if ($pools eq "NewFeature");
		next if ($pipe ne $antenna && $antenna ne "ALL");
		if (!defined $exist || $exist eq "")
		{
			print NOTRUN "$col[0],$col[1],$col[2],$col[3],$col[4]\n";
			print SUM "$col[1],$col[5],$col[6],$col[7]\n";
			
		}
	}
	close RUN;
	close NOTRUN;
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
