$skew = $ARGV[0];
while(<STDIN>) {
	$line = $_;
	if($line =~ /^p\. ([0-9]+):(.*)$/) {
		$pg = $1;
		$pg += $skew;
		print "p. $pg:$2\n";
	}
	else {
		print "$line";
	}
}
