#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use tools;

my $users_file_name = 'userspass';
my $user_name = $ENV{'user_name'};
my $action = $ENV{'action'};
my $passwd = $ENV{'passwd'};

if(!defined($action)){
    print "action $action is null\n";
    exit;
}
if($action eq 'get'){
    my @users = tools::get_users($users_file_name);
    print "Users:\n";
    for my $cur_user (@users){
        print "User[$cur_user]\n";
    }
}elsif($action eq 'add'){
    if(!defined($user_name)){
        print "Username is null\n";
        exit;
    }
    if(!defined($passwd)){
        print "Password is null\n";
        exit;
    }
    my $result_adding = tools::add_user($users_file_name, $user_name, $passwd);
    if($result_adding){
        print "Add user[$user_name].\n";
    }else{
        print "User [$user_name] not added.\n";
    }
}elsif($action eq 'del'){
    if(!defined($user_name)){
        print "Username is null\n";
        exit;
    }
    my $result_deleting = tools::remove_user($users_file_name, $user_name);
    if($result_deleting){
        print "Del user[$user_name].\n";
    }else{
        print "User [$user_name] not deleted.\n";
    }
}else{
    print "Action [$action] is unknown.\n";
}