#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp 'slurp';
use autodie;

system 'rm -rf generated/';
mkdir 'generated';

my $layout = slurp 'layout.html';

sub read_content_html {
    my $file = shift;
    return slurp $file;
}

sub read_content {
    my $file = shift;

    my ($ext) = $file =~ /\.(\w+)$/;

    my $reader = __PACKAGE__->can("read_content_$ext")
        or die "Unable to handle file type $ext for $file";

    return $reader->($file);
}

sub collect_headers {
    my $content = shift;

    my %headers;
    $headers{$1} = $2 while $content =~ s/^(\w+): (.+)\n//;

    $content = qq[<h1>$headers{title}</h1>\n<span class="date">$headers{date}</span>\n$content];

    $headers{content} = $content;

    return \%headers;
}

sub fill_in {
    my $template = shift;
    my $vars     = shift;

    $template =~ s/{(\w+)}/$vars->{$1}/g;

    return $template;
}

sub titleify {
    my $title = lc shift;
    $title =~ s/\W+/-/g;
    $title =~ s/^-//;
    $title =~ s/-$//;
    return $title;
}

my %articles;

while (my $file = glob("articles/*")) {
    my $content = read_content($file);
    my $headers = collect_headers($content);
    my $html = fill_in($layout, $headers);
    my $file = titleify($headers->{title});

    push @{ $articles{ $headers->{date} } }, {
        title => $headers->{title},
        file  => $file,
    };

    open my $handle, '>', "generated/$file.html";
    print $handle $html;
}

my $posts;
for my $date (reverse sort keys %articles) {
    for my $article (@{ $articles{$date} }) {
        $posts .= qq[<li>
    <span class="date">$date</span>
    <span class="title"><a href="$article->{file}.html">$article->{title}</a></span>
</li>];
    }
}

$posts = qq[<ul id="posts">$posts</ul>];

open my $handle, '>', 'generated/index.html';
print $handle fill_in($layout, { content => $posts, title => 'sartak' });

system(cp => 'style.css' => 'generated/');
