package tools;
use strict;
use warnings FATAL => 'all';

sub get_users {
    my ($file_name) = @_;
    if (!open USERS_FILE, '<', $file_name) {
        print "Can`t open file [$file_name].\n";
        return;
    }
    my %user_pass;
    while (my $line = <USERS_FILE>) {
        chomp($line);
        if (!($line =~ /.+=.+/)) {
            next;
        }
        my ($user_name_file, $passwd_file) = split '=', $line;
            $user_pass{$user_name_file} = $passwd_file;
    }
    close USERS_FILE;
    return %user_pass;
}

sub get_one_user {
    my ($file_name, $user_name) = @_;
    if (!open USERS_FILE, '<', $file_name) {
        print "Can`t open file [$file_name].\n";
        return;
    }
    my %user_pass;
    while (my $line = <USERS_FILE>) {
        chomp($line);
        if (!($line =~ /.+=.+/)) {
            next;
        }
        my ($user_name_file, $passwd_file) = split '=', $line;
        if ($user_name eq $user_name_file){
            $user_pass{$user_name_file} = $passwd_file;
        }
    }
    close USERS_FILE;
    return %user_pass;
}

sub add_user {
    my($file_name, $new_user, $passwd) = @_;
    my %user_pass = get_one_user($file_name, $new_user);
    if(%user_pass > 0){
        print "User [$new_user] is exist.\n";
    }
    if (!open USERS_FILE, '>>', $file_name) {
        print "Can`t open file [$file_name].\n";
        return 0;
    }
    print USERS_FILE  "$new_user=$passwd\n" ;
    close USER_FILE;
    return 1;
}

sub remove_user{
    my($file_name, $rem_user) = @_;
    my @users = get_users($file_name, $rem_user);
    my @new_user;
    my $is_exist = 0;
    for my $cur_user (@users){
        if(!($cur_user eq $rem_user)){
            push @new_user, $cur_user;
        } else{
            $is_exist = 1;
        }
    }
    if(!$is_exist){
        print "User [$rem_user] not exist for remove,\n";
        return 0;
    }
    if (!open USERS_FILE, '>',  $file_name) {
        print "Can`t open file [$file_name].\n";
        return 0;
    }
    for my $cur_user (@new_user){
        print USERS_FILE  "$cur_user\n" ;
    }
    close USER_FILE;
    return 1;
}
1;