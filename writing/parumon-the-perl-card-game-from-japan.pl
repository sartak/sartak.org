use Sartak::Blog;

BEGIN { print "title: Parumon: The Perl Card Game from Japan\ndraft: 1\n" }

p { "At YAPC::Asia, [\@maka2_donzoko](http://twitter.com/maka2_donzoko) released [Parumon: The Perl Monger Training Card Game](http://donzoko.net/parumon/). As soon as I heard about it I quickly snatched one up (which was fortunate since they of course sold out on the first day). I don't intend to give a full translation of all the rules and cards, but I'd like to give you an idea of how it works." };

a {
    href is 'http://www.flickr.com/photos/sartak/6295144434';
    img { src is 'http://farm7.static.flickr.com/6019/6295144434_0930b8a9b6.jpg' };
}

p { "For ego surfers here's the list of modules that appear in the game: " };

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
                href is "http://metacpan.org/module/$module";
                outs_raw $module;
            };

            outs_raw " ($note)" if $note;
        }
    }
}

