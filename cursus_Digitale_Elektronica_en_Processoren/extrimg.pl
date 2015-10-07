#!/usr/bin/env perl

my $fle="chapter_basis_digitaal_ontwerp.tex";
my $tikz=0;
my $tikzc;

while ( <STDIN> ) {
  my $ln = $_;
  $ln =~ /^(.*?)(\\begin{tikzpicture}.*)?$/;
  print "$1\n";
  if($2) {
    $tikzc .= $2;
    $tikz=1
  }
}
