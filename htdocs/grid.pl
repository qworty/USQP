#!/usr/bin/perl 
use strict;
use warnings FATAL=>'all';

my $grid_size = 100;

my @grid;

random_walls(1000);

print_grid();

sub random_walls{
	my $amount  = $_[0];
	my @walls;
	for(my $wall_nr = 0; $wall_nr <= $amount; $wall_nr++){
		$grid[int(rand($grid_size))][int(rand($grid_size))] = 'wall';
	} 
}

sub print_grid{
	for(my $x = 0; $x < $grid_size; $x++){
		print "\n";
		for(my $y = 0; $y < $grid_size; $y++){
			if(!defined($grid[$x][$y])){
				print "O";
			} elsif($grid[$x][$y] eq 'wall'){
				print "#";
			}
		}
	}
}