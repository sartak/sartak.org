use Sartak::Blog;

BEGIN { print "title: A Shameful Core App\ndraft: 1\n" }

h2 { "It's Calculator.app" };

p { "Whip out your iPhone. If you're reading this on your iPhone, whip out your second iPhone instead. Fire up Calculator.app. You'll see this:" };

image("calculator.png", "Calculator.app");

p { "Note the four gray buttons at the top, all of which are dedicated to managing the *single* memory register that Apple's builtin calculator supports. This application has gigabytes of SQLite storage available. It has the entire freaking *Internet* at its fingertips. And yet, we're limited to a single 8-digit floating point number. Why doesn't Apple get rid of this crummy 35-cent calculator metaphor? Beats me, but I hope they actually have a reason." };

p { "I've just recently started using Calculator.app in anger. I want it to remember several specific numbers, for potentially weeks at a time. My use case here is remembering the scaling factor between whatever page count my Kindle or iBooks ebook has calculated, and what [goodreads](http://goodreads.com/sartak) has for total pages. Tracking my reading progress publicly motivates me to finish reading what I've started. Unfortunately, since I read at night to get sleepy, it's frustrating to have to recalculate the constant of proportionality between the ebook page number and the goodreads page number. Division is difficult enough without inviting 2AM into the mix." };

h2 { "Unintrusive Improvements" };

p { "I like long-press as a UI pattern. If you hold down the \$ button in your iOS keyboard, out pops up a tiny menu with other currency keys on it. I very rarely need the Korean currency symbol ₩, so I'm glad it's not there all the time wasting space. But every once in a while I will want it, and I will always know exactly how to type it on my keyboard after having seen how it works just once. Long-press is a great tool for hiding rare options until needed." };

image("currency.png", "Long-pressing the \$ key pops up a currency menu");

p { "Similarly if I long-press on MR, I'd like to see a list of values previously stored in memory. It'd be a simple, unintrusive, and dare I say *discoverable* feature for the core Calculator.app. If I had my druthers I'd call up a buddy at Apple and have him fast-track the next iOS update with this. But until then I'm going to crank out a new calculator for my own use." };

p { "So once we have long-press on MR, which pops up a list of previous stored numbers, it'd be useful to label such numbers. That way, I don't even have to remember which book's pages are 0.46x longer on iBooks than in paper. Having computers remember things for us is why we let them crawl up out of the ocean in the first place." };

p { "XXX: replace with a mocked up (or real) screenshot" };
ul {
    li { "Fear and Loathing: 0.46" };
    li { "Chamber of Secrets: 0.77" };
    li { "On Lisp: 1.36" };
};

p { "I can see two ways of adding this labeling feature to the UI. If in the long-press on MR menu we have a '...' (similarly to kanjification in Japanese input) item at the end, we can load up a table view. This will let you see even more values, delete them, and of course label them. The other possibility is that if you long-press on M+, you get a little input box right there alongside the button to type in the label." };

image("kanjification.png", "Kanjification menus usually have an 'expand' option at the end");

p { "Since we have literally **kilobytes** of memory to play with, we could remember the calculation that produced the stored value and use that as the default label." };

p { "So: since Gran-gran doesn't understand long-press, she won't be overwhelmed by the popups and the doo-dads - she just gets the same calculator she's been using since 1970. But we power users get the nice bonus functionality without cluttering the basic UI at all." };

