#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use POSIX;

my $debt = 187;
my $snail = 8;
my $sprint = 50;

my $result = ceil(_check($debt, $snail, $sprint));
my $result_string = ($result > 0) ? "Справится за $result спринтов" : "Не справится.";
print $result_string;

sub _check {
    my ($debt, $snail_vel, $tasks_in_sprint) = @_;
    return $debt / ((($snail_vel * 10) - $tasks_in_sprint) - 0.0000001);
}