use Sartak::Blog;

BEGIN { print "title: Your Email Address Sucks\ndraft: 1\n" }

p {
    outs "Since I signed up for Gmail in June 2004, I've used it as my primary email address for everything. Every single account I've made on any website is tied to my Gmail.";
    footnote { "This paragraph is made of lies because I have a second email address I use for everything related to my job. But that's completely irrelevant to this article." };
};

p { "Yuval Kogman's post, [Your OpenID sucks](http://blog.woobling.org/2009/05/your-openid-sucks.html), inspired me to finally set an OpenID for myself. The post describes using a bit of HTML on the index page of your own domain name to _delegate_ the OpenID to your _actual_ identity provider. So whenever a site calls for my OpenID, I can simply type in `sartak.org`. The service provider (which will typically be a blog I'm commenting on) grabs sartak.org, sees that I've set up delegation to `sartak.myopenid.com`, then negotiates my identity with (myOpenID)[http://myopenid.com]. But when the service provider displays information about me to other users of the site, it lists me as `sartak.org`, not `sartak.myopenid.com`. This setup is preferable for a number of reasons. Most importantly, it makes me look competent since the URL is my homepage. It also means I can switch my actual identity provider when a better one comes along. I won't need to go through every site I've ever used and update my OpenID from `sartak.myopenid.com` to the URL of the successor." };

p {
    outs "Lately I've desired to _own_ my email address just like I have always _owned_ my OpenID and now _own_ this blog.";
    footnote { "My blog used to be on [Blogspot](http://blogspot.com), but in early 2011 I moved it to my hosting after getting fed up with it." };
};

p { "So if you're in a situation like me and want to read email on Gmail, but hand out an email address using your domain, here's how to make this happen." };

ol {
    li { "`sudo apt-get install postfix`" };
};

