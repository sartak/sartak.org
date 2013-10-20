use Sartak::Blog;

BEGIN { print "title: <i>Structured Exceptions in Moose</i> Mentorship\ndate: 2013-10-19\n" }

p { "For the past six months, I have been mentoring a student named [Upasana](http://blogs.perl.org/users/upasana/) for Moose. This mentorship was done through the [GNOME Outreach Program for Women](https://wiki.gnome.org/OutreachProgramForWomen) and was sponsored by [The Perl Foundation](http://www.perlfoundation.org/). Our project was to convert Moose's hundreds of exceptions from strings to a hierarchy of exception classes. This increases robustness of the entire Moose ecosystem and at the same time allows Moose to be more aggressive in updating (perhaps eventually translating?) its error messages." };

p { "Yesterday, Upasana's structured exceptions branch [landed in Moose](https://github.com/moose/Moose/pull/38). Her apprenticeship is now officially complete. I couldn't be happier with her work. Thank you so much for persisting through a long and challenging summer, Upasana!" };

p { "Working with Upasana has been a blast. It was very rewarding to teach advanced concepts and to have those lessons not only learned, but also applied. This mentorship has also given me a real appreciation for how difficult it is to break into your first programming community. There are so many challenges that we old fogeys take for granted. There are of course the technical problems, like how to name methods, how to produce a clean and useful git history, how to change code in a popular project without breaking downstream consumers, how to write tests that are effective, and so on. But there are also many social problems to overcome, such as how to ask questions effectively, when to ignore the peanut gallery, how to work with/around other people's schedules, and even how to detect jokes, sarcasm, and mood generally in text-based chat. These are real barriers to entry for any new contributor. It's a small wonder that anyone learns to navigate these quagmires without help from a mentor. So, please please please go easy on your newbies. It is harder for them than you realize." };

p { "This apprenticeship would not have been possible without the support of the Outreach Program for Women and The Perl Foundation. Many thanks to them for running this as smoothly as possible. We have certainly succeeded in their goal of nurturing a newbie programmer into an expert open source contributor." };

p { "Thanks also to [Jesse Luehrs](https://twitter.com/doyster) for being an unofficial mentor. He helped both Upasana and myself with many problems along the way. I would also like to thank the `#moose-dev` team for helping at times when I was unavailable." };

h2 { "Backstory" };

p { "At YAPC::NA 2012 in Madison, a vague blur named [John Anderson](https://twitter.com/genehack) gave a [talk on the benefits of structured exceptions](http://www.youtube.com/watch?v=O1b-z7QvVW0). We commiserated over Moose's stringy exceptions several times. Their existence was especially egregious because the rest of Moose is so heavily object-oriented, having been built on top of a meta-object protocol. During the Q&A for John's talk it was made clear that if anyone was willing to put in the hard work to convert Moose to structured exceptions, that branch would not only be merged, but cherished." };

p { "I volunteered to do that work. Maybe. You know, I really must review the video to judge how much of that volunteering was actually voluntary. In any case, I started a branch but never got far with it. That led to ribbing over the next six months in the Moose IRC channels that I had not kept my promise." };

p { "That false start did teach me one important lesson: the way forward was **not** to start by ripping out the existing exception system. It became clear that the right way was to build the new system, then convert the exceptions one-by-one over to the new system. That way you can run the tests at any point and they should still pass. Then, after all exceptions are moved over, get rid of the old system. (This is indeed how Upasana managed the complex cutover.)" };

p { "So I hadn't gotten anywhere with structured exceptions. This made me a little bit sad that the project would never get off the ground and we would be stuck with those crappy string exceptions forever. But then out of the blue in March 2013, Karen Pauley asked me:" };

blockquote { "I noticed that you were listed as a mentor for previous GSoC projects and I wondered if you would mind being a possible mentor for [the Outreach Program for Women]?" };

p { "I said absolutely, and why shucks, I have *just* the project for it!" };

h2 { "OPW Proposals" };

p { "There was a student, Upasana, interested in working on a Perl project for OPW. Originally she was talking to the Dancer team about an internship, but [Sawyer](https://twitter.com/PerlSawyer) generously suggested she also check out what Moose could offer her. I began talking to Upasana and it was clear she was very eager to learn Modern Perl. I recommended she read the [Objects](http://modernperlbooks.com/books/modern_perl/chapter_07.html) chapter in [*Modern Perl*](http://modernperlbooks.com/books/modern_perl/) to see if Moose itself interested her. Turns out it did!" };

p { "As part of the deal for OPW sponsorship, students were required to contribute a change to the project of their choice, to include in their grant application. For Upasana, we looked through [Moose's bug tracker](https://rt.cpan.org/Public/Dist/Display.html?Name=Moose) and found a good [candidate](https://rt.cpan.org/Public/Bug/Display.html?id=70539) for a first contribution. The ticket described how the `Num` type constraint was implemented using `looks_like_number` which is too lax in its parsing. It allows whitespace, `Inf`, `NaN`, and other dubious values. This leniency is at odds with Moose's preference for strict validation, favoring correctness over all." };

p { "This ticket turned out to be a perfect first project. It was a microcosm of what I hoped the structured exceptions work would be: make a substantial change in the documented and tested behavior of Moose without causing the world to end. And to work with the greater Moose community to iron out any problems. The fix itself necessitated understanding a bit of the metaobject protocol and dealing with many levels of abstraction running through [the same body of code](https://github.com/moose/Moose/blob/50ae3f332a099b08551ba3ff76d67f9070d3e534/lib/Moose/Util/TypeConstraints/Builtins.pm#L79-87). Moose is a difficult project to hack on, but Upasana [excelled](https://github.com/moose/Moose/pull/18). After this fix, I knew she would be able to handle anything else we could throw at her." };

p { "As part of that pre-proposal work, Upasana released her first module, [MooseX::Types::LaxNum](https://metacpan.org/module/MooseX::Types::LaxNum). This provides a `LaxNum` type constraint with the old behavior to help smooth the upgrade path to the stricter `Num` checking. This led her to get a CPAN account and to learn enough about [Dist::Zilla](http://dzil.org) to be dangerous. She also added some [much-needed comments](https://github.com/moose/Moose/commit/e5dd0c177ce26d29217ab23c32a4452aa8919b17) to the code implementing the `Num` type explaining why there was a seemingly-superfluous variable copy in the code." };

p { "After this fix, Upasana wrote and submitted her proposal to OPW. She had already landed a real bugfix into Moose, had a strong (and desperately needed) project outline, and had started getting involved in the community. In other words, Upasana and I conspired to make it very difficult for anyone to reject her proposal. ;) Indeed it passed through Perl's vetting with flying colors." };

h2 { "Moose Hacking" };

p { "With her proposal accepted, Upasana was eager to begin the real work. So what I did first was maliciously dump a ton of reading material on her. The first task was to finish *Modern Perl*, of course." };

p { "It was important to me that she learn from an example of exceptions done particularly well, so I pointed her at the [Conditions and Restarts](http://www.gigamonkeys.com/book/beyond-exception-handling-conditions-and-restarts.html) chapter of [*Practical Common Lisp*](http://www.gigamonkeys.com/book/). While we did not directly use any of the ideas of the condition system (because this is Perl and we really don't have any condition system… yet!), I hope that someday we can adopt more of these ideas—especially restarts—into Moose." };

p { "Because Moose is so heavily influenced by (one wouldn't even be wrong to call it a a port of) the Common Lisp Object System, it made sense for her to work through [*The Art of the Metaobject Protocol*](http://en.wikipedia.org/wiki/The_Art_of_the_Metaobject_Protocol). If you really want to hack on Moose, there is simply no way of getting around the metaobject protocol. Without an understanding of the MOP you can really only change the shallowest layers of Moose. Poorly, at that. After lots of reading of this book, and banging her head against walls, and asking questions, and experimenting, Upasana successfully grokked the MOP and has since been able to put Moose's abstractions to work fluently." };

p { "Upasana probably felt like she was thrown into the deep end with these two Lisp books, so of course I also recommended she read up on [Traits](http://scg.unibe.ch/research/traits) (which is Smalltalk). Any useful <s>exception</s> *class* hierarchy will need to make use of roles to model cross-class concerns, so understanding role theory was important. But there was also the practical aspect of being able to convert the exceptions that Moose's role implementation throws. In the end, [the roles that were designed](https://github.com/moose/Moose/tree/master/lib/Moose/Exception/Role) mostly focused around the different classes of metaobject in Moose. Once structured exceptions are used in anger, we may discover additional roles for our exception hierarchy." };

p { "At some point she was finally done with all that boring summer reading homework and started coding. The first exception we converted was the first exception in `lib/Moose.pm`. Namely, `extends` with no arguments is an error. Reading through the channel logs, I apparently recommended <s>Ender</s> Upasana convert this exception just for practice, to get a sense of how the work would go. It turns out that this practice was just as good as real work. I had not planned it that way, but there was no reason to scrap and start over once we had designed the [Moose::Exception](https://github.com/moose/Moose/blob/master/lib/Moose/Exception.pm) superclass and converted some exceptions over." };

p { "This first exception happened to have no tests, which was a recurring problem all throughout Upasana's internship. Moose is very well tested … except for its error conditions! Luckily, Upasana added nearly a thousand hand-written tests to Moose to cover its many, many exceptions. That was not easy work, since some of the errors require [odd contortions](https://github.com/moose/Moose/blob/9fe161fae0/t/exceptions/moose-meta-method-destructor.t#L64-94) to trigger. In fact, I know she would agree that the most difficult part of this internship was actually just figuring out how to replicate some of those obscure errors. In a few cases we concluded that there was simply no way to trigger a particular error, so we left such exceptions as just `confess` with a string. If anyone notices, then yay! We can use their code as the test for the new structured exception." };

p { "The groove we settled into for converting these exceptions was that one of us would pick an exception, then she would try to replicate it. In the beginning I was picking most of the exceptions, since Moose is dauntingly large and she had no way of knowing what was easy or difficult. Quickly she took over that job and preferred going through each class converting all its exceptions from the top down. If she couldn't replicate the exception, I'd give it a shot and give her hints. One of the best techniques for replicating exceptions was to edit Moose's code to change the exception message, or to change the `confess` into a `print`. Run the tests and see if any start failing. This was far more reliable than simply grepping for the error message, since the tests are written using regular expressions which don't use exact string matching, and can include variable interpolation. Either of those defeat a simple grep." };

p { "After we figured out the code to replicate the error condition, next was converting it into a test. Initially, each test would start out by simply checking the exception string against a regular expression. Then Upasana wrote a new class for that exception. Then changed the Moose code to throw an object of that class instead of the original string. Lastly, the test would be finalized by confirming that the exception class was correct, and the attribute values were as expected. This process ensured that Moose continues to throw the exact same messages for each error. It was very important that the exception object automatically stringified into the legacy message that Moose used to throw. This gave us a fighting chance at landing our huge branch without disrupting the entire ecosystem, since downstream tests for Moose's error messages would still work without modification. We even put together a [short list](https://github.com/sartak/OPW/issues/17) of exceptions whose messages should be improved later, once we are confident that most of downstream is using exception objects. Hopefully our restraint will help this cutover run more smoothly than [Perl 5.10.0's addition](https://metacpan.org/module/RJBS/perl-5.18.1/pod/perl5100delta.pod#Use-of-uninitialized-value) of the variable name in the undef warning message, which hit some [rough patches](http://www.modernperlbooks.com/mt/2010/08/the-stringceptional-difficulty-of-changing-error-messages.html)." };

p { "Finally, that exception would be done, so she would post a gist for me to review. I was unfortunately not always available to review those gists (especially during some crunch time at work), so at times they would grow and grow. I think the longest gist was something like 2000 lines long. In my reviews, I did my best to justify every change to her code that I suggested, since I wanted to foster an appreciation of what I suppose I would call *deliberate code*. No extraneous cruft, proper variable names, easily understood and maintained methods, etc. See this example [review session](https://gist.github.com/sartak/7064731)." };

p { "Repeat this 300 times and you can see how it might take a whole summer!" };

p { "We communicated through IRC for everything, but we used GitHub issues for tracking what needed doing. We ended up with nearly 300 issues covering everything from \"please review this gist\" to \"sign OPW contracts\" to an issue for pretty much each individual exception. I am a huge believer in using bug trackers (I run a personal RT instance that has nearly 3000 tickets in it), and so I am glad we found a way to make GitHub issues work for us." };

p { "Since Upasana was combing over every single file in Moose to convert those exceptions, we unearthed some interesting [little](https://github.com/sartak/OPW/issues?labels=bug&state=closed) [problems](https://github.com/sartak/OPW/issues?labels=bug&state=open) in the Moose codebase. There are some low-hanging fruit here if anyone wants to start contributing to Moose!" };

p { "A running joke was that what Upasana was currently working on was the \"hardest part of Moose\". There were at least five parts of Moose that earned that label. In order they were: all that abstraction, the meta-object protocol, method inlining, the MOP bootstrap, and metaclass <s>compatibility</s> [rebasing](https://twitter.com/doyster/status/365980446267424768). The latter of which pretty much only [Jesse](https://twitter.com/doyster) really understands. In the end, Upasana was able to manage each of these most-difficult parts of Moose. So I feel 100% confident in conferring Upasana the title of Mᴏᴏsᴇ Exᴘᴇʀᴛ. There are precious few of those. :)" };

p { "As an aside, one of the secondary topics of conversation in our channel was food. I have a nasty habit of ordering the same dishes everywhere I go. But Upasana convinced me to branch out and try some new Indian dishes like [dosa](http://www.flickr.com/photos/sartak/sets/72157634585182794/). Such food photos were a constant distraction during the mentorship. She would make fun of me for eating way too much Japanese food, since every time I posted a photo, it was invariably ramen or curry or sushi. No regrets! But I would return the favor by joking about the American fast food chains she likes, so it was all in good fun." };

h2 { "The Future" };

p { "From the very beginning, I have been impressed with Upasana's work ethic, her cheery demeanor (especially when mine wasn't!), and how downright intelligent she is. I could not have asked for a better student. I very much look forward to working on future projects with Upasana both as equals and as friends." };

p { "I learned a lot during this mentorship. Right this moment I feel like I was a terrible mentor at times. Always absent, sometimes moody, and never satisfied. Mentoring certainly took a lot more of my time and attention than I had anticipated. But reflecting on how much I have helped Upasana grow, and what we were able to achieve together, and how hard it is for a newbie to break into a community, I feel like it would be absolutely foolish for me to stop mentoring. I suppose we'll see what projects are available next OPW or Summer of Code. Howsabout conditions for Perl?" };

p { "By the way. As far as I know, Upasana still plans to come to [YAPC::NA 2014](http://www.yapcna.org/yn2014/) in Orlando. It would be a real shame if she had to pay for *any* of her food. :)" };

