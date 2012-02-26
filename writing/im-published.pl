use Sartak::Blog;

BEGIN { print "title: I'm Published!\ndraft: 1\n" }

p { "Today I received a complimentary copy of [WEB+DB Press volume 67](http://www.amazon.co.jp/WEB-DB-PRESS-Vol-67-%E5%B7%9D%E5%8F%A3/dp/4774149942/ref=sr_1_1?ie=UTF8&qid=1330290184&sr=8-1), which is a Japanese magazine about programming. My article, メタオブジェクトプロトコル入門, <i>Introduction to Metaobject Protocols</i>, is the thirteenth entry in the series of articles called [Perl Hackers Hub](http://gihyo.jp/dev/serial/01/perl-hackers-hub)." };

a {
    href is "http://www.flickr.com/photos/sartak/6786643658";
    image("http://farm8.staticflickr.com/7054/6786643658_91ca0f2b90.jpg");
}

p { "I wrote the article directly in Japanese in November and December. Or at least, in an English pidgin of something resembling Japanese! My buddy [Daisuke Maki](http://mt.endeworks.jp/d-6/) ([\@lestrrat](http://twitter.com/lestrrat)) spent a _lot_ of time editing and clarifying what I had written into an article worthy of publication." };

# http://www.amazon.co.jp/s/ref=ntt_athr_dp_sr_7?_encoding=UTF8&search-alias=books-jp&field-author=Shawn%20M%20Moore
