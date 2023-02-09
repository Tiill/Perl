#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my %result_hash = tools::read_conf ('ConfigTest');
print %result_hash;
