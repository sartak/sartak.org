title: Spaced Repetition Flash Cards for Go
draft: 1
rownav: 1

Spaced repetition systems are most commonly used for learning a second language. I'm living proof that it works! People have also used them to study law, medicine, history, and even loads of trivia to <a href="http://quantifiedself.com/2013/06/roger-craig-on-spaced-repetition-and-anki/">win a cool half a mil</a> on Jeopardy. If you're unfamiliar with how magical and transformative spaced repetition is, <a href="https://www.wired.com/2008/04/ff-wozniak/">start here</a>. (The short version is: each flash card has its own review schedule based on your past performance on that specific card&mdash;which makes sense on its own, but happens to be especially powerful because of a quirk in how human memory works)

Spaced repetition can also be used for studying Go! For the past few years, I've been using Anki as the core of my Go study regimen. (I have yet to write up why Go is important to me… some day! For now, <a href="http://users.eniinternet.com/bradleym/Mind.html">this list</a> covers a lot of it)

Each flash card is an <em>interactive</em> Go board like this:

<div class="glift">(;GM[1]FF[4]SZ[19]AP[SmartGo:0.8.11]CA[utf-8]GN[2017-10-28a]PW[Human]PB[Human]DT[2017-10-28]KM[-6.5]RU[Simple]AB[pa:pd][qa][qd][qf:sf]AW[ra][qb:qc][rd:re]PL[W]C[White to live.](;W[rb];B[sc](;W[sb];B[se](;W[sd];B[qe];W[rc]CH[1]C[Correct. White lives.])(;W[rc];B[sd]))(;W[sd];B[sb])(;W[se];B[sb]))(;W[sb];B[rc](;W[rb];B[sd](;W[sc];B[se])(;W[se];B[qe]))(;W[sc];B[rb]))(;W[rc];B[sb](;W[se];B[sc])(;W[sc];B[se]))(;W[sc];B[rb](;W[rc];B[sa])(;W[sb];B[rc])(;W[sa];B[rc]))(;W[sd];B[sb](;W[rb];B[sc])(;W[rc];B[rb]))(;W[se];B[sc](;W[rc];B[sb])(;W[sb];B[rc](;W[rb];B[sa])(;W[sd];B[rb]))))</div>

My personal Anki deck has 5000 Go cards. These are sourced from the usual suspects: books, other problem sets, and <a href="https://yunguseng.com">Yunguseng Dojang</a> lectures. But a substantial chunk of them are whole-board problems using real positions from my games. Typically the move I played is included as an <em>incorrect</em> variation, where the correct answer comes from a review by a professional (or increasingly, by a strong AI). What better way to learn a lesson than by unlearning a mistake that is personally meaningful?

I have a lot to share on this topic, but first…

## Setup

I've set this system up for several friends in <a href="http://massgo.org">my local club</a>. But unfortunately it had been impossible to release for general use… until very recently with the latest major new version of Anki. So I'm excited to publish what I've put together and refined over the last few years.

To set up spaced repetition flash cards for Go, first make sure you have <a href="https://apps.ankiweb.net">Anki 2.1</a>. I also highly recommend the Anki mobile app for <a href="https://itunes.apple.com/us/app/ankimobile-flashcards/id373493387">iOS</a>. There's one for <a href="https://play.google.com/store/apps/details?id=com.ichi2.anki&hl=en_US">Android</a> too, but I haven't used it. Let me know how well it works!

Then, visit the <a href="https://ankiweb.net/shared/info/2021289835">Interactive Go Problems</a> shared deck and smash the big Download button. Open up the <tt>.apkg</tt> file using Anki and you should see a new "Go" deck. You're good to go! There are a few sample problems for you to try, but they're mostly there to make sure everything is working. Feel free to delete them once you're up and running.

## Creating Cards

### SGF Basics

Each card is an SGF file (the standard format for Go games), so you'll want to grab an SGF editor. I like <a href="https://smartgo.com">SmartGo</a> a lot. Other popular, free options include <a href="https://sabaki.yichuanshen.de">Sabaki</a> and <a href="http://eidogo.com/#blank">EidoGo</a>. <a href="https://www.gokgs.com">KGS</a>'s CGoban is the grand-daddy but I can't recommend it in 2018.

The most important subtlety to understand for making problems is the difference between the <strong>initial position</strong> and the <strong>move tree</strong>. If you inspect the SGF of any handicap game, you'll see that Black's handicap stones are already on the board before the first move of the game. You want to use that same kind of initial position, just like the diagram you would see presented as the "problem" in a book. If you just start clicking stones onto the baord you'll almost certainly be editing the move tree, which is not what you want. Instead, use your SGF editor's "Add Stones", "Stone Markup", or "Edit Tool" feature. Sabaki has a nice "Flatten" feature that transforms a move tree into the initial position for you.

<figure><img style="width:522px" width=522 height=339 src="/img/blog/spaced-repetition-flash-cards-for-go/cgoban.png" /></figure>

Once you have the problem's initial set up, you create the move tree by playing stones, just like in an ordinary game. Using variations, you can set up the correct path(s) and refutations to any incorrect moves you want to include.

(The subtle distinction is important to grasp because you cannot tell which stones were part of the initial position or were played as part of the move tree just by looking at the board.)

Finally, you mark a correct variation by including the word "Correct" in the comment of that move.

Once you save your SGF file, you can open it up with a text editor and copy/paste it into the SGF field of a new Anki flash card. By the way, the Source field is not used or shown, it's there only to help your bookkeeping.

You can now go forth and create cards. However, there are some caveats for you to know about, and some additional conventions that I've found useful to make better cards. But, if this is your first rodeo, I'd recommend skipping over the next section and continue reading from <a href="#strategy">Strategy</a>. Come back to this next section in a few weeks after you get the hang of this, or if you run into trouble.

### Caveats and Conventions

A quick one to start: it's often useful to know, in the initial problem setup, what your opponent's last move was (see the sample problems in the shared Anki deck). I used to arrogantly think "no, you should play the board as is, it matters <em>not</em> how we got here". But, like, I gave that up pretty quickly because it was more harmful than helpful. Come up with conventions for dealing with this sort of thing and stick to them. I happen to use a triangle to mark my opponent's last move, but those sorts of specifics don't much matter because your cards are all you.

#### Random Flipping

For each problem, Anki will sometimes randomly rotate and mirror the board, as well as swap the colors of the players. This helps you avoid relying too much on pure visual memory to remind you of the answer. (Which is definitely a real thing, trust me!)

When the colors are randomly swapped, comments including the words "Black" and "White", 「黒」 and 「白」, and so on are also automatically swapped. This works well in practice, as long as you avoid using "B" and "W" as shorthand (either in comments or as meaningful labels on the board), since there's no way for the dumb computer to know what you meant. If you want to suppress this behavior, you can add the tag `no-color` to the card. I've only ever had to use this for opening problems, since it'd be weird if White played the very first move.

For randomly flipping the board, no other fixups are done. This means you have to be careful about how you refer to locations on the board. To deal with this, a few useful tricks are to refer to groups or areas by other means. Instead of the "group in the bottom left corner" (which could be shown in any of the four corners, randomly), it's now "the three-stone wall". Or drop some triangles on the board and call it "the marked side" rather than "the left side". You can still refer to directions like "inside" and "outside", or "higher" and "lower", especially when you think of the goban as a pyramid with the center at the top. As a last resort, you can add the `no-coord` tag to the card to suppress any rotation or mirroring.

The random color swapping and board flipping has one more annoyance hidden in it, because it rerolls the dice every time Anki presents the card to you. This means any of the following could present a different-looking problem: editing the card, reviewing then hitting undo, leaving Anki then coming back, or just reviewing the same card multiple times in a short period. Sorry. I have some ideas about how to fix this, but it hasn't been problematic enough to spend time on it.

I promise despite all the headache it's worth it. I used to joke that I could only play joseki in the top right corner.

By the way, Anki will automatically crop the parts of the board that aren't used. This helps a lot when studying on a phone, but even then whole-board problems are still pretty do-able.

#### Variations

In keeping with <a href="https://www.supermemo.com/en/articles/20rules">"the minimum information principle"</a>, you want each card to test one and only variation. If you have multiple variations to study, make a card for each one, so that it gets scheduled and studied separately. This helps the spaced repetition system help you.

There's an important secondary reason: if there are multiple variations in the SGF file, Anki will only ever select the first one.

(There's an exception where there are multiple moves you can make, but the variations are truly inconsequential. For example, filling the outside liberties in a capturing race. For such cases just put it all into one card as best you can. Optimize for the reasonable use of your own time.)

Opponent variations become separate cards. As do variations you can play, though you typically need some sort of direction to guide you into choosing the right variation. At best, the whole board is set up that way, so you choose the right variation naturally. For example, you can only play this move if you have the ladder:

Otherwise you play this move:

That's the perfect case. But it's not always that clean cut. The next best case is when you can describe the result you want. "Play for territory" or "play for influence", just like you'd need to do in a real game. (example)

Failing all that, you can just throw some marks on the board to guide you through that specific variation. Maybe X out the other variations like so, or even just throw a circle on the board to say "play here".

#### Making SGFs

smartgo. I've asked the author to build in some features
smartgo books, copy diagram

baduk cap, especially for game reviews and whole board problems. It totally works on YouTube videos or a screenshot of KGS.

No problem is too easy.

Breaking up long problems vs playing it out each time. I've tried it both ways, definitely prefer the latter. But it's a personal preference.

## Reviews

One thing that's unusual and worth noting is that when you're doing reviews, I have it set up so that Anki will automatically advance from the question side of the card to the answer side. There are two reasons for that: the first is that the question and answer are already kind of built into the interactive Go board. There's no big reveal like there would be on, say, a geography question. The second is that due to Anki's architecture, if the problem were on the question side, then advancing to the answer side would reset the problem to the initial position, so you'd have to remember how you did. It also saves you a tap; the answer grade buttons are always shown.

I've done 150,000 reviews of the cards in my Go deck, which is to say I've solved that many Go problems. This is substantially more than the average amateur player solves using traditional methods. But even with that many reviews it doesn't take as much time as you'd think. Over the last 900 days I've averaged a half an hour a day to do all those reviews. It's pretty easy to rummage up a spare half hour: during a commute, while eating lunch, waiting in line, quit Facebook, etc.

Every now and then while I'm doing reviews in bed, my fiancée will request "let me do one" and, for someone who neither studies nor plays, she does… surprisingly well at life and death problems.

Books are specialized, this gives you a broad range of problems every day. It's less about memorizing and more about exposure.

I'm also happy to let spaced repetition train my subconscious. Just exposure is enough to help.

## Strategy

Guo Juan's <a href="https://internetgoschool.com/">Internet Go School</a> offers a built-in spaced repetition system. While there is overlap with what I've made, I know couple people who use both. Having the problems designed for you by a pro to go along with lectures you're studying is certainly appealing.

Creating cards is more time consuming than you'd expect. Converting a typical hour-long AYD lecture takes me probably about three hours. And even then it's sometimes tricky to transform a lecture into coherent problems.

But, the upside of the Anki-based system is you get to focus your studies on exactly what you want by making the cards yourself. (As mentioned above, I have hundreds of cards that are sourced from my personal game reviews.)

Spaced repetition is certainly a natural fit for memorizing complicated sequences (including joseki), corner life and death shapes, and so on. However, I take it a few steps further beyond that. I add cards with the deliberate intent to influence my play style. My teacher Inseong regularly tells me that in order to improve, I need to play more sharp moves. And so I make lots of sharp move cards. This comes in the form of whole board problems, typically sourced from my own games where I missed the sharp move. For example, here Black just played the △ move, which is an overplay. In the game, I played a passive response that just helped Black fix his defect, but Inseong pointed out the sharp move which instead punishes the overplay. (Try playing it out, or use the ?⃝  button to reveal the solution&mdash;the moves marked in blue)

<div class="glift">(;GM[1]FF[4]SZ[19]AP[SmartGo:0.8.11]CA[UTF-8]GN[0029-11-28g  ]DT[0029-11-28]KM[6.5]RU[Japanese]ST[2]AB[cb:cd][db][fc][qc:qd][rc][nd][pd][re][cf:df][eg:fg][dh][dl][cn][pn][qo:qp][bp][oq][rq]AW[eb:ec][nb][dc:de][hc][kc][rd][ef:ff][qf:rf][gg][qi][ql][qn:rn][ro:rp][dp][cq][fq][jq]PL[W]TR[pn](;W[pm];B[on]C[Wrong. This passive move just helps Black.])(;W[po];B[oo](;W[qq];B[pp];W[rr]CH[1]C[Correct. Black's block was an overplay that White should have punished with the double atari.])(;W[pp];B[qq];W[op];B[np]C[The straightforward atari sequence doesn't work.])))</div>

So that is now one of many cards which attempt to add teeth to my game. I'm also "mining" tesuji problem books into cards.

## Results

Dan: "I'm not going to choose a difficult variation that you've studied"
I was very disappointed that no one tried the AlphaGo 3-3 invasion against me during my Go Congress games. Because I've studied those patterns (including even newer variations) using Inseong's lectures.

Inseong: how did you know that?

<script src="/misc/go-games/viewer/glift_1_0_6.min.js"></script>
<script type="text/javascript">
    window.onload = function () {
        var boards = document.getElementsByClassName("glift");
        for (i = 0; i < boards.length; ++i) {
            var element = boards[i];
            var id = "go-game-" + i;
            element.id = id;
            var sgf = element.innerHTML;

            element.innerHTML = "";

            var gliftWidget = glift.create({
                divId       : id,
                sgf         : {
                    sgfString: sgf
                },
                sgfDefaults: {
                  widgetType: 'STANDARD_PROBLEM',
                  statusBarIcons: []
                },
                display     : {
                    theme             : 'DEPTH',
                    goBoardBackground : '/misc/go-games/viewer/wood.png',
                    // hide fullscreen button etc
                    oneColumnSplits : {
                      first: [
                        { component: "BOARD",       ratio: 0.70 },
                        { component: "COMMENT_BOX", ratio: 0.20 },
                        { component: "ICONBAR",     ratio: 0.10 }
                      ]
                    },
                    twoColumnSplits: {
                      first: [
                        { component: "BOARD", ratio: 1 }
                      ],
                      second: [
                        { component: "COMMENT_BOX",   ratio: 0.90 },
                        { component: "ICONBAR",       ratio: 0.10 }
                      ]
                    }
                }
            });

            window.addEventListener('resize', function(event){
                gliftWidget && gliftWidget.redraw();
            });
        }
    };
</script>
