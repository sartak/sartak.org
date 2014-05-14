use Sartak::Blog;

BEGIN { print "title: \"Foreign Films\"
draft: 1
" }

p { "I bought a randomly-selected [Toothpaste for Dinner](http://toothpastefordinner.com) original. *This* is how he treats me??" };

img {
    width is "816";
    height is "612";
    src is "/img/blog/foreign-films/tfd.jpg";
};

p { "I love it ;) You should [buy one](http://sharing-machine.myshopify.com/products/random-original-tfd-art) too if you like the comic at all." };

a {
    href is "http://www.toothpastefordinner.com/index.php?date=011912";

    img {
        width is "630";
        height is "521";
        src is "http://www.toothpastefordinner.com/011912/foreign-films.gif"
    };
};
