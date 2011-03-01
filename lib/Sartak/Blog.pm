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

    $out = markdown($out);

    # [Module::Name] but not [1]
    $out =~ s{\[((?!\d+\])\w+(::\w+)*)\]}{<a href="http://p3rl.org/$1">$1</a>}g;

    $out =~ s/ -- / &mdash; /g;

    # remove extraneous whitespace
    chomp $out;
    $out =~ s/^<p>//;
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
            a { name is "footnote_$anchor" };
            span {
                class is 'footnote_content';
                $code->();
            }
            sup {
                a {
                    href is "#footnote_back_$anchor";
                    class is 'footnote_link_top';
                    '&#8617;'; # LEFTWARDS ARROW WITH HOOK
                }
            }
        };

        sup {
            a {
                class is 'footnote_link';
                href is "#footnote_$anchor";
                name is "footnote_back_$anchor";
                "[$anchor]";
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

    pre {
        class is "$type code_snippet";
        my $syntax = Text::VimColor->new(
            string   => $code,
            filetype => $type,
        );

        my $html = $syntax->html;
        chomp $html;
        outs_raw $html;
    }
}

sub perl {
    code_snippet('perl', @_);
}

sub image {
    my ($file, $alt) = @_;
    img {
        src is "http://sartak.org/misc/blog/$file";
        alt is $alt;
    }
}

sub print_footnotes {
    if (@footnotes) {
        h5 { "Footnotes" }
        hr {}
        ol {
            class is 'footnotes';
            while (local $_ = shift @footnotes) {
                li { class is 'footnote'; $_->() };
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

