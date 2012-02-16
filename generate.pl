#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use File::Slurp 'slurp';
use File::Path 'make_path';
use autodie;
use Encode;
use Sartak::Blog::Talks;

my $title = 'sartak';
my $outdir = shift || 'generated';

make_path $outdir unless -d $outdir;

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
    my $file    = shift;

    my %headers;
    $headers{$1} = $2 while $content =~ s/^(\w+): (.+)\n//;

    $headers{original} = $content;

    if (!$headers{date}) {
        warn "No date for $headers{title}!" if !$headers{draft};
        my (undef,undef,undef,$day,$mon,$year) = localtime((stat($file))[9]);
        $mon++;
        $year += 1900;
        $headers{date} = "$year-$mon-$day";
    }

    my $date = prettify_date($headers{date});

    $content = qq[
        <header>
            <span id="date">$date</span>
            <h1 id="title">$headers{title}</h1>
        </header>
        <article>
            $content
        </article>
    ];

    $headers{content} = $content;

    return \%headers;
}

sub fill_in {
    my $template = shift;
    my $vars     = shift;

    $template =~ s/{now}/scalar gmtime/eg;
    $template =~ s/{(\w+)}/$vars->{$1} || do { warn "Undefined variable $1"; '' }/eg;

    $template =~ s[(title="RSS" href=")/rss.xml(")][$1$vars->{rss}$2]
        if $vars->{rss};

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

while (my $file = glob("published/* writing/*")) {
    my $content = read_content($file);
    my $article = new_article($content, $file);
    next if $article->{skip};

    if ($article->{draft}) {
        $article->{dir} = 'drafts/';
    }
    else {
        $article->{dir} = date_dir($article->{date});
    }

    $article->{file} = $article->{dir} . titleify($article->{title}) . '.html';
    $article->{url} = "http://sartak.org/$article->{file}";

    push @{ $articles{ $article->{date} } }, $article;
}

my @articles = map { @{ $articles{$_} } } reverse sort keys %articles;

sub each_article (&) {
    my $code = shift;

    my @articles = grep { !$_->{draft} } @articles;

    for (my $i = 0; $i < @articles; ++$i) {
        $code->($articles[$i], $articles[$i+1], ($i == 0 ? undef : $articles[$i-1]));
    }
}

sub generate_article {
    my ($article, $prev, $next) = @_;

    my $html = qq[<div id="post">$article->{content}];

    if ($next || $prev) {
        $html .= qq[<footer>];
        $html .= qq[<hr><span id="nextprevlinks">];
        $html .= qq[<a href="$next->{url}" id="nextlink">Next: $next->{title}</a>] if $next;
        $html .= qq[<a href="$prev->{url}" id="prevlink">Previous: $prev->{title}</a>] if $prev;
        $html .= qq[</span>];
        $html .= qq[</footer>];
    }

    $html .= qq[</div>];

    $article->{content} = $html;

    $html = fill_in($layout, $article);

    make_path "$outdir/$article->{dir}";
    open my $handle, '>', "$outdir/$article->{file}";
    print $handle $html;
}

each_article {
    generate_article(@_);
};

generate_index();
generate_drafts();
generate_about();
generate_talks();
#generate_atom();
generate_rss();
generate_talk_rss();
generate_static();

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

    open my $handle, '>', "$outdir/index.html";
    print $handle fill_in($layout, {
        content => $posts,
        title   => $title,
    });
}

sub generate_drafts {
    my $posts = '';
    for my $article (grep { $_->{draft} } @articles) {
        generate_article($article);

        my $date = prettify_date($article->{date});
        $posts .= qq[<li>
    <span class="date">$date</span>
    <span class="title"><a href="$article->{url}">$article->{title}</a></span>
</li>];
    };

    $posts = qq[<ul id="posts">$posts</ul>];

    open my $handle, '>', "$outdir/drafts/index.html";
    print $handle fill_in($layout, {
        content => $posts,
        title   => $title,
    });
}

sub generate_about {
    open my $handle, '>', "$outdir/about.html";
    print $handle fill_in($layout, {
        content => scalar slurp('about.html'),
        title   => 'About Me',
    });
}

sub generate_talks {
    for my $page (Sartak::Blog::Talks->talk_pages) {
        my $talk = $page->{talk};
        next unless $talk->{dir};

        my $dir = "$outdir/talks/$talk->{conference}{dir}/$talk->{dir}";
        make_path($dir);

        # titles sometimes contain HTML
        (my $title = $talk->{name}) =~ s/<.*?>//g;

        open my $handle, '>', "$dir/index.html";
        print $handle fill_in($layout, {
            content => $page->{content},
            title   => $title,
            rss     => '/talks/rss.xml',
        });
    }

    open my $handle, '>', "$outdir/talks/index.html";
    print $handle fill_in($layout, {
        content => Sartak::Blog::Talks->generate_talks_html,
        title   => 'Talks',
        rss     => '/talks/rss.xml',
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

    open my $handle, '>', "$outdir/atom.xml";
    print $handle $feed->as_xml;
}

sub generate_rss {
    use XML::RSS;

    my $feed = XML::RSS->new(version => '1.0');
    $feed->channel(
        title => $title,
        link  => 'http://sartak.org',
    );

    my @articles;

    each_article {
        my $article = shift;
        push @articles, $article;
    };

    for my $talk (Sartak::Blog::Talks->talks) {
        push @articles, $talk;
    }

    for my $article (sort { $a->{date} cmp $b->{date} } @articles) {
        $feed->add_item(
            title       => decode_utf8($article->{title} || $article->{name}),
            link        => $article->{url},
            description => decode_utf8($article->{original} || $article->{description}),
            dc          => {
                date    => $article->{date},
                author  => 'Shawn M Moore',
            },
        );
    };

    $feed->save("$outdir/rss.xml");
}

sub generate_talk_rss {
    use XML::RSS;

    my $feed = XML::RSS->new(version => '1.0');
    $feed->channel(
        title => 'Sartak Talks',
        link  => 'http://sartak.org/talks',
    );

    for my $talk (Sartak::Blog::Talks->talks) {
        $feed->add_item(
            title       => decode_utf8($talk->{name}),
            link        => $talk->{url},
            description => decode_utf8($talk->{description}),
            dc          => {
                date    => $talk->{date},
                author  => 'Shawn M Moore',
            },
        );
    };

    $feed->save("$outdir/talks/rss.xml");
}

sub generate_static {
    system("cp -r static/* $outdir/");
}
