#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use File::Slurp 'slurp';
use File::Path 'make_path';
use Text::MultiMarkdown 'markdown';
use autodie;
use Encode;
use Sartak::Blog::Talks;
use Text::Handlebars;
use Unicode::Normalize qw/NFD NFC/;
use List::MoreUtils 'uniq';

my $title = 'Shawn M Moore';
my $outdir = shift || 'generated';

make_path $outdir unless -d $outdir;

my %layout = (
    en => scalar(slurp 'layout.en.html'),
    ja => scalar(slurp 'layout.ja.html'),
);

my @months = qw/
    Nulluary January February March April May June July
    August September October November December
/;

my $css_sha;

sub prettify_date {
    my $date = shift;
    my $lang = shift;

    my ($y, $m, $d) = split '-', $date;

    return "$y年$m月$d日" if $lang eq 'ja';
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

sub read_content_md {
    my $file = shift;
    my $content = slurp $file;

    my $headers;
    $headers .= $1 while $content =~ s/^(\w+: .+\n)//;

    my $md = markdown($content);

    # ugh
    $md =~ s{<\s*p\s*>\s*<\s*figure}{<figure}gi;
    $md =~ s{<\s*/\s*figure\s*>\s*<\s*/\s*p\s*>}{</figure>}gi;

    return $headers . $md;
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

    my $date = prettify_date($headers{date}, 'en');

    $content = qq[
        <header>
            <span id="date">$date</span>
            <h1 id="title">$headers{title}</h1>
        </header>
        <article>
            $content
        </article>
    ];

    if ($headers{cover}) {
        $content = qq[
        <img id="cover" src="$headers{cover}">
        $content
        ];
    }

    $headers{content} = $content;

    return \%headers;
}

my $hbs = Text::Handlebars->new(
    helpers => {
        now => sub { scalar gmtime },
    },
);

sub fill_in {
    my $template = shift;
    my $vars     = shift;

    $vars->{rss} ||= '/rss.xml';
    $vars->{css_sha} ||= $css_sha
        or die "No CSS sha yet??";

    return $hbs->render_string($template, $vars);
}

sub titleify {
    my $orig = shift;
    my $title = lc $orig;
    $title =~ s/<.*?>//g;
    $title =~ s/'s\b/s/g;
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

sub generate_css {
    my $output = `sha1sum static/style.css`;
    ($css_sha) = $output =~ /^(\w+) /;
    die "Can't extract CSS sha from: $output" if !$css_sha;

    system("cp -r static/style.css $outdir/$css_sha.css");
}

generate_css();

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

    $article->{basename} ||= titleify($article->{title});
    $article->{file} = $article->{dir} . $article->{basename} . '.html';
    $article->{url} = $article->{external} || "http://sartak.org/$article->{file}";

    if ($article->{external}) {
        $article->{description} = qq{<p>This article was published at <a href="$article->{external}"</a></p>};
    }

    push @{ $articles{ $article->{date} } }, $article;
}

my @articles = map { @{ $articles{$_} } } reverse sort keys %articles;
sub each_article (&) {
    my $code = shift;

    my @articles = grep { !$_->{draft} } @articles;
    $code->($_) for @articles;
}

each_article {
    my $article = shift;
    generate_article($article);
};

generate_index('en');
generate_index('ja');
generate_drafts();
generate_page(lang => 'en', page => 'about', title_tag => 'About Me');
generate_page(lang => 'ja', page => 'about', title_tag => '自己紹介');
generate_page(lang => 'en', page => 'projects', title_tag => 'Projects');
generate_page(lang => 'ja', page => 'projects', title_tag => '開発');
generate_talks();
generate_rss();
generate_talk_rss();
generate_static();

sub generate_article {
    my $article = shift;

    $article->{content} = qq[
        <div id="post">
            $article->{content}
        </div>
    ];

    $article->{title_tag} = $article->{title};
    $article->{title_tag} =~ s/<.*?>//g;
    my $html = fill_in($layout{en}, $article);

    make_path "$outdir/$article->{dir}";

    for my $file (uniq(NFD($article->{file}), NFC($article->{file}))) {
        open my $handle, '>', "$outdir/$article->{file}";
        print $handle $html;
    }
}

sub generate_index {
    my $lang = shift;

    my $posts;
    my $new_year;

    each_article {
        my $article = shift;

        return if $article->{noindex};

        my $date = prettify_date($article->{date}, $lang);
        my $sigil = $article->{external} ? ' <span class="external">⤴</span> ' : "";
        my $li_class = "";

        my ($year) = $article->{date} =~ /^(\d\d\d\d)-/;
        if (defined($new_year) && $year != $new_year) {
            $li_class .= " new-year";
        }
        $new_year = $year;

        $posts .= qq[<li class="$li_class">
    <span class="date">$date</span>
    <span class="title"><a href="$article->{url}">$article->{title}</a>$sigil</span>
</li>];
    };

    $posts = qq[<ul id="posts">$posts</ul>];

    my $file = $lang eq 'ja' ? "$outdir/index.ja.html" : "$outdir/index.html";

    open my $handle, '>', $file;
    print $handle fill_in($layout{$lang}, {
        content   => $posts,
        title     => $title,
        title_tag => 'sartak.org',
        index     => 1,
    });
}

sub generate_drafts {
    my $posts = '';
    for my $article (grep { $_->{draft} } @articles) {
        generate_article($article);

        next if $article->{noindex};

        my $date = prettify_date($article->{date}, 'en');
        $posts .= qq[<li>
    <span class="date">$date</span>
    <span class="title"><a href="$article->{url}">$article->{title}</a></span>
</li>];
    };

    $posts = qq[<ul id="posts">$posts</ul>];

    open my $handle, '>', "$outdir/drafts/index.html";
    print $handle fill_in($layout{en}, {
        content   => $posts,
        title     => $title,
        title_tag => 'sartak.org',
    });
}

sub generate_page {
    my %args = @_;

    my $file = $args{lang} eq 'ja' ? "$outdir/$args{page}.ja.html" : "$outdir/$args{page}.html";
    open my $handle, '>', $file;
    print $handle fill_in($layout{$args{lang}}, {
        content => scalar slurp("$args{page}.$args{lang}.html"),
        %args,
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
        print $handle fill_in($layout{en}, {
            content   => $page->{content},
            title     => $title,
            title_tag => 'sartak.org',
            rss       => '/talks/rss.xml',
        });
    }

    open my $handle, '>', "$outdir/talks/index.html";
    print $handle fill_in($layout{en}, {
        content   => Sartak::Blog::Talks->generate_talks_html,
        title     => 'sartak.org',
        title_tag => 'sartak.org',
        rss       => '/talks/rss.xml',
    });
}

sub generate_rss {
    require XML::RSS;

    my $feed = XML::RSS->new(version => '2.0');
    $feed->channel(
        title => $title,
        link  => 'http://sartak.org',
    );

    my @articles;

    each_article {
        my $article = shift;
        next if $article->{noindex};
        push @articles, $article;
    };

    for my $talk (Sartak::Blog::Talks->talks) {
        push @articles, $talk;
    }

    @articles = sort { $b->{date} cmp $a->{date} } @articles;
    splice @articles, 10;

    for my $article (@articles) {
        $feed->add_item(
            title       => decode_utf8($article->{title} || $article->{name}),
            link        => $article->{url},
            description => decode_utf8($article->{original} || $article->{description}),
            permaLink   => $article->{url},
            dc          => {
                date    => $article->{date},
                author  => 'Shawn M Moore',
            },
        );
    };

    $feed->save("$outdir/rss.xml");
}

sub generate_talk_rss {
    require XML::RSS;

    my $feed = XML::RSS->new(version => '1.0');
    $feed->channel(
        title => 'Sartak Talks',
        link  => 'http://sartak.org/talks',
    );

    my @talks = Sartak::Blog::Talks->talks;
    splice @talks, 10;

    for my $talk (@talks) {
        $feed->add_item(
            title       => decode_utf8($talk->{name}),
            link        => "http://sartak.org" . $talk->{url},
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
