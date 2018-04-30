use Sartak::Blog;

BEGIN { print "title: Near-Miss Words\ndate: 2012-03-02\nrownav: 1" }

p { "I do a fair amount of morphological analysis of my corpus of Japanese content. Today I thought up and [quickly implemented](https://github.com/sartak/anki-bin/commit/33ded524) a new way to order words I should learn next. I call them *near-miss words* because each one is the single word that I don't understand in an otherwise comprehensible sentence. In other words, they are the missing \"+1\" in [i+1 sentences](http://en.wikipedia.org/wiki/Input_Hypothesis). Learning near-miss words could be a productive way to fill gaps in my understanding." };

p { "I have a lot of [modules](http://github.com/sartak/Anki-Morphology) and [scripts](http://github.com/sartak/anki-bin) written in Perl to help me learn Japanese, but the most important chunk of this is [mecab](http://mecab.googlecode.com/). Mecab breaks up sentences into stemmed (i.e. normalized) words. Without it, I would have **nothing** for analyzing what I do and do not know." };

p { "Using mecab I scan through all of the flash cards that I [irregularly](http://en.wikipedia.org/wiki/Spaced_repetition) review in Anki to produce a list of words I know (currently ~5500). I then use that to comb through my large (~200K) sentence corpus to find the ones that are known except for one word. Then just dump out those words sorted by the number of times they show up as a near-miss." };

p { "Top five answers are on the board..." };

ol {
    li { "驚く - <i>marvel</i> (123x)" };
    li { "株式会社 - <i>corporation</i> (98x)" };
    li { "震える - <i>tremble</i> (75x)" };
    li { "同士 - <i>pal</i> (69x)" };
    li { "だいぶ - <i>great</i> (68x)" };
};

p { "One example among the 123 sentences for that top word follows. Notice how the verb is in the past tense form - mecab's got me covered." };

p { "だから、手紙をもらった時、**驚いた**わ<br><i>That's why I was **surprised** when I got the letter!</i>" };

p { "Pretty soon I will need a meta-analyzer for finding the words that most frequently appear at the tops of these lists." };
