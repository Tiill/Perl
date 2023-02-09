package tools;
use strict;
use warnings FATAL => 'all';

sub read_conf {
    my ($file_name) = @_;
    if (!open CON_FILE, '<', $file_name) {
        die "File \"$file_name\" not open. Error $!";
    }

    my %user_pass;
    while (my $line = <CON_FILE>) {
        chomp($line);
        $line =~ s/\s//g;
        if ($line =~ /^#/) {
            next;
        }
        if (!($line =~ /.+=.+/)) {
            next;
        }
        my ($key_conf, $val_conf) = split '=', $line;
        $user_pass{$key_conf} = $val_conf;
    }
    close CON_FILE;
    return %user_pass;
}

sub read_users {
    my ($file_name) = @_;
    if (!open USERS_FILE, '<', $file_name) {
        print "Can`t open file [$file_name].\n";
        return;
    }
    my @users;
    while (my $user = <USERS_FILE>) {
        chomp($user);
        $user =~ s/\s//g;
        push(@users, $user);
    }
    close USERS_FILE;
    return @users;
}

sub add_user {
    my($file_name, $new_user) = @_;
    my @users = read_users($file_name);
    my $is_exist = 0;
    for my $cur_user (@users){
        if($cur_user eq $new_user){
            $is_exist = 1;
            print "User [$new_user] is exist.\n";
            return 0;
        }
    }
    if (!open USERS_FILE, '>>', $file_name) {
        print "Can`t open file [$file_name].\n";
        return 0;
    }
    print USERS_FILE  "$new_user\n" ;
    close USER_FILE;
    return 1;
}

sub remove_user{
    my($file_name, $rem_user) = @_;
    my @users = read_users($file_name, $rem_user);
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