#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Scalar::Util;

if (@ARGV != 3) {
    print "Not enough arguments. Must be 3.\n";
    exit;
}

my ($first_num, $second_num, $operation) = ($ARGV[0], $ARGV[1], $ARGV[2]);
my $result_text = 'Result ';
my $answer;
unless (Scalar::Util::looks_like_number($first_num)) {
    print "First operand is not digit \"$first_num\".\n";
    exit;
}
unless (Scalar::Util::looks_like_number($second_num)) {
    print "Second operand is not digit \"$second_num\".\n";
    exit;
}
if ($operation eq 'plus') {
    $answer = $first_num + $second_num;
} elsif ($operation eq 'minus') {
    $answer = $first_num - $second_num;
} elsif ($operation eq 'multiply') {
    $answer = $first_num * $second_num;
} elsif ($operation eq 'divide') {
    if($second_num == 0){
        print 'Can`t divide by zero.\n';
        exit;
    } else{
        $answer = $first_num / $second_num;
    }
} else {
    print "Unknown operation\"$operation\".\n";
    exit;
}

print $result_text . $answer . "\n";