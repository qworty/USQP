#!/usr/bin/perl 
use strict;
use warnings FATAL=>'all';

#use DBI;
use CGI;

my $cgi = new CGI;
my @buffer;

my %grid_size = (
	'x' => 30,
	'y' => 30,
	);

my @grid;

site($cgi->header());
site(printHeader());

randomWalls(300);

buildGrid();

site(printFooter());

printSite();

sub randomWalls{
	my $amount  = $_[0];
	my @walls;
	for(my $wall_nr = 0; $wall_nr <= $amount; $wall_nr++){
		$grid[int(rand($grid_size{'x'}))][int(rand($grid_size{'y'}))] = 'wall';
	} 
}

sub buildGrid{
	site('<div style="background-color:black;">');
	for(my $x = 0; $x < $grid_size{'x'}; $x++){
		site('<div style="width:'.$grid_size{'x'}*10.'">');
		for(my $y = 0; $y < $grid_size{'y'}; $y++){
			if(!defined($grid[$x][$y])){
				site('<div style="height:10px;width:10px;display:inline-block;background-color:white;"></div>');
			} elsif($grid[$x][$y] eq 'wall'){
				site('<div style="height:10px;width:10px;background-color:grey;display:inline-block;"></div>');
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
