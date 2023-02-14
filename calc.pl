#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $result;
my $operation;
my $arg_2;
print "First argument: ";
while (1) {
    my $line = <STDIN>;
    chomp($line);
    if($line =~ /=/){
        exit;
    }
    if(!defined($result)) {
        if (!($line =~ /\d+/)) {
            print 'arg bad\n';
            next;
        }
        $result = $line;
        print "Operation: ";
    }elsif(!defined($operation)){
        if (!($line =~ /[+\-*\/]/)) {
            print 'oper bad\n';
            next;
        }
        $operation = $line;
        print "Second argument: ";
    }elsif(!defined($arg_2)){
        if (!($line =~ /\d+/)) {
            print 'arg2 bad\n';
            next;
        }
        if(($operation =~ /\//) and ($line == 0)){
            print "Divide by zero!\n";
            print "First argument: $result\n";
            print "Second argument: ";
            $operation = undef;
            next;
        }
        $arg_2 = $line;
        $result = calculate($result, $operation, $arg_2);
        $operation = undef;
        $arg_2 = undef;
        print "Result: $result\n";
        print "Operation: ";
    }
}

sub calculate {
    my ($arg_1, $operation, $arg_2) = @_;
    if ($operation eq '+') {
        return $arg_1 + $arg_2;
    }
    elsif ($operation eq '-') {
        return $arg_1 - $arg_2;
    }
    elsif ($operation eq '*') {
        return $arg_1 * $arg_2;
    }
    elsif ($operation eq '/') {
        return $arg_1 / $arg_2;
    }
    else {
        print "Unknown operation $operation.\n";
    }
}