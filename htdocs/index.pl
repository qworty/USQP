#!/usr/bin/perl
use strict;
use warnings FATAL=>'all';
use DBI;
use CGI;

my $cgi = new CGI;
my @buffer;

site($cgi->header());

site("foo bar test");

printSite();

sub site{
  push @buffer, $_[0];
}
sub printSite{
  for my $line(@buffer){
    print $line;
  }
  @buffer = ();
}
