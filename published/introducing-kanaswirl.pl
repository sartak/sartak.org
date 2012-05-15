use Sartak::Blog;

BEGIN { print "title: Introducing KanaSwirl\ndate: 2012-05-14\n" }

outs_raw '<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>';

div {
    style is "float: right; padding-bottom: 1em; padding-left: 1em";
    a {
        href is "http://rpglanguage.net/KanaSwirl.app";
        image "introducing-kanaswirl/KanaSwirl-256x256.png";
        p { style is "text-align: center"; "KanaSwirl in the App Store" };
    };
};


outs_raw << 'ENDJS';
    <script type="text/javascript">
        $(function () {
            if (navigator.userAgent.match(/iPhone/i)) {
                $("#audience").html("You");
            }
        });
    </script>
ENDJS

p { "<span id=\"audience\">Some of you</span> are reading this on the most efficient language learning device ever designed: the iPhone. It can store many days' worth of target language music and podcasts, many lifetimes' worth of target language books, countless mono- and bilingual dictionaries, and includes an operating system localized to practically any language people speak. Not to mention there are loads of great apps designed for and by speakers of your target language. And it even fits in your pocket so you can carry your immersive environment with you all the time." };

p { "To that end, I have written and released a game called [KanaSwirl](http://rpglanguage.net/KanaSwirl.app). It teaches you the 46 Japanese hiragana characters in a fun, quick, and easy way. It is the kind of app I wish existed when I was starting out with Japanese. It took me something like two months to become comfortable with the kana. I hope my game enables everyone to trounce that." };

p { "If you have finished going through the learning process, KanaSwirl looks like this:" };

image "introducing-kanaswirl/game-half.png";

p { "Given the prompt MU you tap the corresponding kana, む. Pretty simple, which is the point! You can pick it up at any time and do as many reviews as you like." };

p { "Even simpler, if you are just starting out, the game goes easy on you. You start off with just two characters, あ and い. Once you get the hang of those, the game teaches you う, and so on." };

image "introducing-kanaswirl/easy-half.png";

p { "The game dynamically responds to how well you're doing. On the individual game level, if you are correctly answering the prompts quickly or slowly, characters are added to or removed from the circle. And again, on the global level, if you have been generally answering all the characters correctly, KanaSwirl will teach you the next character." };

p { "It also tracks and offers some statistics about your reviews. I am very interested in expanding this part of the experience. I look forward to the day my app bluntly tells me what characters I frequently confuse." };

image "introducing-kanaswirl/statistics-half.png";

p { "I had a very fun week creating this game. The only problem is my Japanese study suffered a _lot_ that week. :)" };

h3 { "Anki" };

p { "KanaSwirl may seem like a competitor to [Anki](http://ankisrs.net), but I think both have their own separate strengths and complement eachother. I love Anki to death, and if I have any success with Japanese it is Anki's fault. Anki is certainly better at keeping tens of thousands of facts in your head (I'm living proof!). It is also not limited to individual words or characters like KanaSwirl is, but works with complete sentences or even pictures." };

p { "KanaSwirl has its advantages too. For one, when you finish your Anki reviews for the day, it can be harmful to its spacing algorithm to get a head start on future reviews, so you cannot sink as much free time into it as you have -- you stop reviewing when it says you are done. Secondly, Anki is simply very sterile. This is certainly desirable for the kind of proper study tool Anki is, but KanaSwirl intentionally makes it fun. Finally, Anki does not guide you into learning new stuff. It is strictly for reviewing the content you have imported into it. KanaSwirl introduces new characters to you as you become ready for them." };

p { "Ultimately I want *games* I don't feel guilty playing. Sure Angry Birds is entertaining, but at the end of the day what do you get out of it?" };

h3 { "XCode/Objective-C development" };

p { "This was my first non-Perl project in a very long time. It was also my very first Objective C exposure. I'm having a blast with it. It feels more natural as a C-with-objects than C++ ever did. Even though it is a statically-typed, compiled language, I don't feel constrained. Other than by the lack of `map`. Integer division tripped me up until I realized it was happening." };

p { "Though Objective C is of course a C-like language, memory management was surprisingly trivial. I wrote the initial bulk of the code without concerning myself with memory problems. Occasionally I segfaulted on sending a message to an `autorelease`d value. Apple provides a useful tool called _Zombies_ for detecting and fixing that class of problem. The morning of the day I submitted version 1.0 for review, I decided to actually look at how much memory my app was leaking. Another tool Apple provides as part of its _Instruments_ toolset is _Leaks_. To find the sections of code that were causing memory leaks, all I had to do was launch the app, play around until Leaks found something, then examine stack traces. All told, nearly all of my errors were caused by blindly using `[[NSString alloc] initWithFormat:]` which creates a string object using `sprintf`-style interpolation. The problem is that strings constructed that way must be manually released." };

p { "XCode is a solid IDE, and that is saying a lot coming from a die-hard vim user. I am productive even without [XVim](https://github.com/JugglerShu/XVim) (vim bindings for Xcode). Admittedly I did copy blocks of code into vim for the nastiest edits I needed to do." };

p { "I'm using the [cocos2d](http://www.cocos2d-iphone.org/) game framework and I'm quite impressed with how easy it is to use." };

code_snippet objc => '
id twirlAndMove = [CCSpawn actions:
                    [CCRotateBy actionWithDuration:spinoutDuration angle:360],
                    [CCMoveBy actionWithDuration:spinoutDuration position:ccp(x,y)],
                    nil];
[kanaButton runAction: twirlAndMove];
';

p { "After adding those simple lines of code the app suddenly became a game. Now instead of simply popping into existence in-place, the kana buttons you tap to answer questions now simultaneously rotate 360 degrees and move from the center to their desired position (calculated with `sin` and `cos`). Now the game is dynamic. cocos2d is full of easy, effective tools like this. Another tool I want to highlight is scene transitions -- just a single additional function call lets you page flip from one scene to the other, or slide, or any of the other dozens of builtin transitions. The only thing I have found lacking so far is drawing individual pixels or lines. You can do it with OpenGL but it isn't as frictionless as the rest of the API." };

p { "The only big stumbling block I had was designing the icon. I think it's passable. The designy bits in the app is actually limited to programmatic effects: transitions, animations, and particle effects. For particle effects I used an app called [Particle Mint](http://itunes.apple.com/us/app/particle-mint/id445400440) which gives you live previews and editing on the device you will eventually run the game on. I wouldn't say it was a delight to use, but it definitely got the job done without getting in my way too much." };

p { "iPad support wasn't tricky at all. I just needed to switch to using sizes and positions that refer to screen size instead of a constant number of points. So if there ever were a third iOS device size, I probably would not need to change much code to support it." };

h3 { "See also"};

p { "I have been tweeting as [\@RPGlanguage](http://twitter.com/RPGlanguage) since day one about this project, including lots of screenshots and development notes. RPGlanguage is my umbrella name for the (many!) games I plan to write."};

p { "There's also a token website [rpglanguage.net](http://rpglanguage.net) which is currently just more KanaSwirl screenshots." };

br {};

p { "I look forward to hearing your feedback! I'm very proud of what I created." };
