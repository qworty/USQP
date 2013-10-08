#!/usr/bin/perl 
use strict;
use warnings FATAL=>'all';

#use DBI;
use CGI;

my $cgi = new CGI;
my @buffer;

my %grid_size = (
	'x' => 4,
	'y' => 4,
	);
my $walls 		= 10;
my $players 	= 3;

my @grid;

site($cgi->header());
site(printHeader());

randomObjects($players, 'player');
randomObjects($walls, 'wall');

buildGrid();

site(printFooter());

printSite();

sub randomObjects{
	my $amount  = $_[0];
	my $object 	= $_[1];
	my @walls;
	for(my $wall_nr = 0; $wall_nr <= $amount; $wall_nr++){
		my $x = int(rand($grid_size{'x'}));
		my $y = int(rand($grid_size{'y'}));
		if(checkObject($x,$y)){
			$grid[$x][$y] = $object;	
		} else {
			$wall_nr --; #try again
		}	
	} 
}

sub checkObject{
	my $x		= $_[0];
	my $y		= $_[1];
	if(defined($grid[$x][$y])){
		return 0;
	} else {
		return 1;
	}
}

sub buildGrid{
	my $width = $grid_size{'x'}*10;
	site('<div style="border:1px solid;text-align:center;width:'.$width.';">');
	for(my $x = 0; $x < $grid_size{'x'}; $x++){
		site('<div>');
		for(my $y = 0; $y < $grid_size{'y'}; $y++){
			if(!defined($grid[$x][$y])){
				site('<div style="height:10px;width:10px;display:inline-block;background-color:white;"></div>');
			} elsif($grid[$x][$y] eq 'wall'){
				site('<div style="height:10px;width:10px;background-color:grey;display:inline-block;"></div>');
			} elsif($grid[$x][$y] eq 'player'){
				site('<div style="height:10px;width:10px;background-color:yellow;display:inline-block;"></div>');
			}
		}
		site('</div>');
	}
	site('</div>');
}

sub printHeader{
  return "<html><head><title></title><style>html{font-family:mono;}</style></head><body>";
}
sub printFooter{
  return "</body></html>";
}
sub site{
  push @buffer, $_[0];
}
sub printSite{
  for my $line(@buffer){
    print $line;
  }
  @buffer = ();
}
