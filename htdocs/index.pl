#!/usr/bin/perl
use strict;
use warnings FATAL=>'all';
use DBI;
use CGI;
use XML::Simple;
use CGI::Session;
use Data::Dumper;
my $cgi = new CGI;
my $session = CGI::Session->new or die CGI::Session->errstr;
my $xml = new XML::Simple;
$0 =~ m|(.*?)/|;
my $path = $1;
my @buffer;
my $xmlparse = $xml->XMLin("db.xml");
my %db;
$db{db} = $xmlparse->{database}{name};
$db{host} = $xmlparse->{database}{host};
$db{user} = $xmlparse->{database}{read}{user};
$db{pass} = $xmlparse->{database}{read}{password};
my %vars = $cgi->Vars;
my %text;
my ($null, @request) = split("/",$ENV{REQUEST_URI});
my $dbh = DBI->connect("DBI:mysql:database=$db{db};host=$db{host}","$db{user}", "$db{pass}", {'RaiseError' => 1}) or die "No connection was made with the mysql: $db{db} database";

site($cgi->header());
site("foo bar test");
my %players = selectPlayers();
site(Dumper %players);
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


sub selectPlayers{
  my %players;
  my $sth_players = $dbh->prepare("select * from users");
  print $sth_players->execute();
  while(my $player = $sth_players->fetchrow_hashref() ){
    $players{$player->{id}} = $player;
  }
  return %players;
}
