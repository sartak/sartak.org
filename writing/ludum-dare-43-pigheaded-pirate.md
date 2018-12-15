title: My Ludum Dare 43 game: Pigheaded Pirate
date: 2018-12-14
rownav: 1
draft: 1

Over the weekend of December 1st, I participated in the [Ludum Dare 43](https://ldjam.com/events/ludum-dare/43/) game jam. I chose the Compo track, so I made a complete game from scratch, solo, in 48 hours. The theme of the jam was "sacrifices must be made", which I  incorporated by creating a side-scrolling beat-'em-up game where your weapon is your partner.

You can play Pigheaded Pirate at [https://pigheaded-pirate.com](https://pigheaded-pirate.com) or _right here_:

xxx

## Preparation

I've made games before, but the last couple have been for iOS using SpriteKit. I intentionally chose to not use either one for this game jam to satisfy a few necessities: a lightning quick edit-build-test feedback loop (compiling and deploying to a phone still takes tens of seconds which is _forever_), the widest possible audience (not everyone has an iPhone, or even uses Windows, etc, but 100% of participants do have a web browser), and being able to own the release process rather than dealing with app review.

JavaScript has grown up to become quite a nice language--destructuring bind is such a nice quality of life feature--but choosing it left me with a problem: I've never made a game with JS before. So a few days before the jam began, I googled "JavaScript game engine" and ended up picking the first result. As you do. That engine, [Phaser](), provides all the primitives I know I need: sprites, animations, sound effects, particle systems, a physics engine, etc. The one feature that seems to be iffy is shader support, but that was acceptable because I had only 48 hours to work with, and writing shaders can take me a long while because my usual debugging repertoire doesn't transfer. And also, like, a small part of my monkey brain is stuck in 2003 when even just trailing commas could wreck some shit, and directly programming the GPU on the web seems like landing on Mars by comparison.

To exercise all those features and to get a feel for Phaser itself, I made a dumb prototype that turned out to be more fun than it rightly deserves. I blame that on physics engines being remarkably effective.

xxx

I'm glad I did make that prototype 

I streamed my entire Ludum Dare game dev live on Twitch. To give viewers (and honestly myself) a sense of the progress I made a [script]() which I used to track real and effective dev times. (Effective meaning I paused the clock for breaks)

(xxx screenshot)

I wanted a great edit-build-test iteration cycle. I believe strongly that quick (ideally _instant_) feedback is a disproportionately important part of any software engineering endeavor. But it's especially true for making games. So I wanted code linting with automatic fixups, type checking results right in Vim, automatic reload on changes, and so on. I profess to be a web developer so this is the sort of thing I certainly ought to be able to set up myself with webpack, babel, prettier, etc. But I am also pretty lazy, so I just used [create-react-app]() which offers a great developer experience out of the box.

I did have to eject out of create-react-app immediately due to Phaser refusing to handle automatically-inlined `data:` images, seemingly [only out of principle](). The Flow type checker handles some types of static assets like png and json perfectly well, but errors out on other types like wav and mp3 until you [add a shim for each content type](). `yarn build` would throw `Unknown browser query ‘dead’` errors until I [found and upgraded]() all the nested copies of `css-loader` throughout my dependency tree.

Web development, am I right? Luckily I ironed all that out before the jam started!

I didn't use any React for the game itself, but it did supply the "frame" of the game, meaning everything else that's on the page. I made good use of the distinction between development and production builds. In dev mode, I had a prominent link to the game that anyone who caught the Twitch stream could visit to try the game in its current state. I didn't end up needing it, but I also had a solid plan for using React to build debug controls (sliders, textboxes) that would feed into the game logic to drive down that feedback cycle further. In production mode, the page instead explains that it's a Ludum Dare game.

I also made sure to have plenty of coffee and mostly-awful snacks on hand.

## The Forty-Eight Hours

Here's a timelapse of the entire game development from scratch to shipped. I also included some gameplay videos throughout to show the game at each milestone, which I hadn't seen before:

xxx

Back of the envelope math told me I was gonna need more disk space than I will have had available for that timelapse, so I saved each of the fifteen thousand screenshots directly to an external hard drive. But I always feel anxiety about wearing down that spinning rust. By the way, in macOS, the way to programmatically take a screenshot of a second monitor is to provide multiple output filenames to `/usr/sbin/screencapture`. The `--help` output doesn't make that super clear.

I also set up a super legitimate keylogger just for kicks. Some interesting takeaways from that:

* I supposedly typed a *million* keystrokes that weekend, which is a sustained, I dunno, 80 wpm? I think a lot of that must have been mashing on the arrow keys to play. Shift and other control characters were also counted as separate keystrokes.
* My most commonly typed letters were `z` (due to being the primary action in the game), `j` and `k` (because vim), `w` (also vim… I use word-based movement commands a _lot_). All these were an order of magnitude more than other letters.
* (histogram)

### Todo

I love using my todo list. scratchpad. GTD

XXX tracking work with omnifocus was awesome, especially the new tags feature in OF3. I could slice my work up however I was feeling: code vs artwork, maybe vs blocker, etc


### Coding

I'm an engineer, so this was the easy part. All advice I've seen on game jams say to get the game mechanics done as quickly as possible -- like done within a few hours -- to leave the rest of the time for art, polish, balance, and any other connective tissue (in this game's case, victory condition and advancing between levels, but any non-gameplay features like a start menu, save game system, etc). From the timelapse you can see that I managed to follow that advice: picking up the sidekick, throwing them at enemies, scrolling the level, enemies spawning in waves, etc were all there by hour 10.

window.state but only in dev mode

Skill that would increase enemy damage or decrease pighead damage. You could go through the game without making sacrifices but who would play that way? (Unfortunately I don't have analytics to show whether anyone did this!)

On death should apply an impulse to all enemies

seahorses too hard

### Game Feel

A definition of "game feel" I like is providing the maximum amount of output for the minimum amount of player input. Animations, particle effects, sound effects, screen shake, haptic feedback, all work together to make the player feel a sense of direct connection with the game world. This makes a game objectively way more fun, even if they all have exactly zero impact on the game mechanics. Combining game feel and game mechanics is great too: when you throw the partner, the pirate gets pushed back a bit. Pighead recoil.

The walking animation of the pirate is pretty sloppy but our brains are good at fixing it in post. So it was worth doing.

The level transitions got a few "oohs" and "ahhs", but it was pretty easy to do that because I already had the level divided into 32x32 tiles. They were even separate physics bodies

### Bugs

There were four _significant_ bugs I had to solve. And most of those, and my other toil throughout the jam, was due to physics. Now, I do truly enjoy physics engines, both as a player and as a designer. They add a lot of depth, character, potential for skill, and novel design possibilities to a game. Pigheaded Pirate would be _way_ less fun without penguins getting knocked back, rolling into eachother, and the pighead bouncing off realistically. Yeah, that's right, "realistically".

With a physics engine, you simply set up with some bodies and occasionally apply impulses, then each frame it dutifully spits out positions, velocities, rotations, collisions, and so on. That's a remarkably outsized result for how much work you have to do. But sometimes what it spits out is just off. And there's little recourse for the designer when that happens. For one thing, the physics engine has to be run in realtime, so it can only do approximations at best. Two, it is hard to figure out the right set of inputs to mesh together to produce results that feel good, since the two are at very different levels of abstraction (hi Seena!). Third, you probably need a much more mature math background than I have to understand, much less tweak or even fix, the code for the engine itself. So, for me, a physics engine is pretty much the platonic ideal of a black box.

In future jams, I would probably shy away from any physics-engine-shaped game. There's just not enough time to deal with it. Here's what I mean.

#### Jumping

Using a physics engine for a game with platforming elements is really tempting fate. 

When are you touching the ground? When you are you touching the a wall?

xxx collision begin & end vs active. Switching to a tile-based map broke jumping.

#### The game is suddenly not fun

ice skates

#### Density

The game started out with each rectangle being a character.

In trying to solve the previous issue I reverted back from near-pixel-perfect physics bodies to rectangles.

I ended up not turning near-pixel-perfect physics bodies back on because it would be a hassle and I was out of time.

#### Parallax scrolling

### Theme and Motif

It took me only twenty minutes to figure out what genre of game to make (beat-em-up) and how to apply the theme (throw your partner at enemies to sacrifice them). I've played a lot of Streets of Rage 2 in my day, so I was excited to make a beat-em-up. If you look carefully in the timelapse you can see me watching Streets of Rage videos both to get some inspiration and to get amped up (oh that music!)

The more interesting question is why the pigs, pirates, and penguins motif? At about the halfway point, the game mechanics were essentially done. So I ran out of things to structuredly-procrastinate on the motif, and so I put down the computer for a bit to brainstorm what to replace those solid-color rectangle character sprites with.

Luckily I came up with some pretty specific criteria that I felt important to hit:

* The motif had to be somewhat novel. Specifically _not_ vigilantes beating up gangs, which is what most beat-em-up games use.
* The main character needed sufficient motivation to sacrifice, and that motivation needed to serve as the literal goal at the end of each level. This is the constraint that I started brainstorming from. Pirates are all about booty.
* The partner had to be substantial to make the jam's "sacrifices must be made" theme work. If you're just throwing, say, a _parrot_ around, that is not really a plausible sacrifice. That also feels like it would have been a bit too Angry Birds.

I got stuck here though. The pirate motif is novel enough (and treasure offers fringe benefits: it's easy for the player to understand and for me to make the art for. If you look carefully the treasure glows nicely too, which is an effect I only recently learned how to do). But where did the pigs come from? Well, the constraints suggest that the pirate must be obstinate about lust of treasure over love of their partner. The thesaurus provided a very evocative synonym of obstinate: pigheaded. That trivially supplied the name of the game. (Too trivially, in fact; after about ten more seconds of thought, Pirate Pighead is a better name. Oh well!). The partner also being a pig was a pretty straightforward leap.

Mashing together pigs and pirates also satisfied another constraint that I had come up with before the jam even started: the game must have elements of what I naïvely call *normalized absurdity*. Which is essentially the notion that players will _gladly_ let you take them to absolutely ridiculous places, so long as you, the designer, do so rigorously. In other words, instead of breaking the fourth wall, double down on the absurdity. That's why the pighead both squeals and yells "avast!!". Because pig pirates, duh. XXX - xxx description xxx - is a good example of this. Crypt of the Necrodancer, too, is exactly what it says on the tin, and they go all-in on that idea. For me, the prototypical example of normalized absurdity is this clip:

I think Pigheaded Pirate offered a mediocre glimpse at normalized absurdity. Quite a few people commented positively on the motif being silly and fun though, which suggests to me the idea has legs. If I had more time, things like an actual squeal when you throw the pighead, better art (though it still tickles me to no end that the pirate pig has a beard), and so on would have worked together to further sell the absurdity.

This probably says a lot about my own sense of humor.

The specific enemies and settings I chose did not come until a bit later. My initial ambitions of fighting off swole shark bros were stymied by my shoddy art skills. On level two, the rectangle characters would tip over and slide down the ramps headfirst which suggested a penguin to me. I was pretty happy with that because with a penguin I could also get away with not creating a walking animation. Seahorse too. The crab would have pretty easy to animate, but I ran out of time for that.

I needed to choose settings that would be easy to produce assets for. Level one you are on a ship, level two you've shipwrecked and sunk to the briny deep, level three you're climbing onshore a volcanic, tropical island. Probably few players consciously picked up on the setting, which is totally fine because it's not important or novel. But it probably is important that there is some kind of logical progression at all. I'm sure you can tell I was obviously far too sleep-deprived when I drew the background for level three.

### Shipping

Releasing the game was stress-free because throughout the jam I had already shipped a couple dozen releases, one per milestone. To do so I'd set up this pre-push hook in git that built a production bundle and rsync'd it over as static files:

xxx syntax highlighting

    cd ~/devel/ld43
    yarn build && rsync -avz build/ ld43.sartak.org:/var/www/ld43.sartak.org

Since I was using eslint and babel, I also had no concerns about unexpected browser compatibility issues, even using such advanced features as destructuring bind and trailing commas.

As soon as I figured out the name of the game, I registered the domain for it and had it ready before the jam ended, which I thought was pretty nifty.

## Reception

My plan for this Ludum Dare was to plausibly simulate all parts of the game development lifecycle, even before and after the 48 hours. I am satisfied that I was able to achieve everything I set out to do… _except_ create music for the game. I can't be surprised by that though, because I've literally never created music before. That's something I plan to work on over the next year (as well as pixel art). In fact, even as an engineer, I think polished art is _the_ single most important aspect of a game, as it's what gives the lasting first impression. In future games, I will aim for simpler but cleaner art styles. I'm sure I could've made those rectangle character sprites work. Also on that note, I invested a lot of time in the _last minute_ experience of the endgame cutscene, but I should have spent it instead on the _first minute_ experience to keep more players in the funnel.

Not monetizing the game was intentional, but given my [day job](https://stripe.com), I'm sure I could figure that out.

I was surprised at how hungry streamers are for novel games, and so Ludum Dare is a surprisingly good way to get some Twitch attention. I reached out to a few game streamers (make sure to use the specific method that each streamer requests!) and got [largely]() [positive]() [feedback]().

I also did my own stream of livecoding the whole thing. I probably won't stream game jam development again since I ended up having only a few viewers throughout, which was not worth taxing my CPU, network, screen real estate, attention, etc. My laptop held up pretty well with all that and driving a 4K display and playing a 60 FPS game. Not perfectly though, as Vim segfaulted several times which was alarming.

There are still a few weeks before ratings get published. But once those do I'll update this section. I'm lightly optimistic that I made it into the top 100 games.

There are some other _really_ good games though. I'm super blown away by [Total Party Kill](https://ldjam.com/events/ludum-dare/43/total-party-kill) which is a puzzle platformer which just gets everything, especially the theme, right:

Other games I enjoyed were [Sirius Galactica](https://ldjam.com/events/ludum-dare/43/sirius-galactica), [Eldritchual](https://ldjam.com/events/ludum-dare/43/eldritchual), and [My Scrimbles](https://ldjam.com/events/ludum-dare/43/my-scrimbles).

Overall, very highly recommended! Can't wait for the next Ludum Dare.
