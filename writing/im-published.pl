use Sartak::Blog;

BEGIN { print "title: I'm Published!\ndraft: 1\n" }

p { "Today I received a complimentary copy of [WEB+DB Press volume 67](http://www.amazon.co.jp/WEB-DB-PRESS-Vol-67-%E5%B7%9D%E5%8F%A3/dp/4774149942/ref=sr_1_1?ie=UTF8&qid=1330290184&sr=8-1), which is a Japanese magazine about programming. My article, メタオブジェクトプロトコル入門, <i>Introduction to Metaobject Protocols</i>, is the thirteenth entry in a series of articles called [Perl Hackers Hub](http://gihyo.jp/dev/serial/01/perl-hackers-hub)." };

div {
    style is "text-align: center";
    a {
        href is "http://www.flickr.com/photos/sartak/6786643658";
        image("http://farm8.staticflickr.com/7054/6786643658_91ca0f2b90.jpg");
    }
};

h2 { "Production" };

p { "At [YAPC::Asia 2011](http://yapcasia.org/2011/) in Tokyo, [Kazuhiro Osawa](http://blog.yappo.jp/) ([\@Yappo](http://twitter.com/Yappo)) approached me asking if I wanted to write an article for the magazine. Never one to turn down that kind of challenge I readily accepted. First, to get a sense of the expected tone and length of the article I'd be writing, I read a couple previous entries in the Perl Hackers Hub series, about [AnyEvent](http://gihyo.jp/dev/serial/01/perl-hackers-hub/000201), [Xslate](http://gihyo.jp/dev/serial/01/perl-hackers-hub/000501), [TheSchwartz and Qudo](http://gihyo.jp/dev/serial/01/perl-hackers-hub/001001), and more. I also read a handful of Japanese articles (everything from Wikipedia to translated documentation) about object-oriented programming, Moose, and meta-object protocols, not only to build my vocabulary specific to this domain, but also to figure out how to explain my topic." };

p { "Then the hard part began. I wrote the article directly in Japanese in November and December. Or at least, in an English pidgin of something resembling Japanese! My buddy [Daisuke Maki](http://mt.endeworks.jp/d-6/) ([\@lestrrat](http://twitter.com/lestrrat)) spent a _lot_ of time editing and clarifying what I had written into an article worthy of publication." };

p { "Months later now that I have forgotten all the work that went into writing this article, I'm now rereading it with a fine-toothed comb to add sentences to Anki and words to my vocabulary. I don't recommend publishing an article simply for the purpose of finding gaps in your second language writing ability, but I'm making the most of that fringe benefit, having done so." };

h2 { "Content" };

p { "The article ended up eight pages long. I thankfully didn't need to cut any important instructive content at all, but there was some fluff that went easily." };

h2 { "Plug" };

# http://www.amazon.co.jp/s/ref=ntt_athr_dp_sr_7?_encoding=UTF8&search-alias=books-jp&field-author=Shawn%20M%20Moore
