#!/usr/bin/env perl

use feature "switch";

my $fli="chapter_basis_digitaal_ontwerp.tex";
my $flo="exi-$fli.tmp";
my $fld="exi-dic.map.tmp";

my $cnt_pr='';
my $cnt_in='';
my $cnt_po='';
my $cnt_lb='';
my $cnt_pp='';
my $cnt_lb='';
my $cnt_lbo='';
my $cnt_fl='';

my $cnt_gl='';

open(my $in,"<",$fli);
open(my $ou,">",$flo);
open(my $od,">>",$fld);

sub normLabel {
  my $rlb=$_[0];
  my @lbl=split //,$rlb;
  $rlb="";
  foreach(@lbl) {
    my $ch = $_;
    if($ch =~ /^[A-Z]*$/) {
      $rlb .= "-".lc $_;
    } else {
      $rlb .= $_;
    }
  }
  my $suf = '';
  my $sfi = 0;
  while(-e "tikzpictures/tikz-$rlb$suf.tex") {
      $sfi = $sfi+1;
      $suf = "$sfi";
  }
  return "$rlb$suf","tikzpictures/tikz-$rlb$suf.tex";
}

sub askOptions {
  my $qst=$_[0];
  shift @_;
  my $opt=join('',@_);
  print "\e[4;7m$qst\e[0m [$opt]? ";
  my $ans = <STDIN>;
  return $ans
}

sub extract_n {
  print $ou "$cnt_pr$cnt_in$cnt_po$cnt_lb";
}

sub extract_y {
  print $ou "$cnt_pr\\importtikzfigore{$cnt_gl}{}\n$cnt_po";
	open(my $tf,">",$cnt_fl);
	print $tf $cnt_in;
	close $tf;
  print $od "$cnt_lbo:$cnt_gl\n";
}

my $tikz=0; #State of exctraction: 0=outside, 1=inside, 2=labelfetch
my @imst = ();

#Perform a pre-mod commit, for backtracking reasons
system( "git","add",".");
system( "git","commit","-am" "pre-extract-image commit");

while ( <$in> ) {
  my $ln = $_;
  #print "$tikz:$ln\n";
  if($tikz == 0) { #We are outside a tikz picture looking for starts
    if($ln =~ /^(.*?)(\\begin{tikzpicture}.*)$/) {
      $cnt_pr .= $1;
      $cnt_in = "$2\n";
			$cnt_po="";
			$cnt_lb="";
			$cnt_pp="";
      $tikz = 1;
    } else {
      $cnt_pr .= $ln;
    }
  } elsif($tikz == 1) { #We are in a tikz picture, look for escapes
    if($ln =~ /^(.*?\\end{tikzpicture})(.*)$/) {
      $cnt_in .= "$1";
      $cnt_po = "$2\n";
      $tikz = 2;
    } else {
      $cnt_in .= $ln;
    }
  } elsif($tikz == 2) { #We are in a tikz picture, look for escapes
    if($ln =~ /^(.*?)(\\figlab{([^}]*)})(.*)$/) {
      $cnt_po .= "$1";
      $cnt_lb = "$2";
      $cnt_lbo = "$3";
      $cnt_pp = "$4\n";
      ($cnt_gl,$cnt_fl) = normLabel($3);
      print "\e[31m$cnt_pr\e[33m$cnt_in\e[32m$cnt_po\e[35m$cnt_lb\e[34m$cnt_pp\e[0m";
      my $ans = askOptions("Split off the \e[33myellow\e[37m part to \"$cnt_fl\" with label \"$cnt_lb\"",'y','n');
      given($ans) {
        when (/^y/) {extract_y();}
        when (/^n/) {extract_n();}
      }
      $tikz = 0;
      $cnt_pr = "$cnt_pp";
			$cnt_pp="";
			$cnt_in="";
			$cnt_po="";
			$cnt_lb="";
    } else {
      $cnt_po .= "$ln";
    }
  }
}
print $ou "$cnt_pr$cnt_in$cnt_po";

system( "git","commit","-am" "pre-extract-image commit");

system( "git","add",".");
system( "git","commit","-am" "post-extract-image commit");
