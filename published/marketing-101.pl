use Sartak::Blog;

BEGIN { print "title: Marketing 101\ndate: 2013-03-16\nrownav: 1" }

p { "My girlfriend's friend just sent her a message:" };

blockquote {
    p { q{I'm reading an interesting article about the founders of GitHub. I was wondering, "Where have I heard about this?"} };
    p { "It's imprinted on my brain from all those hungover mornings drinking coffee out of that mug!" };
};

figure {
    img {
        width is "512px";
        height is "343px";
        style is "width: 512px";
        src is "/img/blog/marketing-101/octocat-mug.jpg";
    };
};

