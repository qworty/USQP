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

my %players;
site($cgi->header());
site("foo bar test");
%players = selectPlayers();
for my $player(keys(%players)){
  site("$player -> $players{$player}");
}
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
  my $sth_players = $dbh->prepare("select * from users");
  $sth_players->execute();
  while(my $player = $sth_players->fetchrow_hashref() ){
    $players{$player->{id}} = $player;
    site("<pre>");
    site($player->{id});
    site(Dumper $player);
    site("</pre>");
  }
  return %players;
}

sub setWalls{

}

sub initPlayer{
  my $userid = $_[0];
  my $x = $_[1];
  my $y = $_[2];
  my $life = $_[3];
  my $shield = $_[4];
  my $init_player = $dbh->prepare("insert into progress (userid,round,turn,life,shield,x,y) value(?,?,?,?,?,?,?)");
  $init_player->execute($userid,0,0,$life,$shield,$x,$y);
}

sub movePlayer{
  my $userid = $_[0];
  my $x = $_[1];
  my $y = $_[2];
  my $life = $_[3];
  my $shield = $_[4];
  my $action = $_[5];
  my $round = $_[6];
  my $turn = $_[7];
  my $move_player = $dbh->prepare("insert into progress (userid,round,turn,life,shield,x,y,action) value(?,?,?,?,?,?,?,?)");
  $move_player->execute($userid,$round,$turn,$life,$shield,$x,$y,$action);
}
