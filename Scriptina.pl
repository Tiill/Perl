#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $target_file_name = 'newsletter';
my $target_file_path = './newsletters/';
my $ban_file_name = 'ban_list';
my $ban_file_path = './etc/';
my @ban_array = _get_ban_list($ban_file_name, $ban_file_path);
my $minimal_count = 2;
my $input_text = '';
my %all_words;
my $words_count;

if (!open TARGET_FILE, '<', $target_file_path . $target_file_name) {
    print "File $target_file_path$target_file_name not exist!\n";
    exit;
}
while (my $line = <TARGET_FILE>) {
    chomp($line);
    $input_text = $input_text . $line;
}
my @words_array = split(/[\s.,!?:"]+/, $input_text);
foreach my $cur_word (@words_array) {
    if (!($cur_word =~ /\w+/)) {
        next;
    }
    $words_count++;
    if (!_check_word($cur_word)) {
        print "Invalid word:$cur_word\n";
        next;
    }
    if (!exists($all_words{$cur_word})) {
        $all_words{$cur_word} = 1;
    }
    else {
        $all_words{$cur_word} = $all_words{$cur_word} + 1;
    }
}
for my $cur_word (sort {$all_words{$b} <=> $all_words{$a}} keys %all_words) {
    if ($all_words{$cur_word} < $minimal_count) {
        next;
    }
    print "$cur_word=$all_words{$cur_word}\n";
}
print "All words count: $words_count.\n";
close TARGET_FILE;

sub _check_word {
    my $word = $_[0];
    for my $invalid_word (@ban_array) {
        if (lc($word) eq lc($invalid_word)) {
            return 0;
        }
    }
    return 1;
}

sub _get_ban_list {
    my ($ban_file_name, $ban_file_path) = @_;
    my @ban_list;
    if (!open BAN_FILE, '<', $ban_file_path . $ban_file_name) {
        print "Ban file not exist $ban_file_path$ban_file_name .\n";
        return;
    }
    while (my $line = <BAN_FILE>) {
        chomp $line;
        push @ban_list, $line;
    }
    close BAN_FILE;
    return @ban_list;
}