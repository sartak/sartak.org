package Sartak::Blog::Talks;
use strict;
use warnings;

my @talks = (
    {
        name        => 'Right the First Time',
        dir         => 'right-the-first-time',
        length      => '40 min',
        date        => '2015-06-18',
        speakerdeck => 'd5e5bf77b6f4497ab2c431c424c65caf',
        conference  => {
            dir     => 'misc-2015',
        },
        links       => [
            { type => 'key.tar' },
            { type => 'pdf' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/right-the-first-time' },
        ],
        description => q{As software engineers, there is always a strong pressure on us to deliver our code quickly. But that could easily lead to cutting corners which is a false economy that hurts the project, morale, and, ultimately, the organization’s bottom line. Of course, as they say, “‘perfect' is the enemy of ‘done’.”, so this can certainly be taken too far. This talk discusses the tradeoffs of the two extremes, and examine how a healthy balance can be found by being careful and mindful of the code you write. After all, everything from (of course) system architecture all the way down to the names you choose for local variables impacts how easy the project is to maintain, and so is worth consideration.},
    },
    {
        name        => 'Lifting Moose',
        dir         => 'lifting-moose',
        length      => '20 min',
        date        => '2015-06-09',
        video       => 'https://www.youtube.com/watch?v=w9HHHNVrmOs',
        embed       => '<iframe width="560" height="315" src="//www.youtube.com/embed/w9HHHNVrmOs" frameborder="0" allowfullscreen></iframe>',
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2015',
            url     => 'http://www.yapcna.org/yn2015/',
            talk    => 'http://www.yapcna.org/yn2015/talk/6069',
            venue   => 'Little America Hotel',
            city    => 'Salt Lake City',
        },
        links       => [
            { type => 'key.tar' },
            { type => 'pdf' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/lifting-moose' },
        ],
        description => q{Moose is great for creating classes and objects, sure. But if your Moose usage is limited to reducing keystrokes, you're wasting so much potential.

Moose's real power lies in empowering you to create abstractions in the domain of your application. Come find out why you would do this. And how!},
    },
    {
        name        => 'Kindergarten Code',
        dir         => 'kindergarten-code',
        length      => '20 min',
        date        => '2014-11-09',
        video       => 'https://www.youtube.com/watch?v=4sEeqtiLFVU',
        embed       => '<iframe width="560" height="315" src="//www.youtube.com/embed/4sEeqtiLFVU" frameborder="0" allowfullscreen></iframe>',
        conference  => {
            name    => 'PPW',
            dir     => 'ppw-2014',
            url     => 'http://pghpw.org/ppw2014/',
            talk    => 'http://pghpw.org/ppw2014/talk/5786',
            venue   => 'Downtown Doubletree Hotel',
            city    => 'Pittsburgh',
        },
        links       => [
            { type => 'key.tar' },
            { type => 'pdf' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/kindergarten-code' },
        ],
        description => q{Over the years, I've come to understand the qualities that I admire in code. With the help of some of my personal heroes, I'll explain why I strive for "kindergarten code" and how it will make you a better engineer.},
    },
    {
        name        => 'How to be Fluent in Japanese',
        dir         => 'how-to-be-fluent-in-japanese',
        length      => '5 min',
        date        => '2014-06-24',
        video       => 'https://www.youtube.com/watch?v=YJrTaMUvjVA&t=45m40s',
        embed       => '<iframe width="560" height="315" src="//www.youtube.com/embed/YJrTaMUvjVA?start=2740&end=3070" frameborder="0" allowfullscreen></iframe>',
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2014',
            url     => 'http://yapcna.org/yn2014/',
            talk    => 'http://www.yapcna.org/yn2014/talk/5600',
            venue   => 'Hilton DoubleTree',
            city    => 'Orlando',
        },
        links       => [
            { type => 'key.tar' },
            { type => 'pdf' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/how-to-be-fluent-in-japanese' },
        ],
        description => q{Two rules for learning a second language that have guided me to become fluent in Japanese.

And
so
can
you!},
    },
    {
        name        => 'DTrace War Stories',
        dir         => 'dtrace-war-stories',
        length      => '20 min',
        date        => '2014-06-23',
        video       => 'https://www.youtube.com/watch?v=P88qXvU2RUA',
        embed       => '<iframe width="560" height="315" src="//www.youtube.com/embed/P88qXvU2RUA" frameborder="0" allowfullscreen></iframe>',
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2014',
            url     => 'http://yapcna.org/yn2014/',
            talk    => 'http://www.yapcna.org/yn2014/talk/5389',
            venue   => 'Hilton DoubleTree',
            city    => 'Orlando',
        },
        links       => [
            { type => 'key.tar' },
            { type => 'pdf' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/dtrace-war-stories' },
        ],
        description => q{Several stories of how DTrace saved someone's day when *nothing else* could.

    You too can wield this power and be the envy of your community.},
    },
    {
        name        => 'git flux: effective branch management',
        dir         => 'git-flux',
        length      => '20 min',
        date        => '2013-10-05',
        video       => 'http://www.youtube.com/watch?v=pVMIPuQE73U',
        conference  => {
            name    => 'PPW',
            dir     => 'ppw-2013',
            url     => 'http://pghpw.org/ppw2013/',
            talk    => 'http://pghpw.org/ppw2013/talk/5054',
            venue   => 'Pittsburgh Technology Institute',
            city    => 'Pittsburgh',
        },
        links       => [
            { type => 'key' },
            { type => 'pdf' },
        ],
        description => q{<figure><img src="git-flux.png" /></figure>

<a href="/talks/yapc-asia-2013/git-flux/">(日本語版はこちら)</a>

There are a bazillion different ways to use git, which is of course a blessing and a curse. You can use it any way you like, but that puts the burden on you to figure out what's best.

Well we've already done the hard work of figuring out what's best. I'm here to explain how we use git at Infinity Interactive to ship great software to our clients.},
    },
    {
        name        => 'git flux - 結果的なブランチ管理',
        dir         => 'git-flux',
        length      => '20 min',
        date        => '2013-09-21',
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2013',
            url     => 'http://yapcasia.org/2013/',
            talk    => 'http://yapcasia.org/2013/talk/show/e73de9d2-c803-11e2-be2e-7ec06aeab6a4',
            venue   => 'Keio University Hiyoshi Campus',
            city    => 'Kawasaki',
        },
        links       => [
            { type => 'key' },
            { type => 'pdf' },
        ],
        description => q{<figure><img src="git-flux.png" /></figure>

<a href="/talks/ppw-2013/git-flux/">(English version here)</a>

gitこその使い方が多さは例外で、幸福でもあり災いでもありますね。好きな方法を選んでもいいですが、その選ぶ必要はあるから、どのユーザーも自分が、有効に使うことを研究しなければならない責任あるので困ります。
同僚とチームで開発しながら、たくさんブランチ管理システムを使ってみて、このgit fluxというシステムを作りました。
このトークは、gitをうまく利用することでアプリケーションを開発する方法を紹介します。},
    },
    {
        name        => 'git flux',
        dir         => 'git-flux',
        length      => '45 min',
        date        => '2013-04-20',
        conference  => {
            name    => 'DCBPW',
            dir     => 'dcbpw-2013',
            url     => 'http://dcbpw.org/dcbpw2013/',
            talk    => 'http://dcbpw.org/dcbpw2013/talk/4607',
            venue   => 'University of Baltimore',
            city    => 'Baltimore',
        },
        links       => [
            { type => 'key' },
            { type => 'pdf' },
        ],
        description => q{
<strong>Update!</strong> I presented a newer version of this talk at <a href="/talks/ppw-2013/git-flux/">PPW</a>.

<figure><img src="git-flux.png" /></figure>

<a href="/talks/yapc-asia-2013/git-flux/">(日本語版はこちら)</a>

There are a bazillion different ways to use git, which is of course a blessing and a curse. You can use it any way you like, but that puts the burden on you to figure out what's best.

Well we've already done the hard work of figuring out what's best. I'm here to explain how we use git at Infinity Interactive to ship great software to our clients.},
    },
    {
        name        => 'Moose Role Usage Patterns',
        dir         => 'role-usage-patterns',
        length      => '40 min',
        date        => '2012-08-22',
        speakerdeck => '5034ce6c6801700002053899',
        conference  => {
            name    => 'YAPC::EU',
            dir     => 'yapc-eu-2012',
            url     => 'http://act.yapc.eu/ye2012',
            talk    => 'http://act.yapc.eu/ye2012/talk/4150',
            venue   => 'Universität Frankfurt',
            city    => 'Frankfurt',
        },
        links       => [
            { type => 'pdf' },
            { type => 'key' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/moose-role-usage-patterns' },
        ],
        description => q{Roles are one of the most exciting and powerful features provided by Moose, but also one of the most misunderstood. This talk will explore, in depth, some common usage patterns (and antipatterns) for roles and how best to use them in the design of your classes. I will also talk about the philosophy of roles and how they fit in with the larger OO toolset.},
    },
    {
        name        => 'Introduction to Moose',
        skip_index  => 1,
        dir         => 'intro-to-moose',
        length      => '60 min',
        date        => '2012-05-21',
        conference  => {
            dir     => 'misc-2012',
        },
        description => q{An updated version of my 2009 Introduction to Moose talk.},
    },
    {
        name        => 'git-status-tackle',
        dir         => 'git-status-tackle',
        length      => '5 min',
        date        => '2012-06-14',
        speakerdeck => '4fd9f4a817e3000022019f94',
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2012',
            url     => 'http://www.yapcna.org/2012',
            talk    => 'http://act.yapcna.org/2012/talk/173',
            venue   => 'University of Wisconsin',
            city    => 'Madison, Wisconsin',
        },
        links       => [
            { type => 'pdf' },
            { type => 'key' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/git-status-tackle' },
        ],
        description => q{`git status` is verbose almost to the point of uselessness. git-status-tackle is a new suite of tools that tells you exactly what you want to know about your git repository in a very pluggable and configurable way.},
    },
    {
        name        => 'DTrace: printf debugging for seventh-level wizards',
        dir         => 'dtrace',
        length      => '50 min',
        date        => '2012-01-14',
        speakerdeck => '4f11e23cd28ef6001f01198a',
        video       => 'http://www.presentingperl.org/opw2012/dtrace/',
        conference  => {
            name    => 'Perl Oasis',
            dir     => 'perl-oasis-2012',
            url     => 'http://www.perloasis.info/opw2012/',
            talk    => 'http://www.perloasis.info/opw2012/talk/3868',
            venue   => 'The Four Points Sheraton',
            city    => 'Orlando',
        },
        links       => [
            { type => 'pdf' },
            { type => 'key' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/dtrace-printf-debugging-for-seventh-level-wizards' },
        ],
        description => q{<a href="/talks/yapc-asia-2011/dtrace/">(日本語版はこちら)</a>

DTrace is an extremely powerful tool for examining what a computer is doing. Even in production. Without invoking the ire of the Munin Gods.

    It's also an indispensible tool for programmers who are trying to debug, optimize, or otherwise investigate what their code is doing when it ventures (and venture it must!) outside of the cozy, warm, abstract world of the Perl interpreter.

If you tend towards printf debugging, then DTrace lets you break through to some seriously next-level shit. You don't have to pollute your application's code, or even restart it(!), to begin tracing it. You can also trace the execution of other Perl modules you're using, your operating system kernel, and other applications such as MySQL or Apache. It is awesome!

This talk is intended as an introduction to DTrace for those who have maybe heard that it rocks but haven't ever used it. I'll also describe specifically Perl's support for DTrace and how to make use of the probes we've been adding.},
    },
    {
        name        => 'DTrace: 最強な魔法使いのprintfのようなデバッガ',
        dir         => 'dtrace',
        length      => '20 min',
        date        => '2011-10-15',
        speakerdeck => '4ea43e36a0250e005400d9ed',
        links       => [
            { type => 'pdf' },
            { type => 'key' },
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/dtrace-printf' },
        ],
        video       => 'http://www.youtube.com/watch?v=GccTqjEWAp4',
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2011',
            url     => 'http://yapcasia.org/2011/',
            talk    => 'http://yapcasia.org/2011/talk/23',
            venue   => 'Tokyo Institute of Technology',
            city    => 'Tokyo',
        },
        description => q{<a href="/talks/perl-oasis-2012/dtrace/">(English version here)</a>

DTraceは、コンピューターが何を動作していることを調べるために、とても強力なツールです。プロダクションでも使えますよ。ネットワーク監視という神様が怒らず！

    これは、Perlのやさしい世界の厳しい外部でも、デバッグや最適化や監視をするツールです。アプリケーションのコードを汚染していないままで、再起動が必要でなくて、トレースを示す可能があります！しかも、他の使っているモジューでも、カーネルプロセスでも、他のアプリケーションル（例えば:MySQL、Apache）でも、トレースで動作を検査できます。printfのようなデバッグすることが好きの方にとって、DTraceも好きになると思います。

このトークでは、「DTraceはすごすぎるよ！」と聞いたが使ったことがない方のためにDTrace入門です。それ以外で、PerlのDTraceのサポートと、Perlに追加したプローブを説明します。},
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
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/announcing-announcements' },
        ],
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2011',
            url     => 'http://www.yapc2011.us/yn2011',
            talk    => 'http://www.yapc2011.us/yn2011/talk/3197',
            venue   => 'Crowne Plaza Resort',
            city    => 'Asheville',
        },
        description => q{Say you're writing a system that uses the observer design pattern. What happens if instead of passing around the NAME of an event, you pass around an OBJECT representing the event? Turns out, a whole lot of goodness!

    Announcements enable communication from the observer to the observed, and even communication (and conspiracy) amongst observers themselves.

All with a very strongly object-oriented, antler-shaped flavor.},
    },
    {
        name        => 'cpandoc',
        dir         => 'cpandoc',
        url         => 'http://www.yapc2011.us/yn2011/talk/3519',
        length      => '5 min',
        date        => '2011-06-27',
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2011',
            url     => 'http://www.yapc2011.us/yn2011',
            talk    => 'http://www.yapc2011.us/yn2011/talk/3519',
            venue   => 'Crowne Plaza Resort',
            city    => 'Asheville',
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
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/the-evolution-of-pathdispatcher' },
        ],
        video       => [
            'http://www.youtube.com/watch?v=fLVTZv4XjgM',
            'http://www.youtube.com/watch?v=SwXrY8yYUgQ',
        ],
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2010',
            url     => 'http://yapcasia.org/2010/',
            talk    => 'http://yapcasia.org/2010/talks/63D22246-BC8C-11DF-8791-B9FC0F276C45',
            venue   => 'Tokyo Institute of Technology',
            city    => 'Tokyo',
        },
        description => q{A new-and-improved version of my YAPC::NA talk directly below. This talk has become a case study in Moosey design, describing how the needs of Path::Dispatcher's users have influenced its evolution. Too many talks present a topic as though the solution sprung fully-formed from the designer's brain in an instant, ignoring the interesting details of how a system is improved over time. Maybe next conference I'll present The Evolution of "The Evolution of Path::Dispatcher", a talk on how to evolve talks after presenting them. :)},
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
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/pathdispatcher' },
        ],
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2010',
            url     => 'http://yapc2010.com/yn2010/',
            talk    => 'http://yapc2010.com/yn2010/talk/2642',
            venue   => 'Ohio State University',
            city    => 'Columbus',
        },
        description => q{Path::Dispatcher solves the problem of "dispatch" - mapping a string (the path) through a set of rules to find matches and then act upon them. Most commonly this is done in web applications to run one or more actions based on each incoming request URI. However, Path::Dispatcher, unlike most of the other modules in its niche, is not married to the web. It is also used to dispatch based on command-line arguments in some applications, and to dispatch commands in a MUD engine.

    This talk gives a brief overview of Path::Dispatcher's features. Then the meat of the talk describes how its flexible design has met the challenges thrown at it, and how Path::Dispatcher's sibling rival, Path::Router, would have fared.},
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
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/inlinec' },
        ],
        conference  => {
            name    => 'Tsukuba.xs Beer Talks',
            dir     => 'tsukuba.xs-1',
            url     => 'http://atnd.org/events/4628',
            venue   => 'Recruit Media Technology Lab',
            city    => 'Tokyo',
        },
        description => q{A 5-minute introduction to Inline::C. In Japanese! I wrote the talk in English and then translated it, so English speakers will be able to read it too. :)},
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
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/nonhierarchical-oop' },
        ],
        conference  => {
            name    => 'OSDC.tw',
            dir     => 'osdc.tw-2010',
            url     => 'http://osdc.tw/',
            venue   => 'Academia Sinica',
            city    => 'Taipei',
        },
        description => q{The current trend for new programming languages seems to be to include more and more nonhierarchical OOP features. Some examples are new-style interfaces in Google's Go, traits in Scala and Fortress, and roles in Perl 6. This talk will focus on roles as provided by Perl 5's Moose object system, as that seems to have the most uptake and is most relevant for OSDC.tw's audience. Furthermore, because of roles' "class building-block" nature, they are perhaps the best fit for open source of any nonhierarchical system thus far.},
    },
    {
        name        => 'Surviving in the Cruel, Unforgiving World',
        dir         => 'surviving-in-the-cruel-unforgiving-world',
        url         => 'http://www.perloasis.info/opw2010/talk/2476',
        length      => '40 min',
        date        => '2010-01-16',
        video       => 'http://www.presentingperl.org/opw2010/cruel-world/',
        conference  => {
            name    => 'Perl Oasis',
            dir     => 'perl-oasis-2010',
            url     => 'http://www.perloasis.info/opw2010/',
            talk    => 'http://www.perloasis.info/opw2010/talk/2476',
            venue   => 'The Four Points Sheraton',
            city    => 'Orlando',
        },
        description => q{This talk about my NetHack-playing AI was very informal and impromptu. I blathered on about <a href="https://github.com/sartak/TAEB">TAEB</a>'s design, mostly about making proper use of object-oriented design, while TAEB played NetHack on the projector. If I give this talk again I will definitely write slides because there is a lot of good design in TAEB. Without slides I think it bored the people who didn't know much about NetHack. On the other hand, it <i>enchanted</i> those who did.},
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
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/parameterized-roles' },
        ],
        video       => 'http://www.nicovideo.jp/watch/sm8674742',
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2009',
            url     => 'http://conferences.yapcasia.org/ya2009/',
            talk    => 'http://conferences.yapcasia.org/ya2009/talk/2261',
            venue   => 'Tokyo Institute of Technology',
            city    => 'Tokyo',
        },
        description => q{Roles are an excellent object-oriented tool both for allomorphism and for reuse.

    Roles facilitate allomorphism by favoring "does this object do X" versus "is this object a subclass of X". You often care more about capability than inheritance. In a sense, roles encode types better than inheritance.

Roles also provide an excellent faculty for reuse. This effectively eliminates multiple inheritance, which is often the only solution for sharing code between unrelated classes.

Roles can combine with conflict detection. This eliminates accidental shadowing of methods that is painful with multiple inheritance and mixins.

Parameterized roles (via MooseX::Role::Parameterized) improve the reusability of roles by letting each consumer cater the role to its needs. This does sacrifice some allomorphism, but there are ways to restore it.},
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
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/api-design' },
        ],
        video       => 'http://www.nicovideo.jp/watch/sm8627720',
        conference  => {
            name    => 'YAPC::Asia',
            dir     => 'yapc-asia-2009',
            url     => 'http://conferences.yapcasia.org/ya2009/',
            talk    => 'http://conferences.yapcasia.org/ya2009/talk/2188',
            venue   => 'Tokyo Institute of Technology',
            city    => 'Tokyo',
        },
        description => q{Too few projects demand good API design as a critical goal. A clean and extensible API will pay for itself many times over in fostering a community of plugins. We certainly cannot anticipate the ways in which our users will bend our modules, but designing an extensible system alleviates the pain. There are many lessons to be learned from Moose, HTTP::Engine and IM::Engine, Dist::Zilla, KiokuDB, Fey, and TAEB.

    The most important lesson is to decouple the core functionality from the "fluff" such as sugar and middleware. This forces you to have a solid API that ordinary users can extend. This also lets users write their own sugar and middleware. In a tightly-coupled system, there is little hope for extensibility.

In this talk, you will learn how to make very productive use of Moose's roles to form the foundation of a pluggable system. Roles provide excellent means of code reuse and safe composition. I will also demonstrate how to use Sub::Exporter to construct a more useful and flexible sugar layer.

Finally, I will reveal the secret to designing excellent APIs.},
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
            { label => 'Speakerdeck', href => 'https://speakerdeck.com/sartak/extending-moose-for-applications' },
        ],
        conference  => {
            name    => 'YAPC::NA',
            dir     => 'yapc-na-2009',
            url     => 'http://yapc10.org/yn2009/',
            talk    => 'http://yapc10.org/yn2009/talk/1880',
            venue   => 'Carnegie Mellon University',
            city    => 'Pittsburgh',
        },
        description => q{Using Moose provides many immediate and obvious benefits, starting with the obviation of typing "use strict" and "use warnings" in your classes.

    The real power of Moose, however, rests in its extensibility. By subclassing Moose's metaclasses, you can augment and change Moose's behavior to suit your application's needs. This extensibility is powered by the meta-object protocol of Moose's foundation, Class::MOP.

The motivating example for extending Moose will be the creation of a small web framework to empower a Twitter-alike. The focus will be creating meta-level roles so that metaclasses may select exactly which changes in behavior they wish to exhibit. Modules that will be used include Moose::Exporter (to define sugary keywords) and Moose::Util::MetaRole (to extend classes composably).

Experience with using Moose to create regular classes is expected. Having some familiarity with roles will let you get more out of the talk. No experience with metaprogramming is required.},
    },
    {
        name        => 'Introduction to Moose',
        dir         => 'moose',
        length      => '45 min',
        date        => '2009-02-07',
        conference  => {
            name    => 'Frozen Perl',
            dir     => 'frozen-perl-2009',
            url     => 'http://www.frozen-perl.org/mpw2009/',
            talk    => 'http://www.frozen-perl.org/mpw2009/talk/1687',
            venue   => 'University of Minnesota',
            city    => 'Minneapolis',
        },
        description => q{Yet another introductory Moose talk. What separates this from other Moose Intro talks is that it focuses entirely on the immediate time-saving benefits of Moose. No mention of Class::MOP (surely an advanced topic) is made. This talk covers most options of "has", method modifiers, and roles.},
    },
    {
        name        => 'Devel::REPL and Carp::REPL',
        dir         => 'devel-repl',
        length      => '45 min',
        date        => '2009-02-07',
        conference  => {
            name    => 'Frozen Perl',
            dir     => 'frozen-perl-2009',
            url     => 'http://www.frozen-perl.org/mpw2009/',
            talk    => 'http://www.frozen-perl.org/mpw2009/talk/1663',
            venue   => 'University of Minnesota',
            city    => 'Minneapolis',
        },
        description => q{Devel::REPL is an excellent addition to your toolkit. It is an interactive shell for Perl; you type in a line of Perl code and Devel::REPL will evaluate it. You can use Devel::REPL to quickly test out code or to provide a debugging shell for your applications. There are many plugins, such as simply adding color, nopasting your session to a pastebin, and even dumping each line of code with B::Concise.

Carp::REPL builds on top of Devel::REPL to make finding bugs easier. By default, when an exception is thrown, you get a shell (though you can tweak this to get a shell on any warning or test failure). You can examine and change variables, call and redefine functions, and anything else you can do with real Perl code. Carp::REPL lets you have a shell "inside" your applications with *zero* code changes required.

Matt Trout's design for Devel::REPL is worthy of study. It is a Moose library that makes heavy use of roles to provide a great deal of customization for users. Sans plugins, Devel::REPL is just about the simplest implementation of a shell, but that just means it has the greatest amount of flexibility. This final part of the talk will be case study in the design and implementation of a nontrivial Moose application.},
    },
    {
        name        => 'Template::Declare',
        dir         => 'template-declare',
        length      => '20 min',
        date        => '2008-02-16',
        conference  => {
            name    => 'Frozen Perl',
            dir     => 'frozen-perl-2008',
            url     => 'http://www.frozen-perl.org/mpw2008/',
            talk    => 'http://www.frozen-perl.org/mpw2008/talk/858',
            venue   => 'University of Minnesota',
            city    => 'Minneapolis',
        },
        description => q{Template::Declare is a novel templating system written in Perl. "TD" has a very pleasant block-oriented syntax. This talk introduces its features and shortcomings, then describes how it is implemented.},
    },
);

for (@talks) {
    $_->{url} = "/talks/$_->{conference}{dir}/$_->{dir}/";
    $_->{description} =~ s{([^\n]+)}{<p>$1</p>}g;
}

sub talks { @talks }

sub generate_talks_html {
    my $output = '';
    my $new_year;

    for my $talk (@talks) {
        my $date = main::prettify_date($talk->{date}, 'en');
        my $conference = $talk->{conference};
        my $li_class = "";

        my ($year) = $talk->{date} =~ /^(\d\d\d\d)-/;
        if (!defined($new_year) || $year != $new_year) {
            $li_class .= " new-year";
        }
        $new_year = $year;

        $output .= qq[
            <li class="$li_class">
                <span class="year">$year</span>
                <span class="date">$date</span>
                <span class="title"><a href="$talk->{url}">$talk->{name}</a></span>
        ];

        if ($conference->{name}) {
            $output .= qq[
                <span class="conference">at <a href="$conference->{url}">$conference->{name}</a></span>
            ];
        }

        $output .= qq[
            </li>
        ];
    };

    $output = qq[<ul id="talks">$output</ul>];

    return $output;
}

my %upload = (
    pdf       => 'PDF',
    key       => 'Keynote source',
    'key.tar' => 'Keynote source',
);

sub talk_pages {
    my @pages;

    for (my $t = 0; $t < @talks; ++$t) {
        my $talk = $talks[$t];

        next if $talk->{skip_index};
        my $page = { talk => $talk };
        my @links = @{ $talk->{links} || [] };

        my $conference = $talk->{conference};

        for (@links) {
            if ($_->{type}) {
                $_->{label} = $upload{$_->{type}};
                $_->{href} = "/talks/$conference->{dir}/$talk->{dir}/$talk->{dir}.$_->{type}";
            }
        }

        my $embed = "";
        if ($talk->{embed}) {
            $embed = $talk->{embed};
        }
        elsif ($talk->{speakerdeck}) {
            $embed = << "            END";
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

        if ($conference->{talk}) {
            push @links, {
                href  => $conference->{talk},
                label => "$conference->{name} talk page",
            };
        }

        my $links = '';
        if (@links) {
            $links = '<ul>'
                   . join('',
                       map { qq[<li><a href="$_->{href}">$_->{label}</a></li>] }
                       @links)
                   . '</ul>';
        }

        my $date = main::prettify_date($talk->{date}, 'en');
        my $presented = $talk->{future} ? "To be presented" : "Presented";

        my $presented_at = $conference->{name}
                         ? qq{$presented at <a href="$conference->{url}">$conference->{name}</a>, $conference->{venue} in $conference->{city}.}
                         : "";

        my $html = << "        END";
            <div id="talk">
                <header>
                    <span id="date">$date</span>
                    <h1 id="title">$talk->{name}</h1>
                </header>
                <article>
                    <p class="metadata">$talk->{length}. $presented_at</p>
                    <br />
                    <br />

                    $embed
                    <p class="description">$talk->{description}</p>
                    $links
                </article>
            </div>
            <hr />
            <div style="text-align: center"><a href="http://creativecommons.org/licenses/by-sa/3.0/us/" rel="license"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/us/88x31.png"/></a></div>
            <p>This talk is licensed under a <a href="http://creativecommons.org/licenses/by-sa/3.0/us/" rel="license">Creative Commons Attribution-Share Alike 3.0 United States License</a>.</p>
        END

        $page->{content} = $html;

        push @pages, $page;
    }

    return @pages;
}
