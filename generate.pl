#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp 'slurp';
use autodie;

my $title = 'sartak';

system 'rm -rf generated/';
mkdir 'generated';

my $layout = slurp 'layout.html';

my @months = qw/
    Nulluary January February March April May June July
    August September October November December
/;

sub prettify_date {
    my $date = shift;
    my ($y, $m, $d) = split '-', $date;
    return "$months[$m] $d, $y";
}

sub read_content_html {
    my $file = shift;
    return slurp $file;
}

sub read_content_pl {
    my $file = shift;
    open my $handle, '-|', "perl '$file'";
    return join "", <$handle>;
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

    $headers{original} = $content;

    my $date = prettify_date($headers{date});

    $content = qq[<div id="post"><span id="date">$date</span>\n<h1 id="title">$headers{title}</h1>\n$content</div>];

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
    my $file = titleify($headers->{title}) . '.html';
    $headers->{file} = $file;
    $headers->{url} = "http://sartak.org/$file";

    push @{ $articles{ $headers->{date} } }, $headers;

    open my $handle, '>', "generated/$file";
    print $handle $html;
}

sub each_article (&) {
    my $code = shift;
    for my $date (reverse sort keys %articles) {
        for my $article (@{ $articles{$date} }) {
            $code->($article);
        }
    }
}

generate_index();
generate_about();
generate_atom();
generate_rss();
generate_css();

sub generate_index {
    my $posts;
    each_article {
        my $article = shift;
        my $date = prettify_date($article->{date});
        $posts .= qq[<li>
    <span class="date">$date</span>
    <span class="title"><a href="$article->{url}">$article->{title}</a></span>
</li>];
    };

    $posts = qq[<ul id="posts">$posts</ul>];

    open my $handle, '>', 'generated/index.html';
    print $handle fill_in($layout, {
        content => $posts,
        title   => $title,
    });
}

sub generate_about {
    open my $handle, '>', 'generated/about.html';
    print $handle fill_in($layout, {
        content => scalar slurp('about.html'),
        title   => 'About Me',
    });
}

sub generate_atom {
    use XML::Atom::Feed;
    use XML::Atom::Entry;
    use XML::Atom::Person;

    my $feed = XML::Atom::Feed->new(Version => 1.0);
    $feed->title($title);
    $feed->id('http://sartak.org');

    my $author = XML::Atom::Person->new;
    $author->name('Shawn M Moore');
    $author->email('sartak@gmail.com');
    $feed->author($author);

    each_article {
        my $article = shift;
        my $entry = XML::Atom::Entry->new(Version => 1.0);
        $entry->title($article->{title});
        $entry->content($article->{original});
        $entry->id($article->{url});

        $feed->add_entry($entry);
    };

    open my $handle, '>', 'generated/atom.xml';
    print $handle $feed->as_xml;
}

sub generate_rss {
    use XML::RSS;

    my $feed = XML::RSS->new(version => '1.0');
    $feed->channel(
        title => $title,
        link  => 'http://sartak.org',
    );

    each_article {
        my $article = shift;
        $feed->add_item(
            title       => $article->{title},
            link        => $article->{url},
            description => $article->{original},
            dc          => {
                date => $article->{date},
                author => 'Shawn M Moore',
            },
        );
    };

    $feed->save('generated/rss.xml');
}

sub generate_css {
    system(cp => 'style.css' => 'generated/');
}
