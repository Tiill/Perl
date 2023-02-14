#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my @array = (1, 5, 48, 36, 95, 42, 10, 8, 57, 41, 69, 51, 82, 163, 4, 24, 148, 951, 22, 44, 68, 73, 5);
for my $cur(@array){
    print $cur . ',';
}
print "\n";
@array = sort_array(@array);
for my $cur (@array){
    print $cur . ',';
}
print "\n";

sub sort_array {
    my @src = @_;
    for (my $i = 0; $i < (@src-1); $i++) {
        for (my $j = 0; $j < (@src-$i-1); $j++) {
            if ($src[$j] > $src[$j + 1]) {
                my $tmp = $src[$j];
                $src[$j] = $src[$j + 1];
                $src[$j + 1] = $tmp;
            }
        }
    }
    return @src;
}