#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp 'slurp';
use autodie;

system 'rm -rf generated/';
mkdir 'generated';

my $layout = slurp 'layout.html';

while (my $file = glob("articles/*")) {
    my ($ext) = $file =~ /\.(\w+)$/;

    my $content;

    if ($ext eq 'html') {
        $content = slurp $file;
    }
    elsif ($ext eq 'pl') {
    }
    else {
        die "Unable to handle file type $ext for $file";
    }

    my %headers;
    $headers{$1} = $2 while $content =~ s/^(\w+): (.+)\n//;

    $content = qq[<h1>$headers{title}</h1>\n<span class="date">$headers{date}</span>\n$content];

    $headers{content} = $content;

    my $html = $layout;
    $html =~ s/{(\w+)}/$headers{$1}/g;

    my $title = lc $headers{title};
    $title =~ s/\W+/-/g;
    $title =~ s/^-//;
    $title =~ s/-$//;

    open my $handle, '>', "generated/$title.html";
    print $handle $html;
}

