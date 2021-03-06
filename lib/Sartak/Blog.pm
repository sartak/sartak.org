package Sartak::Blog;
use strict;
use warnings;
use Text::MultiMarkdown 'markdown';
use Text::VimColor;
use Template::Declare::Tags;

# Markdown handles this for us
$Template::Declare::Tags::SKIP_XML_ESCAPING = 1;

Template::Declare->init(postprocessor => sub {
    my $out = shift;

    $out = markdown($out, {
        use_metadata => 0,
    });

    # [Module::Name] but not [1]
    $out =~ s{\[((?!\d+\])\w+(::\w+)*)\]}{<a href="http://p3rl.org/$1">$1</a>}g;

    $out =~ s/ -- / &mdash; /g;

    # remove extraneous whitespace
    1 while chomp $out;
    $out =~ s/^<p>// or $out && warn "This apparently did not parse as Markdown: $out\n";
    $out =~ s/<\/p>$//;

    $out
});

my @footnotes;
my $footnotes = 0;
BEGIN {
    create_wrapper footnote => sub {
        my $code = shift;
        my $anchor = ++$footnotes; # closures!

        push @footnotes, sub {
            li {
                id is "fn-$anchor";
                span {
                    $code->();
                }
                sup {
                    a {
                        class is 'footnoteBackLink';
                        href is "#fnr-$anchor";
                        '&#8617;'; # LEFTWARDS ARROW WITH HOOK
                    }
                }
            };
        };

        sup {
            id is "fnr-$anchor";
            a {
                href is "#fn-$anchor";
                $anchor;
            }
        }
    };

    create_wrapper spoiler => sub {
        my $code = shift;
        span {
            class is 'spoiler';
            $code->();
        };
    };
}

sub code_snippet {
    my ($type, $code) = @_;

    1 while chomp $code;

    my $syntax = Text::VimColor->new(
        string   => $code,
        filetype => $type,
    );

    my $html = $syntax->html;

    1 while chomp $html;

    outs_raw qq{<div class="code_container"><pre class="$type code_snippet">$html</pre></div>};
}

sub perl {
    code_snippet('perl', @_);
}

sub image {
    my ($file, $alt) = @_;
    img {
        $file = "/img/blog/$file"
            unless $file =~ m{^https?://};
        src is $file;
        alt is $alt;
    }
}

sub print_footnotes {
    if (@footnotes) {
        div {
            class is 'footnotes';
            hr {};
            ol {
                while (local $_ = shift @footnotes) {
                    $_->();
                }
            }
        }
    }
}

my $imported;
sub import {
    my $class  = shift;
    my $caller = caller;
    $imported = 1;

    strict->import;
    warnings->import;

    # I don't feel like messing with Exporter, Sub::Exporter, etc.
    eval "
        package $caller;
        use Text::MultiMarkdown 'markdown';
        use Template::Declare::Tags;
    ";

    die $@ if $@;

    no strict 'refs';
    for my $export (qw/footnote spoiler code_snippet perl image/) {
        *{$caller.'::'.$export} = $class->can($export);
    }
}

END {
    if ($imported && !$?) {
        print_footnotes();
        Template::Declare->buffer->flush;
    }
}

1;

