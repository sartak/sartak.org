package Sartak::Blog::Talks;
use strict;
use warnings;

my @talks = (
    {
        name        => 'DTrace: printf debugging for seventh-level wizards',
        dir         => 'dtrace',
        length      => '20 min',
        date        => '2011-10-15',
        speakerdeck => '4ea43e36a0250e005400d9ed',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        video       => 'http://www.youtube.com/watch?v=GccTqjEWAp4',
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2011',
            url     => 'http://yapcasia.org/2011/',
        },
        description => q{DTrace is an extremely powerful tool for examining what a computer is doing. Even in production. Without invoking the ire of the Munin Gods. It's also an indispensible tool for programmers who are trying to debug, optimize, or otherwise investigate what their code is doing when it ventures (and venture it must!) outside of the cozy, warm, abstract world of the Perl interpreter.},
    },
    {
        name        => 'Announcing <i>Announcements</i>',
        dir         => 'announcing-announcements',
        length      => '20 min',
        date        => '2011-06-28',
        speakerdeck => '4ea45036a0250e005100ef01',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2011',
            url     => 'http://www.yapc2011.us/yn2011',
        },
        description => q{Say you&#39;re writing a system that uses the observer design pattern. What happens if instead of passing around the NAME of an event, you pass around an OBJECT representing the event? Turns out, a whole lot of goodness! Announcements enable communication from the observer to the observed, and even communication &#40;and conspiracy&#41; amongst observers themselves. All with a very strongly object-oriented, antler-shaped flavor.},
    },
    {
        name        => 'cpandoc',
        url         => 'http://www.yapc2011.us/yn2011/talk/3519',
        length      => '5 min',
        date        => '2011-06-27',
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2011',
            url     => 'http://www.yapc2011.us/yn2011',
        },
        description => q{This lightning talk was just a live demonstration of cpandoc. No slides, and nothing you wouldn't see in the documentation.},
    },
    {
        name        => 'The Evolution of Path::Dispatcher',
        dir         => 'evolution-of-path-dispatcher',
        length      => '20 min',
        date        => '2010-10-15',
        speakerdeck => '4ea450b7a0250e005400e9fb',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        video       => [
            'http://www.youtube.com/watch?v=fLVTZv4XjgM',
            'http://www.youtube.com/watch?v=SwXrY8yYUgQ',
        ],
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2010',
            url     => 'http://yapcasia.org/2010/',
        },
        description => q{A new-and-improved version of my YAPC::NA talk directly below. This talk has become a case study in Moosey design, describing how the needs of Path::Dispatcher&#39;s users have influenced its evolution. Too many talks present a topic as though the solution sprung fully-formed from the designer&#39;s brain in an instant, ignoring the interesting details of how a system is improved over time. Maybe next conference I&#39;ll present The Evolution of &#39;The Evolution of Path::Dispatcher&#39;, a talk on how to evolve talks after presenting them. :&#41;},
    },
    {
        name        => 'Path::Dispatcher',
        dir         => 'path-dispatcher',
        length      => '20 min',
        date        => '2010-06-23',
        speakerdeck => '4ea450cfaaf429005100fc3a',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2010',
            url     => 'http://yapc2010.com/yn2010/',
        },
        description => q{This talk will give a brief overview of Path::Dispatcher&#39;s features. Then the meat of the talk will describe how its flexible design has met the challenges thrown at it, and how Path::Dispatcher&#39;s sibling rival, Path::Router, would have fared.},
    },
    {
        name        => 'Inline::C',
        dir         => 'inline-c',
        length      => '5 min',
        date        => '2010-05-28',
        speakerdeck => '4ea45109aaf429005100fcad',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        conference  => {
            name    => 'Tsukuba.xs Beer Talks #1',
            dir     => 'tsukuba.xs-1',
            url     => 'http://atnd.org/events/4628',
        },
        description => q{A 5-minute introduction to Inline::C. In Japanese! I wrote the talk in English and then translated it, so English speakers will be able to read it too. :&#41;},
    },
    {
        name        => 'Nonhierarchical OOP',
        dir         => 'nonhierarchical-oop',
        length      => '50 min',
        date        => '2010-04-25',
        speakerdeck => '4ea4511fa0250e005100f060',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        conference  => {
            name    => 'OSDC.tw',
            dir     => 'osdc.tw-2010',
            url     => 'http://osdc.tw/',
        },
        description => q{The current trend for new programming languages seems to be to include more and more nonhierarchical OOP features. Some examples are new-style interfaces in Google&#39;s Go, traits in Scala and Fortress, and roles in Perl 6. This talk will focus on roles as provided by Perl 5&#39;s Moose object system, as that seems to have the most uptake and is most relevant for OSDC.tw&#39;s audience. Furthermore, because of roles&#39; &#34;class building-block&#34; nature, they are perhaps the best fit for open source of any nonhierarchical system thus far.},
    },
    {
        name        => 'Surviving in the Cruel, Unforgiving World',
        url         => 'http://perloasis.org/opw2010/talk/2476',
        length      => '40 min',
        date        => '2010-01-16',
        video       => 'http://www.presentingperl.org/opw2010/cruel-world/',
        conference  => {
            name    => 'Perl Oasis',
            dir     => 'perl-oasis-2010',
            url     => 'http://perloasis.org/',
        },
        description => q{This talk about my NetHack-playing AI was very informal and impromptu. I blathered on about <a href="http://taeb.sartak.org">TAEB</a>&#39;s design, mostly about making proper use of object-oriented design, while TAEB played NetHack on the projector. If I give this talk again I will definitely write slides because there is a lot of good design in TAEB. Without slides I think it bored the people who didn&#39;t know much about NetHack. On the other hand, it <i>enchanted</i> those who did.},
    },
    {
        name        => '(Parameterized) Roles',
        dir         => '(parameterized)-roles',
        length      => '40 min',
        date        => '2009-09-11',
        speakerdeck => '4ea45142aaf429005100fd39',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        video       => 'http://www.nicovideo.jp/watch/sm8674742',
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2009',
            url     => 'http://conferences.yapcasia.org/ya2009/',
        },
        description => q{Roles are an excellent object-oriented tool both for allomorphism and for reuse. Roles can combine with conflict detection. This eliminates accidental shadowing of methods that is painful with multiple inheritance and mixins. Parameterized roles &#40;via MooseX::Role::Parameterized&#41; improve the reusability of roles by letting each consumer cater the role to its needs.},
    },
    {
        name        => 'API Design',
        dir         => 'api-design',
        length      => '40 min',
        date        => '2009-09-10',
        speakerdeck => '4ea45183aaf429005100fdc0',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        video       => 'http://www.nicovideo.jp/watch/sm8627720',
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2009',
            url     => 'http://conferences.yapcasia.org/ya2009/',
        },
        description => q{Too few projects demand good API design as a critical goal. A clean and extensible API will pay for itself many times over in fostering a community of plugins. We certainly cannot anticipate the ways in which our users will bend our modules, but designing an extensible system alleviates the pain. There are many lessons to be learned from Moose, HTTP::Engine and IM::Engine, Dist::Zilla, KiokuDB, Fey, and TAEB.},
    },
    {
        name        => 'Extending Moose for Applications',
        dir         => 'extending-moose',
        length      => '50 min',
        date        => '2009-06-23',
        speakerdeck => '4ea45516ca1be00054000169',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
        ],
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2009',
            url     => 'http://yapc10.org/yn2009/',
        },
        description => q{The real power of Moose rests in its extensibility. By subclassing Moose&#39;s metaclasses, you can augment and change Moose&#39;s behavior to suit your application&#39;s needs. This extensibility is powered by the meta-object protocol of Moose&#39;s foundation, Class::MOP. This talk focuses on domain-specific metaprogramming, particularly with traits.},
    },
    {
        name        => 'Introduction to Moose',
        skip_index  => 1,
        dir         => 'moose',
        length      => '45 min',
        date        => '2009-02-07',
        conference  => {
            name    => 'Frozen Perl',
            dir     => 'frozen-perl-2009',
            url     => 'http://www.frozen-perl.org/mpw2009/',
        },
        description => q{Yet another introductory Moose talk. What separates this from other Moose Intro talks is that it focuses entirely on the immediate time-saving benefits of Moose. No mention of Class::MOP &#40;surely an advanced topic&#41; is made. This talk covers most options of &#39;has&#39;, method modifiers, and roles.},
    },
    {
        name        => 'Devel::REPL',
        skip_index  => 1,
        dir         => 'devel-repl',
        length      => '45 min',
        date        => '2009-02-07',
        conference  => {
            name    => 'Frozen Perl',
            dir     => 'frozen-perl-2009',
            url     => 'http://www.frozen-perl.org/mpw2009/',
        },
        description => q{Devel::REPL is an excellent addition to your toolkit. It is an interactive shell for Perl; you type in a line of Perl code and Devel::REPL will evaluate it. This talk introduces Devel::REPL and Carp::REPL. It then delves into the design of Devel::REPL, and how its strong use of roles cleanly supports extensibility.},
    },
    {
        name        => 'Template::Declare',
        skip_index  => 1,
        dir         => 'template-declare',
        length      => '20 min',
        date        => '2008-02-16',
        conference  => {
            name    => 'Frozen Perl',
            dir     => 'frozen-perl-2008',
            url     => 'http://www.frozen-perl.org/mpw2008/',
        },
        description => q{Template::Declare is a novel templating system written in Perl. &#39;TD&#39; has a very pleasant block-oriented syntax. This talk introduces its features and shortcomings, then describes how it is implemented.},
    },
);

sub generate_talks_html {
    my $output = '';

    $output .= << "    END";
        <div id="talks">
            <dl>
    END

    for my $talk (@talks) {
        my $conference = $talk->{conference};

        my $url = $talk->{url} || "http://sartak.org/talks/$conference->{dir}/$talk->{dir}/";

        my $videos = '';

        if ($talk->{video}) {
            if (ref($talk->{video})) {
                my $i = 0;
                $videos = " (video: "
                        . join(', ',
                            map { ++$i; qq[<a href="$_">part $i</a>] }
                            @{ $talk->{video} })
                        . ")";
            }
            else {
                $videos = qq[ <a href="$talk->{video}">(video)</a>];
            }
        }

        $output .= << "        END";
            <dt><a href="$url">$talk->{name}</a>$videos</dt>
            <dd>
                <span class="metadata">$talk->{length}. Presented at <a href="$conference->{url}">$conference->{name}</a>, $talk->{date}.
                </span>
                <p class="description">$talk->{description}</p>
            </dd>
        END
    }

    $output .= << "    END";
            <hr />
            <p class="license"><div style="text-align: center"><a href="http://creativecommons.org/licenses/by-sa/3.0/us/" rel="license"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/us/88x31.png"/></a></div>These talks are licensed under a <a href="http://creativecommons.org/licenses/by-sa/3.0/us/" rel="license">Creative Commons Attribution-Share Alike 3.0 United States License</a>.</p>
        </div>
    END

    return $output;
}

my %upload = (
    pdf => 'PDF',
    key => 'Keynote source',
);

sub talk_pages {
    my @pages;

    for my $talk (@talks) {
        next if $talk->{skip_index};
        my $page = { talk => $talk };
        my @links = @{ $talk->{links} || [] };

        for (@links) {
            if (my $label = $upload{$_->{type}}) {
                $_->{label} = $label;
                $_->{href} = "http://sartak.org/talks/$talk->{conference}->{dir}/$talk->{dir}/$talk->{dir}.$_->{type}";
            }
        }

        my $slides = "";
        if ($talk->{speakerdeck}) {
            $slides = << "            END";
                <div id="slides">
                    <script src="http://speakerdeck.com/embed/$talk->{speakerdeck}.js"></script>
                </div>
            END
        }

        my $videos = "";
        if ($talk->{video}) {
            if (ref($talk->{video})) {
                my $i = 0;
                push @links, {
                    href  => $_,
                    label => "Video part " . ++$i
                } for @{ $talk->{video} }
            }
            else {
                push @links, {
                    href  => $talk->{video},
                    label => 'Video',
                },
            }
        }

        my $links = '';
        if (@links) {
            $links = '<ul>'
                   . join('',
                       map { qq[<li><a href="$_->{href}">$_->{label}</a></li>] }
                       @links)
                   . '</ul>';
        }

        my $html = << "        END";
            <h2>$talk->{name}</h2>
            $slides
            <p class="description">$talk->{description}</p>
            $links
        END

        $page->{content} = $html;

        push @pages, $page;
    }

    return @pages;
}
