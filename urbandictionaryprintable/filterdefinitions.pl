use HTML::Entities qw(decode_entities);
use TeX::Encode;
use Encode;

$ndtitle = 1;
$nddefin = 1;
$ndexamp = 1;
$con = 1;
while(<>) {
	if($con) {
		if($ndtitle && m/^<title>Urban Dictionary: (.*)<\/title>$/) {
			$ndtitle = 0;
			$title = $1;
			$title = encode('latex',toLaTeX(decode_entities(removeahrefs($title))));
		}
		if($nddefin && m/^<div class="definition">(.*)<\/div>/) {
			$nddefin = 0;
			$def = $1;
			if($def =~ m/^(.*)<\/div><div class="example">/) {
				$def = $1;
			}
			$def = encode('latex',toLaTeX(decode_entities(removeahrefs($def))));
			print "\\entry[$title]{$title}{$def}\n";
			$con = 0;
		}
	}
}
sub removeahrefs {
   $tmp = $_[0];
   my @char_array = split(//,"$str");
   $tmp = join( '' , map { chr( $_ ) } (grep { $_ >= 32 && $_ < 127 } (map { ord( $_ ) } split(//,"$tmp"))));
   $tmp =~ s/<\/a>//g;
   $tmp =~ s/<a href="[^"]*">//g;
   $tmp =~ s/&lt;/</g;
   $tmp =~ s/&gt;/>/g;
   $tmp =~ s/&amp;/&/g;
   return $tmp;
}
sub toLaTeX {
   $tmp = $_[0];
   $tmp =~ s/<br\/?>/\n/g;
   $tmp =~ s/<[^>]*>//g;
   return $tmp;
}
#sub toLaTeX {
#   $tmp = $_[0];
#   $tmp =~ s/([&%\$#_{}~^\\])/\\$1\{\}/g;
#   $tmp =~ s/<br\/?>/ \\\\ /g;
#   $tmp =~ s/ +$//g;
#   $tmp =~ s/^ +//g;
#   return $tmp;
#}*/
