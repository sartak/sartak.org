use Sartak::Blog;

BEGIN { print "title: A Curious Fringe Benefit of Learning Japanese\ndraft: 1\n" }

p { "Learning Japanese has by necessity made me a Unicode expert. That much I expected going into it. But there is another fringe benefit that I have not seen carry over to the Western world much at all. When I try to tell friends about this amazing tool every CJK computer user interacts with all day every day, it falls flat because it's all, well, Japanese to them." };

p { "Now that I am writing leisurely, that is no problem. So for a few brief moments, take off your ASCII goggles and let me introduce you to the **Input Method Editor**." };

h3 { "Background" };

p { "Japanese is made up of [four scripts](http://en.wikipedia.org/wiki/Japanese_writing_system): romaji, hiragana, katakana, and kanji. Back in the early days of computers, due to technical limitations, everything was written using [half-width katakana](http://en.wikipedia.org/wiki/Half-width_kana):" };

p { "ﾓｸﾃｷﾁｦﾀｯﾌﾟﾃﾞｶｰｿﾙｲｺｳ,OKﾎﾞﾀﾝﾃﾞｹｯﾃｲｼﾏｽ" };

p { "This is comprehensible, but absolutely exhausting to read, JUSTLIKEIFEVERYTHINGINENGLISHWEREWRITTENLIKETHIS. Nowadays, since computers are a little bit smarter, we can write in full-width characters, and in all four scripts:" };

p { "目的地をタップでカーソル移動、OKボタンで決定します" };

p { "You're probably aware that there are thousands upon thousands of kanji characters. There were seven of them in the above sentence. There are also the hiragana and katakana scripts, of which there are about fifty, depending on how you count." };

p { "How the hell can anyone type all these characters?" };

div {
    style is "text-align: center";
    image "a-curious-fringe-benefit-of-learning-japanese/google-keyboard.jpg";
    i { "Not like [this](http://googlejapan.blogspot.com/2010/04/google.html)!" };
};

h3 { "Input Method Editor" };

p { "It turns out that you can type bona fide Japanese using even a standard English keyboard. Like most problems in computer science, typing Japanese is accomplished using *indirection*." };

p { "If you've been typing English all your life, you've come to expect that a single keystroke causes a single character being sent to the active application. There's some handwaving there for modifier keys like shift, but that's effectively how it works. And for English that works perfectly well." };

p { "Typing Japanese works differently. Instead of keystrokes mapping directly to character input, your keystrokes are collected into an intermediate buffer. The user then massages that text into the desired result. When satisfied, the user signals that the finished text is to be sent to the active application. The software that manages this process is called an Input Method Editor, or IME. The IME is built directly into your operating system, so it is not clumsy or annoying to use." };

p { "So if I wanted to type our example sentence, I'd first write it in the general, phonetic script, hiragana:" };

p { "もくてきちをたっぷでかーそるいこう、おkボタンでけっていします" };

p { "That text would then exist in an intermediate buffer managed by the IME. The IME would then work through each word with me to render it in the correct script. Notice how the text does not match the regular body color, since none of what I typed is actually sent to my text editor yet." };

image "";

p { "It does a great job on this first pass, guessing everything correctly except 「おk」 (which is a little bit surprising to me). Since I can't accept either of the two complete suggestions it offers, I'll go through the sentence word by word and select the correct rendering of each token." };

h3 { "IME Hacks" };

p { "Now the fun part. We have this indirection between keystrokes and character input. What else can we do with that?" };

h4 { "Autocomplete" };

p { "What if I were to start typing the same sentence again?" };

image "";

p { "It's like autocomplete for anything you've ever typed! I use this feature *constantly*. Why should *I* have to remember anything when the computer can do it for me?" };

h4 { "Custom Words" };

p { "Just like any other language, Japanese has trendy new words, slang, and other typographic oddities. The IME lets you register custom words. For whatever reason, the IME doesn't understand that されこうべ (*sarekoube*, skull) is rendered as 髑髏." };

image "";

p { "Well, I can fix that by adding a custom dictionary word for it." };

image "";

p { "Now I can type 髑髏!" };

p { "That is how custom dictionary entries are meant to work. But of course we are not limited to just Japanese words." };
