#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $result;
my $operation;
my $arg_2;
my $history = '';
my $add_history;
print 'First argument: ';
while (1) {
    my $line = <STDIN>;
    chomp($line);
    if ($line =~ /=/) {
        if (!defined($result)) {
            print 'First argument: ';
            next;
        }
        print "\033[2J";
        print "\033[1; 0H";
        print $history . "=$result" . "\n";
        $operation = undef;
        $arg_2 = undef;
        $history = "$result";
        print "First argument: $result\nOperation: ";
        next;
    }
    if (!defined($result)) {
        if (!($line =~ /^\d+$/)) {
            print "arg bad\n";
            next;
        }
        $result = $line;
        $history = $history . $result;
        print 'Operation: ';
    }
    elsif (!defined($operation)) {
        if (!($line =~ /^[+\-*\/]{1,2}$/)) {
            print "oper bad\n";
            next;
        }
        $operation = $line;
        if ($operation eq '/' or $operation eq '*') {
            $history = '(' . $history . ')';
        }
        $add_history = $operation;
        print 'Second argument: ';
    }
    elsif (!defined($arg_2)) {
        if (!($line =~ /^\d+$/)) {
            print "arg2 bad\n";
            next;
        }
        if (($operation =~ /\//) and ($line == 0)) {
            print "Divide by zero!\n";
            print "First argument: $result\n";
            print 'Second argument: ';
            $operation = undef;
            next;
        }
        $arg_2 = $line;
        $history = $history . $add_history . $arg_2;
        $result = _calculate($result, $operation, $arg_2);
        $operation = undef;
        $arg_2 = undef;
        print "Result: $result\n";
        print 'Operation: ';
    }
}

sub _calculate {
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
        return $arg_1;
    }
}