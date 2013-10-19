use Sartak::Blog;

BEGIN { print "title: Structured Exceptions in Moose\ndraft: 1\n" }

p { "Yesterday, Upasana Shukla's structured exceptions branch [landed in Moose](https://github.com/moose/Moose/pull/38). Her apprenticeship is now officially complete. I couldn't be happier with her work. Thank you so much for persisting through a long and challenging summer, Upasana!" };

p { "Working with Upasana has been a blast. This mentorship has given me a real appreciation for how difficult it is to break into your first programming community. There are so many challenges that we old fogeys take for granted. There are of course technical problems, like how to name methods, how to produce a clean and useful git history, how to change code in a popular project without breaking downstream consumers, how to write effective tests, and so on. But there are also many social problems to overcome, such as how to ask questions effectively, when to ignore the peanut gallery, and how to work with/around other people's schedules. These are real barriers to entry for any new contributor. It's a small wonder that anyone learns to navigate these quagmires without help from a mentor. So, please please please go easy on your newbies. It's harder for them than you realize." };

p { "Many thanks to the [GNOME Outreach Program for Women](https://wiki.gnome.org/OutreachProgramForWomen) and [The Perl Foundation](http://www.perlfoundation.org/) for helping this run as smoothly as possible. They've certainly succeeded in their goal of nurturing a newbie programmer into an expert open source contributor." };

h2 { "Backstory" };

p { "At YAPC::NA 2012 in Madison, [John Anderson](https://twitter.com/genehack) gave a [talk on the benefits of structured exceptions](http://www.youtube.com/watch?v=O1b-z7QvVW0). We all lamented Moose's stringy exceptions several times. Their existence was especially egregious because the rest of Moose is so heavily object-oriented, having been built on top of a meta-object protocol. During the Q&A for John's talk it was made clear that if anyone was willing to put in the hard work to convert Moose to structured exceptions, that branch would not only be merged, but cherished." };

p { "I sort of volunteered for that work. I'll have to review the video to judge how much of that volunteering was actually voluntary. In any case, I started a branch and never got far with it. That led to ribbing over the next six months in the Moose IRC channels that I hadn't been working on the branch." };

p { "That false start did teach me one important lesson though: the way to do it was **not** to start by ripping out the existing exception system. The right way was obviously to build the new system, then one-by-one convert the exceptions over to the new system. That way you can run the tests at any point and they should all be 100% passing. Then after all exceptions are moved over, get rid of the old system. (This is indeed how Upasana managed the complex cutover)" };

p { "So I hadn't gotten anywhere with structured exceptions. This made me a little bit sad that the project would never get off the ground and we'd be stuck with crappy string exceptions forever. But then out of the blue in March 2013, Karen Pauley asked me out of the blue:" };

blockquote { "I noticed that you were listed as a mentor for previous GSoC projects and I wondered if you would mind being a possible mentor for [the Outreach Program for Women]?" };

p { "I said absolutely, and why shucks, I have *just* the project for it!" };

h2 { "OPW Proposals" };

p { "There was a student interested in working on a Perl project. Originally she was talking to the Dancer team about an internship, but [Sawyer](https://twitter.com/PerlSawyer) suggested she also check out what Moose could offer. I began talking to Upasana and it was clear she was very eager to learn Modern Perl. I recommended she read the [Objects](http://modernperlbooks.com/books/modern_perl/chapter_07.html) chapter in [*Modern Perl*](http://modernperlbooks.com/books/modern_perl/) to see if Moose interested her." };

p { "Upasana practically demanded that she begin contributing even before she wrote her project proposal. We looked through [Moose's bug tracker](https://rt.cpan.org/Public/Dist/Display.html?Name=Moose) and found a good [candidate](https://rt.cpan.org/Public/Bug/Display.html?id=70539) for a first contribution. The ticket described how the `Num` type constraint was implemented using `looks_like_number` which is too lax in its parsing. It allows whitespace, `Inf`, `NaN`, etc. This is at odds with Moose's preference for strict validation to catch more bugs. Instead, the type constraint should be" };

p { "This ticket turned out to be a perfect first project. It was a microcosm of what I expected the structured exceptions work would be: make a substantial change in the documented behavior of Moose without causing the world to end. The fix also necessitated understanding a bit of the metaobject protocol and dealing with many levels of abstraction running through [the same body of code](https://github.com/moose/Moose/blob/50ae3f332a099b08551ba3ff76d67f9070d3e534/lib/Moose/Util/TypeConstraints/Builtins.pm#L79-87). Moose is a difficult project to hack on, but Upasana [excelled](https://github.com/moose/Moose/pull/18). I knew she would be able to handle anything else we could throw at her." };

p { "As part of that pre-proposal work, Upasana released a module [MooseX::Types::LaxNum](https://metacpan.org/module/MooseX::Types::LaxNum) that provides a `LaxNum` type constraint with the old behavior to help smooth the upgrade path to the stricter Num checking. This led her to become a CPAN contributor and learning enough about [Dist::Zilla](http://dzil.org) to be dangerous. In addition she added some [much-needed comments](https://github.com/moose/Moose/commit/e5dd0c177ce26d29217ab23c32a4452aa8919b17) to the source explaining why there was a seemingly-superfluous variable copy in the code." };

p { "Upasana's proposal passed with flying colors. She landed a real bugfix into Moose, she had a strong (and desperately needed) project proposal, and " };

p { "From the very beginning, I was impressed with Upasana's work ethic, her cheery demeanor (especially when mine wasn't!), and how downright intelligence she is. I couldn't have asked for a better student. I very much look forward to working with Upasana on future projects as equals and as friends." };

p { "As far as I know, Upasana still plans to come to [YAPC::NA 2014](http://www.yapcna.org/yn2014/) in Orlando. It would be a real shame if she had to pay for *any* of her food. :)" };
