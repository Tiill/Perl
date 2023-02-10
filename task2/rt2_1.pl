#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use tools;

my @result = tools::get_users ('users');
print @result;
tools::add_user('users', 'super');
tools::remove_user('users', 'super');
