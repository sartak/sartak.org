use Sartak::Blog;

BEGIN { print "title: Buy Your Favorite Author a Book\ndraft: 1\n" }

p { "I love how quickly [metacpan](http://metacpan.org) is becoming the ultimate hub of CPAN information. It's great that I can see an author's github ID from her author page. I recently noticed one deficiency though: authors couldn't set their wishlist. That was just an oversight; anyone could set up a PayPal donation address." };

a {
    onclick is "load_wishlists();";
    href is '#';
    "Click here to load authors who have put in a wishlist";
};

script {
    my $url = 'http://api.metacpan.org/author/_search?q=author.donation.name:wishlist&size=100';
    outs_raw << "JS";
    function _handler () {
        if (this.readyState != 4) {
            return;
        }
        
        if (this.status == 20) {
            alert(this.responseText);
        }
        else {
            alert(this.statusText);
        }
    }

    function load_wishlists () {
        var client = new XMLHttpRequest();
        client.onreadystatechange = _handler;
        client.open("GET", "$url");
        client.send();
    }
JS
};

p { "If someone's module saves your biscuits at work, or if reading their one of their masterpieces sparks that _Whoa!_ moment in you, consider sending em one of their wishlist items. It's a lot less tacky than a paypal donation, I think." };

p { "Speaking of tacky, here's [_my_ wishlist](http://www.amazon.com/wishlist/28Z3PMAC42Z9F)!" };

