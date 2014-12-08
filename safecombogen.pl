#!/usr/bin/perl -w

use strict;
use warnings;

#######################################################################
## Adjust the following three variables to meet your needs.  Each is
## individually commented.
#######################################################################
## '$minimum' should represent the lowest numerical value on your safe 
## dial, you likely will not need to change this one.
my $minimum = '0';

## '$maximum' should be set to the highest numerical value on your safe
## dial.
my $maximum = '99';

## '$num_combinations' should be set to the desired number of combinations
## that you wish to generate.
my $num_combinations = shift || 50;

#######################################################################
## You should not need to change anything below this point.
#######################################################################
my %combos = ();

for(my $i = $num_combinations; $i > 0; $i--){
    my ($first,$second,$third) = undef;

    while (!$first){
	my $x = $minimum + int(rand($maximum - $minimum));
	$first = $x;
    }

    while(!$second){
	my $x = $minimum + int(rand($maximum - $minimum));
	next if ($first == $x); ## Prevents  a repeat number in the combination.
	$second = $x;
    }  

    while(!$third){
	my $x = '11' + int(rand(89 - 11)); ## Prevents a final digit between '90' and '10'.
	next if ( ($first == $x) || ($second == $x ) ); ## Prevents a repeat number in the combination.
	$third = $x;
    }

## Now testing the combinations ##
    ascending($first,$second,$third);
    descending($first,$second,$third);
    same_end_digits($first,$second,$third);
    too_close($first,$second,$third);

    $combos{$i}= "$first\-$second\-$third";
    print "$combos{$i} \n";
}


###################
##  Subroutines  ##
###################
sub ascending{	
	my ($f,$s,$t) = @_;
	if( $f < $s){
		print "Ascending - " if($s < $t);
	}
}
sub descending{
	my  ($f,$s,$t) = @_;
	if( $f > $s){
		print "Descending - " if($s > $t);
	}
}
sub same_end_digits{
	my ($f,$s,$t) = @_;
	my ($df,$ds,$dt) = undef;
	my $count = 0;
	if(length($f) == 2 ){
		$df = substr $f,1,1;
	}else{
		$df = $f;
	}
	if (length($s) == 2){
		$ds = substr $s,1,1;
	}else{
		$ds = $s;
	}
	if (length($t) == 2){
		$dt = substr $t,1,1;
	}else{
		$dt = $t;
	}
	if( ($df == $ds) || ($ds == $dt) ){
		$count++;
	}
	print "Matching end digits - " if($count > 0)
}
sub too_close{
	my ($f,$s,$t) = @_;
	my $rslt = undef;
	if ($f > $s){
		$rslt = $f - $s;
		print "Numbers are within 10 - " if($rslt < 10);
		return;
	}elsif($f < $s){
		$rslt = $s - $f;
		print "Numbers are within 10 - " if($rslt < 10);
		return;
	}elsif($s > $t){
		$rslt = $s - $t;
		print "Numbers are within 10 - " if($rslt < 10);
		return;
	}elsif($s < $t){
		$rslt = $t - $s;
		print "Numbers are within 10 - " if($rslt < 10);
		return;
	}else{
		return;
	}
}
