$collect = 0;
$current = "";
while(<>) {
	if($_ =~ m/^[ \t\n]*(D|d)(efinition|efinitie) [0-9]+/) {
		$line = $_;
		if($collect) {
			print MoreLaTeX($current);
		}
		$collect = 1;
		$current = $line;
	}
	elsif($collect) {
		if($_ =~ m/^[ \t\n]*$/) {
			print MoreLaTeX($current);
			$collect = 0;
			$current = "";
		}
		else {
			$current = "$current$_";
		}
	}
}
print "$current";

sub MoreLaTeX {
	$inp = $_[0];
	$inp =~ s/^•/\\item /g;
	$inp =~ s/∅/\\emptyset /g;
	$inp =~ s/⊆/\\subseteq /g;
	$inp =~ s/∈/\\in /g;
	$inp =~ s/→/\\rightarrow /g;
	$inp =~ s/∧/\\wedge /g;
	$inp =~ s/∪/\\cup /g;
	$inp =~ s/⊂/\\subseteq /g;
	$inp =~ s/≥/\\geq /g;
	$inp =~ s/τ/\\tau /g;
	$inp =~ s/·/\\cdot /g;
	$inp =~ s/\.\.\./\\ldots /g;
	
	$inp =~ s/ +\\/\\/g;#reducing space
	$inp =~ s/(\\[A-Za-z]+) +/$1 /g;#reducing space
#	$inp =~ s/(L|l)et ([A-Za-z]) /$1et \$$2\$/g;
#	$inp =~ s/ ([B-Zb-z]) /\$$1\$/g;
	print "\\begin{defi}\n$inp\\cite{}\n\\end{defi}\n\n";
}
