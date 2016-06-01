#!/usr/bin/env perl

use feature "switch";

my $fli="chapter_basis_digitaal_ontwerp.tex";
my $flo="exi-$fli.tmp";
my $prefc="";
my $pstfc="";
my $tikz=0;
my $tikzc;
my @imst = ();

open(my $in,"<",$fli);
open(my $ou,">",$flo);

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
  return $rlb;
}

while ( <$in> ) {
  my $ln = $_;
  if($tikz) {
    $ln =~ /^(.*?)((\\end{tikzpicture})(.*))?$/;
    $tikzc .= "$1$3";
    if($2) {
      $tikz=0;
      if($3) {
        $pstfc = "$4\n";
      } else {
        $tikzc .= "\n";
      }
    } else {
      $tikzc .= "\n";
    }
  } else {
    if ($ln =~ /^(.*)(\\begin{figure})(.*)$/) {
      $prefc .= "$1$2$3\n";
      print STDERR "push f\n";
      push @imst,'f'
    }
    elsif($ln =~ /^(.*)(\\end{figure)(.*)$/) {
      $prefc .= "$1$2$3\n";
      my $t = pop @imst;
      print STDERR "pop $t\n";
    }
    elsif($ln =~ /^(.*)(\\subfigure\[[^\]]*\]\{)(.*)$/) {
      $prefc .= "$1$2$4\n";
      push @imst,'s';
      print STDERR "push s\n"
    }
    elsif($ln =~ /^(.*)(\\figlab{(?<lbl>[^}]*)}|\\label{fig:(?<lbl>[^}]*)})(.*)$/) {
      $pstfc .= $1;
      if($tikzc) {
        my $lbl=normLabel($+{lbl});
        print "$prefc\e[31m$tikzc\e[0m$pstfc\e[32m$2\e[0m$5\n\e[4;7mSplit off to \"$lbl\" [rysn?]?\e[0m";
        my $ans = <STDIN>;
        my $cnt  = 1;
        while($cnt) {
          given($ans) {
            when (/^\?$/) {print "Options:\n  r  rename label\n  y  yes, insert as figure\n  s  yes, insert as subfigure\n  n  no, do not extract\n  ?  show help\n" }
            when (/^r$/) {print "\e[4;7mPlease enter a new label?\e[0m "; $lbl=<STDIN>}
            when (/^n$/) {print $ou "$prefc$tikzc$pstfc$2$5"; $tikzc="";$pstfc="";$cnt=0}
            default { print "Unknown command... Please retry\n" }
          }
          if($cnt) {
            print "\e[4;7mEnter new command?\e[0m ";
            $ans = <STDIN>;
          }
        }
        $prefc="";
      }
      #print "FOUND LABEL ".$+{lbl};
      #if($tikzc) {
        #print " CAN EMIT";
        #$tikzc="";
      #}
    } else {
      $prefc .= $tikzc.$pstfc;
    }
    $pstfc="";
    $tikzc="";
    $ln =~ /^(.*?)(\\begin{tikzpicture}.*)?$/;
    $prefc .= "$1";
    if($2) {
      $tikzc = "$2\n";
      $tikz=1
    } else {
      $prefc .= "\n";
    }
  }
}
print $ou "$prefc$tikzc$pstfc$2$5";
print STDERR @imst
