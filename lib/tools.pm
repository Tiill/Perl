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
        if ($user_name eq $user_name_file) {
            $user_pass{$user_name_file} = $passwd_file;
        }
    }
    close USERS_FILE;
    return %user_pass;
}

sub add_user {
    my ($file_name, $new_user, $passwd) = @_;
    my %user_pass = get_one_user($file_name, $new_user);
    if (%user_pass > 0) {
        print "User [$new_user] is exist.\n";
        return 0;
    }
    if (!passwd_check($passwd)) {
        return 0;
    }
    if (!open USERS_FILE, '>>', $file_name) {
        print "Can`t open file [$file_name].\n";
        return 0;
    }
    print USERS_FILE "$new_user=$passwd\n";
    close USER_FILE;
    return 1;
}

sub remove_user {
    my ($file_name, $rem_user) = @_;
    my %users = get_users($file_name, $rem_user);
    my %new_user;
    my $is_find = 0;
    while (my ($user_name_file, $user_passwd_file) = each %users) {
        if (!($user_name_file eq $rem_user)) {
            $new_user{$user_name_file} = $user_passwd_file;
        }
        else {
            $is_find = 1;
        }
    }
    if (!$is_find) {
        print "User [$rem_user] not exist for remove,\n";
        return 0;
    }
    if (!open USERS_FILE, '>', $file_name) {
        print "Can`t open file [$file_name].\n";
        return 0;
    }
    while (my ($user_name, $passwd) = each %new_user) {
        print USERS_FILE "$user_name=$passwd\n";
    }
    close USER_FILE;
    return 1;
}
sub login_user {
    my ($file_name, $user_name, $passwd) = @_;
    my %find_user = get_one_user($file_name, $user_name);
    if (%find_user == 0) {
        print "User [$user_name] not find.\n";
        return 0;
    }
    if ($passwd eq $find_user{$user_name}) {
        return 1;
    }
    else {
        return 0;
    }
}

sub passwd_check {
    my ($passwd) = @_;
    my $is_valid = 1;
    if($passwd =~ /\s+/){
        print "The password must be without spaces.\n";
        $is_valid = 0;
    }
    if (!($passwd =~ /[\w!-\/]{8,}/)) {
        print "The password must contain at least 8 symbols.\n";
        $is_valid = 0;
    }
    if (!($passwd =~ /[A-Z]+/)) {
        print "The password must contain at least one uppercase letter.\n";
        $is_valid = 0;
    }
    if(!($passwd =~ /^\w/)){
        print "The password must start with a number or letter.\n";
        $is_valid = 0;
    }
    if(!($passwd =~ /\w$/)){
        print "The password must end with a number or letter.\n";
        $is_valid = 0;
    }
    if(!($passwd =~ /[!-\/]+/)){
        print "The password must contain one special character.\n";
        $is_valid = 0;
    }
    return $is_valid;
}

1;