#!/usr/bin/env perl
use strict;

# This script converts an RIS file from either bioRxiv or PubMed (MEDLINE) to
# a GenomeInformatics YML citation file. Note that bioRxiv does not include
# the posting date within the citation file, so it will be necessary to
# manually correct this before committing to the repository. Also be aware of
# any weird formatting chars that may need to be removed afterwards, e.g. &lt;

# Beware that this script doesn't handle wrapped lines, which will occur in
# some verbose MEDLINE title entries.

if ( scalar(@ARGV) != 0 ) {
  die "Usage: $0 < RIS > YML\n";
}

my $tag;
my $value;
my $title = "";
my $author = "";
my $authors = "";
my $doi = "";
my $date = "";
my $journal = "";
my $pubmed = "";

while(<>) {
  if ( /^(\S+)\s*- (.+)/ ) {
    # bioRxiv uses 2 letter tags, MEDLINE uses up to 4
    $tag = $1;
    $value = $2;
    $value =~ s/\r//g;
    if ( $tag eq "PMID" || $tag eq "AN" ) {
      # only in MEDLINE files, used to be PMID now seems to be AN
      $pubmed = $value;
    }
    elsif ( $tag eq "T1" || $tag eq "TI" ) {
      # T1 for bioRxiv and TI for MEDLINE, hahahahaha
      $title = $value;
    }
    elsif ( $tag eq "AU" ) {
      $author = $value;
      if ( !$pubmed ) {
        # MEDLINE is OK, bioRxiv author names need to be reformatted
        $author =~ s/,//;
        my @tokens = split(" ", $author);
        $author = shift(@tokens) . " ";
        foreach my $token (@tokens) {
          $author .= substr($token, 0, 1);
        }
      }
      # append to growing list of authors
      if ( $authors ) {
        $authors .= ", ";
      }
      $authors .= $author;
    }
    elsif ( $tag eq "DO" || $tag eq "LID" ) {
      # MEDLINE includes some junk on the end of the doi to be ignored
      ($doi) = $value =~ /(\S+)/;
    }
    elsif ( $tag eq "Y1" ) {
      # bioRxiv post date (not really, always first of the year)
      $date = $value;
      $date =~ s/\//-/g;
    }
    elsif ( $tag eq "DEP" ) {
      # MEDLINE publication date
      $date = substr($value, 0, 4) .
        "-" . substr($value, 4, 2) .
        "-" . substr($value, 6, 2);
    }
    elsif ( $tag eq "JF" || $tag eq "JT" ) {
      # JF for bioRxiv and JT for MEDLINE
      $journal = $value;
    }
  }
}

# quote title to avoid weird characters that confuse YML
print "title: \"", $title, "\"", "\n";
print "authors: ${authors}\n";
print "text: https://doi.org/${doi}\n";
print "date: \"${date}\"\n";
print "journal: ${journal}\n";
print "pubmed: ${pubmed}\n";
