use Sartak::Blog;

BEGIN { print "title: Parumon: The Perl Card Game from Japan\ndraft: 1\n" }

p { "At YAPC::Asia, [\@maka2_donzoko](http://twitter.com/maka2_donzoko) released [Parumon: The Perl Monger Training Card Game](http://donzoko.net/parumon/). As soon as I heard about it I quickly snatched one up (which was fortunate since they of course sold out on the first day). I don't intend to give a full translation of all the rules and cards, but I'd like to give you an idea of how it works." };

a {
    href is 'http://www.flickr.com/photos/sartak/6295144434';
    img { src is 'http://farm7.static.flickr.com/6019/6295144434_0930b8a9b6.jpg' };
}

p { "_Withstand the impending attack while completing a project making the most of CPAN modules!_" };

ul {
    li { "Players who forget to declare `use strict` on their first turn lose a _hack point_." };
    li { "On your turn you can play a CPAN module card, but only if its dependencies (e.g. Plack depends on URI and Try::Tiny) are already in play. You have to spend as many hack points (1-3) as the card needs, but you gain . When you play a core module card you can take another turn." };
    li { "One of the actions players can perform is to _pair program_ with another player. This facilitates card trading." };
    li { "This game is one of the first collaborative card games I've seen. There's even a rule where other players can spend some of their points to bring a fallen co-conspirator back from having lost. "};
};

p { "For ego surfers here's the list of modules that appear in the game. The modules in this game were selected from [_CPAN Module Guide_](http://cpanbook.koneta.org/) written by [\@tomita](http://twitter.com/tomita)." };

ul {
    my @modules = map { [ /(\S+)(?: (x\d))?/ ] } grep { /\S/ } split /\n/, '
        Acme::Bleach
        Amon2
        AnyEvent
        Catalyst::Runtime
        DBI x2
        DBIx::Class
        DBIx::Skinny
        DateTime
        Devel::Cover
        Email::Send
        Email::Sender
        HTML::Template
        Log::Handler
        Log::Minimal
        MIME::Lite
        MetaCPAN::API
        Mojolicious
        Moose
        Mouse x2
        OrePAN
        POE
        Path::Class x2
        Plack
        Template
        Teng
        Test::Base
        Test::More x2
        Test::Perl::Critic
        Test::Pod
        Text::MicroTemplate
        Text::Xslate
        Time::Piece x2
        Try::Tiny x3
        URI x2
    ';

    for (@modules) {
        my ($module, $note) = @$_;
        li {
            a {
                my $url = "http://metacpan.org/module/$module";
                $url = "https://github.com/tokuhirom/OrePAN" if $module eq "OrePAN";
                href is $url;
                outs_raw $module;
            };

            outs_raw " ($note)" if $note;
        }
    }
}

