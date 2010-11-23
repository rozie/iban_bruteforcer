#!/usr/bin/perl

# IBAN bruteforcer

# v1.0 - Pawe³ Ró¿añski rozie[at]poczta(dot)onet(dot)pl

# This script generates (all) possible values for IBAN account for pattern where X marks missing digit
# Based on http://pl.wikipedia.org/wiki/International_Bank_Account_Number
# http://pl.wikipedia.org/wiki/Numer_Rachunku_Bankowego

# 20101122 : Created

use Algorithm::CheckDigits;

$pattern=$ARGV[0];
$i=0;
$valid=0;

if ($pattern =~ /^(.*?)([Xx]+)(.*)$/){
	$prefix=$1;
	$count=length($2);
	$suffix=$3;
	$base="0"x$count;
	$max=(10 ** $count)-1;
}
else {
	print "Usage: ibaner.pl <pattern>";
	print "Use X or x for missing digits. All missing digits must be next to each other\n";
	print "Sample usage ibaner.pl PL9610504361838250644694XX57\n";
	exit 0;
}

while ($i <= $max){
	$i++;
	$test=$prefix.$base.$suffix;
	$iban = CheckDigits('iban');
	$result = $iban->is_valid($test)?1:0;
	if ($result){
		$valid++;
		print "$test is valid\n";
	}
	$base++;
}

print "Total valid for given pattern: $valid \n";
