use Sartak::Blog;

BEGIN { print "title: How Many Sentences Teaches a Word?\ndraft: 1\n" }

p { "One of the questions I wonder about is how many sentences I need to add to my flash card deck to learn a particular word or kanji well enough to have no trouble with it. There are certainly a lot of tricky words such as 敢行 (decisive action) and 格納 (store away) that always seem to slip away from me. I suspect that is entirely because I have one flash card each for those words. I just don't have any other comprehensible sentences for them in the corpus of text I'm accumulating. Because I need to see more of those words to get them to stick in my head, should I just give up and delete those two important sentences from my deck? Typically what I'll do instead, which has worked well for words like 薄皮 (thin covering film) and 七面鳥 (turkey), is to search Twitter. Even for the most obscure words I come across, Twitter gives me thousands of short example sentences." };

p { "I'm certain that at my skill level, one card is not always enough to cement a completely new word in my passive vocabulary. Is two cards enough? Maybe. I'm sure five is generally sufficient. But if I can't get five sentences I don't hate, should I skip the word?" };

p { "Luckily to answer such questions, I have a giant (currently 14,722 flash card) list of Japanese sentences that I can mostly comprehend. Each sentence even include a set of statistics including how many times I've reviewed it, what my breakdown of incorrect versus correct responses were, when I first reviewed it, and so on. Since I'm very diligent about learning using this flash card system, **I can data mine my understanding of Japanese.**" };

p { "Using [Text::MeCab] to split up Japanese sentences (which do not use spaces which stifled this kind of analysis until I found mecab) into stemmed words, I can get visibility into how hard each word itself is, based on my review history of the sentence cards which contain it. Since I do a fair amount of this kind of analysis anyway, I already had most of the tools I needed. 50 lines of Perl later I have this data set:" };

div {
    class is 'yui3-g';

    div {
        class is 'yui3-u-2-5';
        pre {
            class is 'code_snippet';
            style is 'margin: 0; width: auto';

            outs_raw join "\n", (
                '1: 87.75%',
                '2: 91.19%',
                '3: 92.59%',
                '4: 93.36%',
                '5: 95.06%',
                '6: 95.80%',
                '7: 96.38%',
            );
        };
    };

    div {
        class is "yui3-u-1-5";
    };

    div {
        class is "yui3-u-2-5";
        image "word-spark.png";
    };
};

p { "This means if I add one card for the word, I've got a decent 87% chance of recalling it on time. A second card helps a _lot_. Add a few more cards and my chances are golden." };

p { "I should search for tweets mentioning tricky words like 格納 and 敢行, add a few of the less awful sentences, and never have problems with them again." };

h3 { "English" };

p { "Since December I've been adding English words I don't know to a separate Anki deck. I'm up to 133 of them, which averages out to just under two new words a day. This process is very lightweight - when I spot a word I don't know I just add it to my todo list with a particular tag. As a special case, when I'm reading an ebook, I highlight every unknown word I come across so that when I'm done with the book I can bulk add everything I didn't know all at once. Before this vocabulary spree, I was already most of the way there, since I was selecting words I didn't know so I could read their definitions." };

p { "I do know from several examples that for an English word, one flash card is sufficient to get it into my *active* vocabulary. I freely used 'babel' (a confusion of many voices) the other day which I learned only eleven days ago from [an H.P. Lovecraft short story](http://en.wikipedia.org/wiki/The_Rats_in_the_Walls). I've reviewed it three times since then, marking it correct all three times." };

p { "I look forward to my Japanese being that good too." };
