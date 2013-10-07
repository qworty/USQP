#!/usr/bin/perl 
use strict;
use warnings FATAL=>'all';

$grid_size = 100;

@grid;

sub random_walls{
	my $amount  = $_[0];
	my @walls;
	for(my $wall_nr = 0; $wall_nr <= $amount; $wall_nr++){
		$grid[int(rand($grid_size))][int(rand($grid_size))] = 'wall';
	} 
}