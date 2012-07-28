use Sartak::Blog;

BEGIN { print "title: My Study Calendar\ndraft: 1\n" }

p { "I've been studying Japanese for three years now. There are four tools that I have found to be invaluable in making me productive with the language. (I'm still trying to figure out how to be modest about it.)" };

p { "The first is [**Anki**](http://ankisrs.net), which I've discussed at length in some [old](/2010/01/on-learning.html) [blog](/2010/04/learning-japanese-with-sentences.html) [posts](/2012/02/how-many-sentences-teaches-a-word.html). Anki is the lynchpin of my study. In the right hands, it offers more than its primary focus of maintaining knowledge efficiently. It [secretly](/2012/03/near-miss-words.html) [doubles](/2012/02/how-many-sentences-teaches-a-word.html) as an external, _queryable_ database that represents exactly the Japanese that I understand right now (with enough historical information that I can fudge in order to make progress charts). Anki is the <i>i</i> in the [<i>i+1</i> input hypothesis](http://en.wikipedia.org/wiki/Input_Hypothesis#Input_hypothesis)." };

p { "The second tool is the _[**Remembering the Kanji**](http://www.amazon.com/gp/product/0824835921/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0824835921&linkCode=as2&tag=sartak-20)_ system for learning kanji and its community-created companion website [Reviewing the Kanji](http://kanji.koohii.com). Last weekend I finished the [third book](http://www.amazon.com/gp/product/0824831675/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0824831675&linkCode=as2&tag=sartak-20) in the series which covers characters 2049(此) through 3030(鬱). This is essentially college-level proficiency. So by completing RTK3 I've finished systematically studying and learning the kanji themselves. What's left is acquiring vocabulary, and lots of it. Happily, the fruits of all the Heisig study is that kanji helps _massively_ rather than hinders." };

p { "The _fourth_ is my own **sentence corpus** system, which I still have not devoted the appropriate amount of time to explain. Some day, but not today!" };

h2 { "My Study Calendar" };

p { "The third tool is the focus of this article. It's important to expose oneself to a variety of media. There's no substitute for immersion in acquiring a second language. I use the calendar to make sure that I'm regularly reading articles and novels, practicing writing, watching movies, learning song lyrics (for [karaoke](http://www.flickr.com/photos/sartak/4628540837/) purposes), playing video games, and everything else I enjoy doing. Just... in Japanese." };

p { "To track my progress, to keep me honest about my immersion, and to decide what kinds of study I should do today, I maintain a **study calendar**. It used to take the form of a cheap whiteboard, inspired directly by [Giles](http://gilesbowkett.blogspot.com/2011/01/my-habit-calendar-system-levelling-up.html) [Bowkett](http://gilesbowkett.blogspot.com/2010/02/calendar-win-rapid-course-correction.html)." };

a {
    href is "http://www.flickr.com/photos/sartak/5998087904/in/photostream";
    image "my-study-calendar/whiteboard.jpg";
};

p { "The whiteboard calendar served me well for over a year. But it had many glaring problems:" };

ul {
    li { "As you can see, it was messy. It would only support about a dozen goals before it became a wreck. Actually, more like five goals." };
    li { "I could look at it and update it only when I was home. This meant that when I traveled my study went to shit." };
    li { "It didn't support metadata very well, though I certainly tried! Those numbers on each day represent the number of sentence cards I added to Anki (red), the number of words I learned (blue), and the number of kanji I learned (green)." };
    li { "It supported daily (horizontal) and weekly (vertical) tasks well, but any other schedule was a pain to manage." };
    li { "It wasn't computerized so I couldn't extract any statistics. Not even streaks. Of course I also threw away all my data every month, which led to weird mental side effects depending on how far into the month it was." };
    li { "It was... accident-prone." };
};

p { "I'd been trying to get away from the physical whiteboard calendar because I'm whatever the opposite of a Luddite is. I've collected quite a few crummy habit-building iPhone calendar apps." };

h3 { "[The Daily Practice](http://tdp.me)" };

p { "Thankfully (and finally!), a worthy replacement has come out, and I've been on it exclusively for six months now. I even threw away the whiteboard in a symbolic gesture of victory. The new system is called [The Daily Practice](http://tdp.me) and it looks like this (plus purple translations I added in post):" };

image "my-study-calendar/full.png";

p { "As you can see it solves the issues I had with my whiteboard well. The quotation icons indicate notes, so I can track what I'm actually doing. I can consult my calendar and update it from anywhere I have an internet connection, including from my phone." };

p { "This is the current set of commitments I demand of myself. I wrote them in Japanese because that is most definitely how I roll." };

ol {
    li { "2ch: read [2chan](http://en.wikipedia.org/wiki/2channel) every day. \"_it has gained significant influence in Japanese society, comparable to that of traditional mass media such as television, radio, and magazines_\". I'd be robbing myself of important arguing and trolling tactics if I ignored this!" };
    li { "記事 / article: read an article-length document every day. This usually comes in the form of a [Japanese Wikipedia](http://ja.wikipedia.org/wiki/メインページ) article or a blog post." };
    li { "書く / write: write every day. Sorry about all the Japanese tweets. :) (not really sorry)" };
    li { "アンキの勉強 / anki: do my Anki reviews every day. I have an unbroken streak of 164 days, which is how long I've been using The Daily Practice. It's also the [longest streak on the site](http://twitter.com/jshirley/status/228887804485197824)!" };
    li { "漢字 / kanji: learn at least one kanji every day. This uses the Heisig system I described above as tool number two. It has a recycling widget because I'm done! Once my last checkmark falls off the weekly calendar, so too will the goal itself. But the data is still there. That's a great bit of design." };
    li { "カードを加える / cards: add sentence cards to Anki every day." };
    li { "単語 / vocabulary: learn at least one word every day. I keep track of my active vocabulary [on github](https://github.com/sartak/vocabulary/commits)." };
    li { "ゲーム / game: play a video game every _other_ day. Currently playing Final Fantasy VII on my newly-imported PlayStation 2." };
    li { "読む / read book: read part of a book or manga every _other_ day. [Currently reading](http://www.goodreads.com/user/show/5099248-shawn-moore) Dune and Harry Potter and the Goblet of Fire." };
    li { "映画を観る / movie: watch a movie or television every _fourth_ day. Mostly I watch American movies that I already like dubbed into Japanese. But I've noticed I can follow along with new content too, watching Miyazaki and Kurosawa." };
    li { "歌詞 / lyrics: learn part of a song every _week_." };
    li { "漢検 / kanken test: take the [kanji aptitude test](http://en.wikipedia.org/wiki/Kanji_kentei) every _week_. I have a [kanken DS game](http://traveljapanblog.com/wordpress/2009/04/kanken-ds-3-deluxe/) and I'm currently struggling with [level 7](http://en.wikipedia.org/wiki/Kanji_kentei#Level_7)." };
    li { "資料を集める / content: acquire new Japanese content every _week_. This includes books, movies, music, games. I've got to keep topping up my Japanese gas tank to keep studying." };
};

p { "The numbers on the far right are streak counts. You'll notice that most of the daily goals have a streak of around 30, the every-other-day goals around 20, and the less frequent goals around 10. This is because about a month ago I noticed my study calendar looked like this:" };

image "my-study-calendar/barren.png";

p { "As you can see, this time period is barren. There are multiple days where I did only the bare essentials: my Anki reviews and learning a couple kanji. It was depressing to look at." };

p { "So [I fixed it](http://twitter.com/sartak/status/220287719706853376)! And now a month later I still haven't broken the chains in my TDP calendar. My appetite for study waxes and wanes, but externalizing what I have _actually_ done encourages honesty and leads me to course-correct in this way. TDP answers the question \"What should I do today?\" for me. Without it, the answer is usually \"goof around on the internet\"." };

