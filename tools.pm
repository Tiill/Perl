package tools;
use strict;
use warnings FATAL => 'all';

sub read_conf{
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
1;