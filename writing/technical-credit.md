title: Technical Credit
date: 2018-01-03
rownav: 1
draft: 1

If you're a programmer, you've probably heard of the term "technical debt". I've only recently come across the opposite term, "technical credit". While technical debt slows down a project, technical credit accelerates it and pays dividends.

This idea, especially now that it's been given a name, is very compelling. I strive to practice mindfulness in my pursuits, which has me considering my experiences with technical credit. What sorts of technical credit have my projects accumulated? How was I able to amplify my efforts by putting that credit to work? Investing the time to build a novel abstraction could just as easily lead to debt as to credit (giving rise to the quip _You Ain't Gonna Need It_); can I tell, in advance of designing it, which way an abstraction will end up going?

I'm certainly still pondering these questions. But I'm ready to start sharing some of the successes of my current project viewed through the lens of technical credit. Briefly, the project is a new turn-based RPG for iOS built in Objective-C using SpriteKit. (You'll hear a lot more about it soon.)

## `YWAction`

### Investment

The richest technical credit in this project is the `YWAction` abstraction. (By the way, a two-letter prefix like `YW` is Objective-C's poor man's way of dealing with namespacing). Essentially, a `YWAction` is an object that orchestrates updates to the game state, the display, or both. The fundamental API for a `YWAction` is very simple:

```
@interface YWAction : NSObject

-(void)initWithLevel:(YWLevel *)level viewDelegate:(id<YWActionViewProtocol>)viewDelegate fromSpec:(NSDictionary *)spec;

-(void)updateState;

-(void)runAnimations:(void (^)(void))completion;
```

For those unfamiliar with Objective-C, the way to read this is that there is an `YWAction` class, which inherits from the superclass `NSObject`. This class offers an _initializer_ (essentially a constructor) and two methods. The `initWithLevel:viewDelegate:fromSpec:` initializer takes three parameters: 1) an object of class `YWLevel`, 2) an object which conforms to the `YWActionViewProtocol` _protocol_ (like a Java interface or Moose role), and 3) a dictionary (hash table). Next, the `updateState` method takes no parameters and returns no value. Finally, the `runAnimations:` method takes one parameter and returns no value. The `completion` parameter is a _block_ (a closure) that takes no parameters and returns no value.

That's the syntactical description of this class. What does this class _do_? In `updateState` the action makes some set of updates to the `YWLevel` _model_ object (which has a map, lists of enemies and items, and so on). It also, separately, applies changes to the game's _view_ (such as "add this sprite", "prompt the player", etc). As `runAnimations:`'s API suggests, view updates need not be instantaneous. If an action needs to run an animation, it can schedule one. Then, after the passage of wallclock time, after the view updates have finished animating, the action arranges to have that `completion` callback invoked.

Here are a few examples of `YWAction` subclasses to give you some texture to crunch on.

- `YWActionMove` takes an actor and a direction to walk. The `updateState` method changes the actor's tile from the origin tile to the destination tile. The `runAnimations:` animates the actor's position from the origin coordinate to the destination coordinate. It also iterates through the actor's walk animation sprites. Those animations together take a fraction of a second. Once the animation is over, the actor's sprite is on the new tile, and so `YWActionMove` then invokes its `completion` callback.

- `YWActionDropItem` takes an actor and an item. The `updateState` method removes the item from the actor's inventory and moves it to the actor's current tile. `runAnimations:` adds the item's sprite to the scene. This could presumably be done without any animations (just plop the thing onto the screen), in which case it could immediately call `completion` before returning.

- `YWActionBanner` takes a string of text. It has no `updateState` method since the banner is purely a UI element to tell the player something important. `runAnimations:` adds the banner to the view, initially offscreen, then animates it across the screen, removes it, then calls `completion`.

- `YWActionTileChange` takes a tile object and a dictionary of changes to make. `updateState` updates the properties of the tile using the dictionary (e.g. set `unpassable` to `true`). There's no `runAnimations:`; usually you indicate tile changes using some other means, amongst a larger sequence of actions (such as a an enemy seeing you, walking to the gate, and closing it).

Now that was an awful lot of introduction. What we just walked through was analogous to the "investment" part of building technical credit. Time to, hopefully, enjoy the benefits. How can we put this technical credit to work?

### Reaping Dividends

There are dozens of ways that this abstraction _directly_ amplified my efforts. I can choose to use that saved time on other pursuits, or reinvest that same time to build a richer, more enjoyable game. (Just like how financial dividends can either be cashed out or reinvested. The analogy that keeps on giving!)

Most importantly, this structure minimizes the complexity of each individual component. `YWPlayScene` (essentially the "controller" of the model-view-controller pattern) is largely just an engine for running `YWAction` objects. The largest action class, for throwing items, is 250 lines of code (and it's that large only because I spent too much time adding polish, like bouncing). The code for each action is of course completely modularized: when I'm working on the fireball spell, I don't have to worry about inadvertantly breaking the spawn enemy action. If I want to adjust the animation for learning a new spell, I know that code lives in exactly one class (and I don't need to touch `YWActionLearnSpell`'s `updateState` method).

And so, I've created over fifty of these action classes. Everything from combat and spellcasting to dialog to ending a level in victory or defeat. It's gotten to the point where when I add a feature I would have to convince myself to _not_ create new actions. It's a maintainable and enjoyable way to add to the game.

Actions are run sequentially. The engine calls `updateState`, then `runAnimations:`, waits for `completion`, repeat. But if that were the end of the story, the game would be slow and boring. Consider a level with a dozen enemies. If each enemy animated its movement separately, then the player would spend nine seconds every turn just waiting for each one to walk around. So to avoid this, the engine supports running actions in parallel. For a batch of actions, call each one's `updateState`, then each one's `runAnimations:`, then wait for all of the `completion`s to be called, then continue with the next batch of actions. The code to implement parallel actions is localized to the one place that calls `runAnimations:`, rather than spread across all of the actions. After all, each action is downright egotistical; it doesn't care about anything else that may be happening, except itself.

Implementing items (potions, scrolls, etc) was trivial. An item is a game object that has a list of `YWAction`s to run when an actor _uses_ the item. Similarly, it was trivial to implement a different set of effects when a _thrown_ item hits something. Given the large number of actions, this means I already have a rich universe of possible items.

Similarly, map tiles can have a list of actions. Once the player steps on the tile, those actions are run. This means I don't need to any special code to implement, say, traps. I just have a tile with two step effects: `YWActionPopupText` then `YWActionFireball`.

XXX show trap fireball

Levels can have "triggers" as well, which is a dictionary mapping an arbitrary string to a list of actions. So to implement a trap that activates only once, move the list of actions from the tile into a trigger (named "trap") on the level object. Then the tile's step action list can activate that trigger (using `YWActionApplyTrigger`), then remove that trigger (`YWActionRemoveTrigger`). The second time you step on the tile, the "trap" trigger is gone, so nothing happens. (There are plenty of builtin triggers as well, such as one for the name of each action that is run).

A "cutscene" is just a sequence of actions. Easy. I created a large number of actions only for use in cutscenes.

It took about eight lines of code to add a "skip animations" feature to every action. It's a public boolean property on actions. The engine simply doesn't call `runAnimations:`. And I have a high degree of confidence in its robustness because of the `updateState`/`runAnimations:` split; I know I don't make model updates in `runAnimations:`. Skipping animations was directly useful for a number of actions: for example if you "learn" a spell you had already learned (due to replaying the level that teaches it), then don't bother with all the fancy particle effects. Cutscenes can skip the animation for any action to more finely orchestrate what happens onscreen.

Similarly, adding a "nonblocking" animation mode was trivial. The engine calls `runAnimations:`, but provides a `completion` callback that does nothing, then continues on its merry way.

Levels are stored as JSON objects. This is why the `YWAction` initializer takes a dictionary of key-value pairs. This means levels, including their action scripts, are trivially stored in files, or in the database, or sent over the network. The player's inventory is stored in the database with little more than an integer primary key and a JSON string of actions (which is where that third initializer parameter comes into play).

One model for how the game works is that a playthrough equals an initial level plus a (long) sequence of actions. Given the same level and same actions, the exact same playthrough will result. I haven't done it yet (as it's certainly not a _minimum viable product_ feature), but it should be straightforward to implement a rewind and replay feature. Show your friends the cool thing you just did. What's more compelling though is the potential for debugging. If I see a strange behavior, well, I now have a reproducible test case, automatically saved for posterity.

Speaking of debugging, there's a debugger that displays all actions, and some metadata about them, directly on the screen like `tail -f` console output. This has been useful especially for debugging cutscenes.

Since an action's `updateState` can be called separately from its `runAnimations:`, I can take advantage for some cool effects. This next example was the result of me thinking about how I could use the technical credit I'd built up to make a richer experience.

The way this works is: if an action will kill the hero, then that will of course happen during the action's `updateState`. Which means we know about it before we call `runAnimations:`. So we can first apply dramatic effects like zoom and slow motion _then_ call that killing blow's `runAnimations:`. We can also introspect the action to figure out which actor is killing the hero to make sure the camera angle includes them.

There's one more benefit that I want to discuss. (quizzing)

## Continuation-Passing Style

I won't spend as much time on this one because I dove so deeply into `YWAction`. The game makes extensive use of [continuation-passing style](https://en.wikipedia.org/wiki/Continuation-passing_style).

- Started out with a simple 1:1 api for fireball, but good architecture unlocked cool features

- continuation passing style. chaining animations like rube goldberg machine. flick the marble, then get told when the whole thing is done.

Would be an um maintainable nightmare without blocks (closures). Instead, I put it aside for years and was able to cone back to the project years later and I haven't felt the urge to rewrite everything. Which is weird



What sorts of technical credit have my projects accumulated?
How was I able to amplify my efforts by putting that credit to work?
can I tell, in advance of designing it, which way an abstraction will end up going?

This is a model I've found that works together. Progressively larger abstractions, and clear transitions between layers of abstractions.
