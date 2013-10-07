#!/usr/bin/perl 
use strict;
use warnings FATAL=>'all';

#use DBI;
use CGI;

my $cgi = new CGI;
my @buffer;

my %grid_size = (
	'x' => 100,
	'y' => 100,
	);

my @grid;

site($cgi->header());

randomWalls(1000);

buildGrid();

printSite();

sub randomWalls{
	my $amount  = $_[0];
	my @walls;
	for(my $wall_nr = 0; $wall_nr <= $amount; $wall_nr++){
		$grid[int(rand($grid_size{'x'}))][int(rand($grid_size{'y'}))] = 'wall';
	} 
}

sub buildGrid{
	for(my $x = 0; $x < $grid_size{'x'}; $x++){
		site('</br>');
		for(my $y = 0; $y < $grid_size{'y'}; $y++){
			if(!defined($grid[$x][$y])){
				site('O');
			} elsif($grid[$x][$y] eq 'wall'){
				site('#');
			}
		}
	}
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