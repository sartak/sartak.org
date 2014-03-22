use Sartak::Blog;

BEGIN { print "title: <tt>SKShapeNode</tt>, you're dead to me
draft: 1
" }

p { "For the past three months I've spent damn near every night and weekend moment building my next iOS game. I now regularly shut down [Diesel](http://www.diesel-cafe.com) at 11pm. The game is my most ambitious project yet and I'm having a blast making it. I've not got anything to announce just yet. Soon! In the meantime, I want to describe one recurring source of pain in [Sprite Kit](https://developer.apple.com/library/ios/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html)." };

p{ "**`SKShapeNode`** is a subclass of `SKNode` that lets you draw arbitrary shapes. Bézier curves, polygons, rings, whatever. You can set the stroke color of the shape, or its fill color, or both. This is certainly useful behavior. You could probably implement a decent chunk of your game's HUD with it. Bézier curves are a great way to give visual feedback of a user's gesture as in, say, [Flight Control](https://itunes.apple.com/us/app/flight-control/id306220440?at=11l7vX&ct=sartak-shape). Describing shapes at runtime rather than at design time (as in `SKSpriteNode`) unlocks worlds of possibilities." };

p { "However, `SKShapeNode` is by far the least-well engineered API in Sprite Kit. In fact, I have trouble naming a single lousier API that I've used since I started programming professionally. At least SOAP has an _ethos_." };

p { "I respect that iOS 7 was a rush order. It's unfair to expect that everything will come out perfectly during a platform reinvention. However I maintain that Sprite Kit would have been improved by simply holding `SKShapeNode` back until iOS 8. It was not ready to ship. But since people have it, they want to use it. And to those people, BEWARE! There most certainly be dragons." };

p { "`SKShapeNode`, how do I loathe thee? Let me count the ways." };

ol {
    li {
        p { "`SKShapeNode` … [is](http://stackoverflow.com/questions/20292318/why-does-creating-and-removing-skshapenode-and-sknode-repeatedly-cause-a-memory) … [widely](http://stackoverflow.com/questions/18889297/skshapenode-has-unbounded-memory-growth) … [known](http://stackoverflow.com/questions/20134891/skphysicsbody-bodywithpolygonfrompath-memory-leaks) … [to](http://stackoverflow.com/questions/22323189/memory-leak-in-sprite-kit-application) … [leak](http://stackoverflow.com/a/22282920/290913) … [memory](http://tonychamblee.com/2013/11/18/tcprogresstimer-a-spritekit-progress-timer/)." };
    }

    li {
        p { qq{From `SKShapeNode`'s [documentation](https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKShapeNode_Ref/Reference/Reference.html#//apple_ref/occ/instp/SKShapeNode/lineWidth), "A line width larger than `2.0` may cause rendering artifacts in the final rendered image."} };
        p { "Wat." };
    }

    li {
        p { "When I send a message like `setStrokeColor:[SKColor redColor]`, it sometimes has no visual effect at all. So I have to trick the `SKShapeNode` into redrawing itself. Changing its `alpha` is one way to do it:" };

code_snippet 'objc' => << 'CODE';
#if BUSTED_SKSHAPENODE_SETSTROKECOLOR
    CGFloat oldAlpha = shape.alpha;
    shape.alpha = 0;
    shape.alpha = oldAlpha;
#endif
shape.strokeColor = [SKColor redColor];
CODE

        p { "Note that it is _not_ sufficient to simply say `shape.alpha = shape.alpha`. That does not trigger a display. For whatever reason, the internals demand you actually change the property value." };

        p { "You know, I wouldn't be surpised to learn that internally, Sprite Kit uses a `setNeedsDisplay:` system like `CALayer`. That is an optimization to eliminate useless redraws. If that's the case, then whoever was working on `SKShapeNode` apparently forgot to have `setStrokeColor:` invoke Sprite Kit's version of `setNeedsDisplay:`." };

        br {};

        p { "Digging deeper, it seems this problem manifests itself only when the `SKShapeNode` is a descendent of an `SKEffectNode`. To see it in action, start a new project using the Sprite Kit template and replace your scene class's implementation with this:" };

code_snippet 'objc' => << 'CODE';
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKEffectNode *container = [SKEffectNode node];
        [self addChild:container];

        SKShapeNode *shape = [SKShapeNode node];
        shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 20, 20) cornerRadius:4].CGPath;
        shape.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        shape.strokeColor = [SKColor redColor];
        [container addChild:shape];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"setting stroke color");

            if (0) { // <-- CHANGE ME
                CGFloat oldAlpha = shape.alpha;
                shape.alpha = 0;
                shape.alpha = oldAlpha;
            }
            shape.strokeColor = [SKColor greenColor];
        });
    }
    return self;
}
CODE

        p { "For me, the round rect stays red indefinitely. If you change that `if (0)` to a true value, then the code to change the `SKShapeNode`'s alpha kicks in and that causes the subsequent `setStrokeColor:` to have the intended visible effect." };
    }

    li {
        p { "`SKShapeNode` sometimes drops little rendering glitches throughout my scenes." }

        img {
            width is "163";
            height is "136";
            src is "/img/blog/skshapenode-youre-dead-to-me/detritus.png";
        };

        p { "Those red lines are from `SKShapeNode` instances that once rendered red-stroked round rects. _Many_ frames ago. For whatever reason `SKShapeNode` decided to try to resurrect them, but only did half the job." };
    };
    li {
        p { "This one is the most baffling and upsetting. I have no idea what is happening or why." };
        p { "It seems that if you have enough `SKShapeNode` instances visible on screen, it completely screws up the scene rendering. The scene shrinks to about 60% of its height for a few moments. I think, but can't confirm, that touch input might be part of the recipe for disaster. In the following screenshots you can see what happens when I tiptoe past the apparent `SKShapeNode` limit (thanks to all that detritus from the previous point). The app becomes completely unusable." };

        img {
            width is "320";
            height is "568";
            src is "/img/blog/skshapenode-youre-dead-to-me/shrink-pre.png";
        };
        img {
            width is "320";
            height is "568";
            src is "/img/blog/skshapenode-youre-dead-to-me/shrink-post.png";
        };
        p { "I have no idea why this happens except it seems to be `SKShapeNode`'s fault. All the more reason to eliminate it without mercy." };
    };
}

p { "Because of all these flaws, **`SKShapeNode` is completely untrustworthy**. I now refuse to use `SKShapeNode` for any new code I write. I have also been refactoring existing code that uses it to stop using it. Here are some ways I've been able to do that." };

ol {
    li {
        p { "For borders on opaque nodes, just use a `SKShapeNode` instantiated with `+[SKSpriteNode spriteNodeWithColor:size:]`. This gets you a rectangular block of the provided `SKColor`." };
        p { "Your borders will look better too. And you won't have to fear using a border width of greater than 2.0." };
        p { "*Cripes*." };
    };

    li {
        p { "Sprite Kit plays well enough with `CALayer` and friends. When you can get away with it, stick a `CAShapeLayer` into your `SKView`'s layer. I use this in two places in my game: a drawing pad and a procedurally-generated lightning bolt." };

        img {
            width is "200";
            height is "200";
            src is "/img/blog/skshapenode-youre-dead-to-me/drawing.png";
        };
        img {
            width is "135";
            height is "103";
            src is "/img/blog/skshapenode-youre-dead-to-me/lightning.png";
        };

        p { "If you need to display Sprite Kit content _over_ the shape, things get tricky. This might not work for that. I've chosen my battles here carefully: there will be nothing in the game that renders on top of that drawing pad or lightning bold." };
        p { "Using `CALayer` requires jumping through a few `convertPoint:` hurdles. The coordinate system of Sprite Kit is different from the coordinate system of Core Animation. Natch." };
    };
    li {
        p { "While I haven't personally used this tactic, I think it should work with little fuss. Render a `CGPathRef` offscreen using `CAShapeLayer`. Then snapshot that layer into an image. Then create an `SKSpriteNode` with that snapshot as a texture." };
        p { "Now you can add that sprite to your scene, animate it around, put it over or under other nodes. You now have an unchanging `SKShapeNode` without its crap." };
    };
};

p { "The first person to implement the complete `SKShapeNode` API using an `SKSpriteNode` backed by a `CALayer` wins … my undying respect!" };
