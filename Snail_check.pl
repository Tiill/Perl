#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';


my $debt = 180;
my $snail = 8;
my $sprint = 50;

print "Snail get work for days: ";
printf '%d', check($debt, $snail, $sprint);


sub check{
    my ($debt, $snail_vel, $tasks_in_sprint) = @_;
    return $debt/(($snail_vel-($tasks_in_sprint/10))-0.0000001);
}