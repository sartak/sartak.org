use Sartak::Blog;

BEGIN { print "title: A Shameful Core App\ndraft: 1\n" }

h2 { "It's Calculator.app" };

p { "Whip out your iPhone. Unless you're already using it to read this post, in which case whip out your second iPhone. Fire up Calculator.app. You'll see this:" };

image("calculator.png", "Calculator.app");

p { "Note the four gray buttons at the top, all of which are dedicated to managing the *single* memory register that Apple's builtin calculator supports. Huh? This application has gigabytes of SQLite storage available. It has the entire freaking *Internet* at its fingertips. And yet, we're limited to a single 8-digit floating point number. Why doesn't Apple get rid of this crummy 35-cent calculator metaphor? Beats me, but I trust they actually have a reason." };

p { "I've just recently started using Calculator.app in anger. I want it to remember several specific numbers, for potentially weeks at a time. My use case here is remembering the scaling factor between whatever page count my Kindle or iBooks ebook has calculated, and what [goodreads](http://goodreads.com/sartak) has for total pages. Tracking my reading progress publicly motivates me to finish reading what I've started. Unfortunately, since I read at night to get sleepy, it's frustrating to have to recalculate the constant of proportionality between the ebook page number and the goodreads page number. Division is difficult enough without inviting 2AM into the mix." };

h2 { "Unintrusive Improvements" };

p { outs "Long-press is a great UI pattern for hiding rarely-used alternatives until they are needed. If you hold down the `\$` button in your iOS keyboard, out pops up a tiny menu with other currency keys, including ¢, on it. I very rarely need the Korean "; i {"_won_"}; outs " symbol ₩, so I'm glad it's not sitting there all the time, wasting space. But every now and then Korea will come up in conversation, and even if this is the first time you've seen long-press on the keyboard, I bet in a few months you'll still remember how to type ₩. A bunch of other keys support long-press including `?`, `!`, and `&`." };

image("currency.png", "Long-pressing the \$ key pops up a currency menu");

p { "Similarly, if I long-press on the calculator's `mr` button, I'd like to see a list of numbers previously stored in memory. And once we have that, it'd be useful to label such numbers. That way I don't even have to remember which book's pages are 0.46x longer on iBooks than in paper. Having computers remember things for us is why we suffered their crawling up out of the ocean in the first place." };

p { "XXX: replace with a mocked up (or real) screenshot, and real data" };
ul {
    li { "Fear and Loathing: 0.46" };
    li { "Chamber of Secrets: 0.77" };
    li { "On Lisp: 1.36" };
};

p { "I can see two ways of adding this labeling feature to the UI. If in the long-press on `mr` menu, we can have a '...' (similarly to kanjification in Japanese input) item at the end which loads up a table view. This will let you see even more numbers, delete them, and of course label them. The other possibility is that if you long-press on `m+`, you get a little input box right there alongside the button to type in the label. I see no reason to provide only one of the two." };

image("kanjification.png", "Kanjification menus usually have an 'expand' option at the end");

p { "Since we have literally **kilobytes** of memory to play with, we could even remember the calculation that produced the stored number and use that as the default label." };

p { "As a stepping stone to this long-press business, we could also just cycle through previous stored numbers if you tap `mr` multiple times in a row. I was surprised when doing this *didn't* just work. I am not, however, surprised that I was surprised, because I expect Apple to routinely delight me with discoverable features like this." };

p { "Since Gran-gran doesn't understand long-press and won't tap `mr` multiple times, she won't be overwhelmed by the popups and the doo-dads - she just gets the same calculator she's been using since 1970. But we power users get these nice bonus features without cluttering the basic UI at all. Such unintrusive and *discoverable* features would be great additions to the core Calculator.app. If I had my druthers I'd call up a buddy at Apple and have him fast-track the next iOS update with this. But until Steve checks his voicemail, I'm going to crank out a new calculator for my own use." };

