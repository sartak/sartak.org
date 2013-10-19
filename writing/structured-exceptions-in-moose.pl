use Sartak::Blog;

BEGIN { print "title: Structured Exceptions in Moose\ndraft: 1\n" }

p { "Yesterday, Upasana Shukla's structured exceptions branch [landed in Moose](https://github.com/moose/Moose/pull/38). Her apprenticeship is now officially complete. I couldn't be happier with her work. Thank you so much for persisting through a long and challenging summer, Upasana!" };

p { "Working with Upasana has been a blast. This mentorship has given me a real appreciation for how difficult it is to break into your first programming community. There are so many challenges that we old fogeys take for granted. There are of course technical problems, like how to name methods, how to produce a clean and useful git history, how to change code in a popular project without breaking downstream consumers, how to write effective tests, and so on. But there are also many social problems to overcome, such as how to ask questions effectively, when to ignore the peanut gallery, how to work with/around other people's schedules, and even detecting jokes, sarcasm, and general mood in text-based chat. These are real barriers to entry for any new contributor. It's a small wonder that anyone learns to navigate these quagmires without help from a mentor. So, please please please go easy on your newbies. It's harder for them than you realize." };

p { "Many thanks to the [GNOME Outreach Program for Women](https://wiki.gnome.org/OutreachProgramForWomen) and [The Perl Foundation](http://www.perlfoundation.org/) for running this as smoothly as possible. We've certainly succeeded in their goal of nurturing a newbie programmer into an expert open source contributor." };

h2 { "Backstory" };

p { "At YAPC::NA 2012 in Madison, [John Anderson](https://twitter.com/genehack) gave a [talk on the benefits of structured exceptions](http://www.youtube.com/watch?v=O1b-z7QvVW0). We all lamented Moose's stringy exceptions several times. Their existence was especially egregious because the rest of Moose is so heavily object-oriented, having been built on top of a meta-object protocol. During the Q&A for John's talk it was made clear that if anyone was willing to put in the hard work to convert Moose to structured exceptions, that branch would not only be merged, but cherished." };

p { "I volunteered to do that that work. Sort of. You know I really must review the video to judge how much of that volunteering was actually voluntary. In any case, I started a branch but never got far with it. That led to ribbing over the next six months in the Moose IRC channels that I hadn't kept my promise." };

p { "That false start did teach me one important lesson though: the way to do it was **not** to start by ripping out the existing exception system. It became clear that the right way was to build the new system, then convert the exceptions one-by-one over to the new system. That way you can run the tests at any point and they should still pass. Then, after all exceptions are moved over, get rid of the old system. (This is indeed how Upasana managed the complex cutover)" };

p { "So I hadn't gotten anywhere with structured exceptions. This made me a little bit sad that the project would never get off the ground and we'd be stuck with crappy string exceptions forever. But then out of the blue in March 2013, Karen Pauley asked me:" };

blockquote { "I noticed that you were listed as a mentor for previous GSoC projects and I wondered if you would mind being a possible mentor for [the Outreach Program for Women]?" };

p { "I said absolutely, and why shucks, I have *just* the project for it!" };

h2 { "OPW Proposals" };

p { "There was a student interested in working on a Perl project for OPW. Originally she was talking to the Dancer team about an internship, but [Sawyer](https://twitter.com/PerlSawyer) suggested she also check out what Moose could offer her. I began talking to Upasana and it was clear she was very eager to learn Modern Perl. I recommended she read the [Objects](http://modernperlbooks.com/books/modern_perl/chapter_07.html) chapter in [*Modern Perl*](http://modernperlbooks.com/books/modern_perl/) to see if Moose itself interested her. Turns out it did!" };

p { "Upasana practically demanded that she begin contributing before she even started putting together her grant application. We looked through [Moose's bug tracker](https://rt.cpan.org/Public/Dist/Display.html?Name=Moose) and found a good [candidate](https://rt.cpan.org/Public/Bug/Display.html?id=70539) for a first contribution. The ticket described how the `Num` type constraint was implemented using `looks_like_number` which is too lax in its parsing. It allows whitespace, `Inf`, `NaN`, etc. This leniency is at odds with Moose's preference for strict validation to catch more bugs." };

p { "This ticket turned out to be a perfect first project. It was a microcosm of what I expected the structured exceptions work would be: make a substantial change in the documented behavior of Moose without causing the world to end. And to work with the greater Moose community to iron out any problems. The fix itself necessitated understanding a bit of the metaobject protocol and dealing with many levels of abstraction running through [the same body of code](https://github.com/moose/Moose/blob/50ae3f332a099b08551ba3ff76d67f9070d3e534/lib/Moose/Util/TypeConstraints/Builtins.pm#L79-87). Moose is a difficult project to hack on, but Upasana [excelled](https://github.com/moose/Moose/pull/18). I knew she would be able to handle anything else we could throw at her." };

p { "As part of that pre-proposal work, Upasana released her first module, [MooseX::Types::LaxNum](https://metacpan.org/module/MooseX::Types::LaxNum). This provides a `LaxNum` type constraint with the old behavior to help smooth the upgrade path to the stricter `Num` checking. This led her to get a CPAN account and to learn enough about [Dist::Zilla](http://dzil.org) to be dangerous. She also added some [much-needed comments](https://github.com/moose/Moose/commit/e5dd0c177ce26d29217ab23c32a4452aa8919b17) to the Moose source explaining why there was a seemingly-superfluous variable copy in the code." };

p { "Upasana's proposal passed through Perl's vetting with flying colors. She had landed a real bugfix into Moose, she had a strong (and desperately needed) project outline, and began getting involved in the community, so we cleverly made it very difficult for anyone to reject her proposal. ;)" };

h2 { "Moose Hacking" };

p { "With an accepted proposal, Upasana was eager to begin the real project. So I deviously dumped a lot of reading material on her. The first task was to finish reading *Modern Perl*, of course." };

p { "I felt it was most important that she see an example of exceptions done right, so I pointed her at the [Conditions and Restarts](http://www.gigamonkeys.com/book/beyond-exception-handling-conditions-and-restarts.html) chapter of [*Practical Common Lisp*](http://www.gigamonkeys.com/book/). While we didn't directly use any of the ideas of the condition system (because this is Perl and we really don't have it yet ☹), I hope that someday we can adopt more of these ideas, especially restarts, into Moose." };

p { "Because Moose is so heavily influenced by (one wouldn't be wrong to call it a a port of) the Common Lisp Object System, it made sense for her to work through [*The Art of the Metaobject Protocol*](http://en.wikipedia.org/wiki/The_Art_of_the_Metaobject_Protocol). If you really want to hack on Moose, there is simply no way of getting around the metaobject protocol. Without an understanding of the MOP you can really only change the shallowest layers Moose (poorly). After lots of reading of this book, and banging her head against walls, and asking questions, and experimenting, Upasana managed to grok the idea and has been able to grasp Moose's abstractions no problem." };

p { "Upasana probably felt like she was thrown into the deep end with these two Lisp books, so of course I also recommended she read up on [Traits](http://scg.unibe.ch/research/traits) (which is Smalltalk). Any useful exception hierarchy will need to make use of roles to model cross-class concerns, but also Upasana would need to grok roles to be able to convert the exceptions that Moose's role implementation would throw. In the end, the roles that were produced mostly centered around the different classes of metaobject in Moose. Once structured exceptions are used in anger, we may discover additional roles for our exception hierarchy." };

p { "At some point she was finally done with all that boring summer reading homework and started coding. The first exception we converted was the first exception in `lib/Moose.pm`. Namely, `extends` with no arguments is an error. Reading through the channel logs, it turns out I recommended <s>Ender</s> Upasana convert this exception as practice, just to get a sense of how the work would go. It turns out that practice was really just the real work; I hadn't planned it that way, but there was no reason to start over once we had designed the [Moose::Exception](https://github.com/moose/Moose/blob/master/lib/Moose/Exception.pm) superclass." };

p { "This first exception happened to have no tests, which turned out to be a recurring problem all throughout Upasana's internship. Moose is very well tested except for its error conditions! Luckily for us, Upasana added nearly a thousand hand-written tests to Moose, to cover Moose's many error cases. That was not easy work, since some of the errors require [some contortions](https://github.com/moose/Moose/blob/9fe161fae0/t/exceptions/moose-meta-method-destructor.t#L64-94) to tickle." };

p { "As an aside, one of the recurring topics of conversation in our OPW channel was food. I have a nasty habit of ordering the same dishes everywhere I go. But Upasana convinced me to branch out and try some new Indian dishes like [dosa](http://www.flickr.com/photos/sartak/sets/72157634585182794/). Food photos were a constant distraction during the mentorship. She'd make fun of me for eating way too much Japanese food every time I posted a photo of ramen or curry or sushi. No regrets! But I'd return the favor by joking about the American fast food chains she likes, so it was all in good fun." };

h2 { "The Future" };

p { "From the very beginning, I was impressed with Upasana's work ethic, her cheery demeanor (especially when mine wasn't!), and how downright intelligence she is. I couldn't have asked for a better student. I very much look forward to working with Upasana on future projects as equals and as friends." };

p { "As far as I know, Upasana still plans to come to [YAPC::NA 2014](http://www.yapcna.org/yn2014/) in Orlando. It would be a real shame if she had to pay for *any* of her food. :)" };
