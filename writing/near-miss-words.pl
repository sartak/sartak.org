use Sartak::Blog;

BEGIN { print "title: Near-Miss Words\ndraft: 1\n" }

p { "I do a fair amount of morphological analysis of my corpus of Japanese content. Today I thought up and quickly implemented a new way to order words I should learn next. I call them *near-miss words* because they are the single word in a sentence I don't understand. Learning near-miss words could be a productive way to fill gaps in my understanding." };

p { "I have a lot of modules and scripts written in Perl to help me with this, but the most important chunk of this is [mecab](http://mecab.googlecode.com/) which breaks up Japanese sentences into stemmed (i.e. normalized) words. From there I can churn through all of the flash cards I have in Anki to produce a list of words that I know. Using that list I can comb through my large (~200K) sentence corpus to find the ones that are known except for one word. Then dump out those words sorted by the number of times they show up as a near-miss." };

ol {
    li { "驚く - <i>marvel</i> (123x)" };
    li { "株式会社 - <i>corporation</i> (98x)" };
    li { "震える - <i>tremble</i> (75x)" };
    li { "同士 - <i>pal</i> (69x)" };
    li { "だいぶ - <i>great</i> (68x)" };
};
