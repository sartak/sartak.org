#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp 'slurp';
use File::Path 'make_path';
use autodie;
use Encode;

my $title = 'sartak';

system 'rm -rf generated/';
make_path 'generated';

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
    open my $handle, '-|', "perl -Ilib '$file'";
    return join "", <$handle>;
}

sub read_content {
    my $file = shift;

    my ($ext) = $file =~ /\.(\w+)$/;

    my $reader = __PACKAGE__->can("read_content_$ext")
        or die "Unable to handle file type $ext for $file";

    return $reader->($file);
}

sub new_article {
    my $content = shift;

    my %headers;
    $headers{$1} = $2 while $content =~ s/^(\w+): (.+)\n//;

    $headers{original} = $content;

    my $date = prettify_date($headers{date});

    $content = qq[<span id="date">$date</span>\n<h1 id="title">$headers{title}</h1>\n$content];

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
    my $orig = shift;
    my $title = lc $orig;
    $title =~ s/\W+/-/g;
    $title =~ s/^-//;
    $title =~ s/-$//;

    return lc($orig) if $title eq '';
    return $title;
}

sub date_dir {
    my $date = shift;
    $date =~ s[^(\d{4})-(\d{2})-\d{2}][$1/$2/]
        or die "Invalid date: $date";
    return $date;
}

my %articles;

while (my $file = glob("articles/*")) {
    my $content = read_content($file);
    my $article = new_article($content);
    next if $article->{skip};

    $article->{dir} = date_dir($article->{date});
    $article->{file} = $article->{dir} . titleify($article->{title}) . '.html';
    $article->{url} = "http://preview.sartak.org/$article->{file}";

    push @{ $articles{ $article->{date} } }, $article;
}

sub each_article (&) {
    my $code = shift;
    my @articles = map { @{ $articles{$_} } } reverse sort keys %articles;

    @articles = grep { !$_->{draft} } @articles;

    for (my $i = 0; $i < @articles; ++$i) {
        $code->($articles[$i], $articles[$i+1], ($i == 0 ? undef : $articles[$i-1]));
    }
}

sub generate_article {
    my ($article, $prev, $next) = @_;

    my $html = qq[<div id="post">$article->{content}<hr><span id="nextprevlinks">];
    $html .= qq[<a href="$next->{url}" id="nextlink">Next: $next->{title}</a>] if $next;
    $html .= qq[<a href="$prev->{url}" id="prevlink">Previous: $prev->{title}</a>] if $prev;
    $html .= '</span></div>';

    $article->{content} = $html;

    $html = fill_in($layout, $article);

    make_path "generated/$article->{dir}";
    open my $handle, '>', "generated/$article->{file}";
    print $handle $html;
}

each_article {
    generate_article(@_);
};

for my $article (grep { $_->{draft} } @articles) {
    generate_article($article);
}

generate_index();
generate_about();
generate_talks();
#generate_atom();
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

sub generate_talks {
    open my $handle, '>', 'generated/talks.html';
    print $handle fill_in($layout, {
        content => scalar slurp('talks.html'),
        title   => 'Talks',
    });
}

sub generate_atom {
    use XML::Atom::Feed;
    use XML::Atom::Entry;
    use XML::Atom::Person;

    my $feed = XML::Atom::Feed->new(Version => 1.0);
    $feed->title($title);
    $feed->id('http://preview.sartak.org');

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
        link  => 'http://preview.sartak.org',
    );

    each_article {
        my $article = shift;
        $feed->add_item(
            title       => decode_utf8($article->{title}),
            link        => $article->{url},
            description => decode_utf8($article->{original}),
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
