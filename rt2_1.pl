#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use tools;

# my @result = tools::read_users ('users');
# print @result;
tools::remove_user('users', 'super');
