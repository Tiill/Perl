#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $target_file_name = 'newsletter';
my $target_file_path = './newsletters/';
my $ban_file_name = 'ban_list';
my $ban_file_path = './etc/';
my @ba = _get_lines_file($ban_file_name, $ban_file_path);
my %ban_array;
$ban_array{$_}++ for (@ba);
print "all".%ban_array."\n";
my $minimal_count = 2;
my $input_text = '';
my %all_words;
my $words_count;

my @input_lines = _get_lines_file($target_file_name, $target_file_path);
$input_text = join('', @input_lines);
my @words_array = split(/[\s.,!?:"]+/, $input_text);
foreach my $cur_word (@words_array) {
    if (!($cur_word =~ /\w+/)) {
        next;
    }
    $words_count++;
    if (!_check_word($cur_word, %ban_array)) {
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

sub _check_word {
    my ($word, %ban_list) = @_;
    if(exists($ban_list{$word})){
        return 0;
    }
    return 1;
}

sub _get_lines_file {
    my ($file_name, $file_path) = @_;
    my @lines;
    if (!open IN_FILE, '<', $file_path . $file_name) {
        print "File not exist $file_path$file_name .\n";
        return;
    }
    while (my $line = <IN_FILE>) {
        chomp($line);
        push(@lines, $line);
    }
    close IN_FILE;
    return @lines;
}