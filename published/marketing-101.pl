use Sartak::Blog;

BEGIN { print "title: Marketing 101\ndate: 2013-03-16\n" }

p { "My girlfriend's friend just sent her a message:" };

blockquote {
    p { q{I'm reading an interesting article about the founders of GitHub. I was wondering, "Where have I heard about this?"} };
    p { "It's imprinted on my brain from all those hungover mornings drinking coffee out of that mug!" };
};

a {
    href is "http://shop.github.com/products/octocat-mug";
    img {
        width is "512px";
        height is "326px";
        src is "http://cdn.shopify.com/s/files/1/0051/4802/products/MG_0914_1024x1024.jpg?63";
    };
};

