use Sartak::Blog;

BEGIN { print "title: <tt>SKShapeNode</tt>, you are dead to me
date: 2014-03-22
" }

p { "For the past three months I've spent damn near every night and weekend moment building my next iOS game. I now regularly shut down [Diesel Cafe](http://www.diesel-cafe.com). The game is my most ambitious project yet and I'm having a blast making it. As of today it's sixteen thousand lines and growing strong. For the UI I'm using [Sprite Kit](https://developer.apple.com/library/ios/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html) which has been a real pleasure to use. But lurking inside it there is one source of pain that keeps recurring." };

p{ "**`SKShapeNode`** is a subclass of `SKNode` that draws a `CGPathRef`. It can render Bézier curves, polygons, rings, Louisiana, whatever. You can set the stroke color of the shape, or its fill color, or both. You could probably implement a decent chunk of your game's HUD with it. Bézier curves are a great way to give visual feedback of a user's gesture as in, say, [Flight Control](https://itunes.apple.com/us/app/flight-control/id306220440?at=11l7vX&ct=sartak-shape). Describing shapes at runtime rather than at design time (as in `SKSpriteNode`) unlocks worlds of possibilities." };

p { "However, `SKShapeNode` is by far the least-well engineered API in Sprite Kit. In fact, I have trouble naming a single lousier API that I've used since I started programming professionally. At least SOAP has an _ethos_." };

p { "I respect that iOS 7 was a rush order. It's unfair to expect that everything will come out perfectly during a platform reinvention. However I maintain that Sprite Kit would have been improved by simply holding `SKShapeNode` back until iOS 8. It was not ready to ship. But since people have it, they want to use it. And to those people, BEWARE!" };

p { "`SKShapeNode`, how do I loathe thee? Let me count the ways." };

ol {
    li {
        id is "leak";
        p { "`SKShapeNode` … [is](http://stackoverflow.com/questions/20292318/why-does-creating-and-removing-skshapenode-and-sknode-repeatedly-cause-a-memory) … [widely](http://stackoverflow.com/questions/18889297/skshapenode-has-unbounded-memory-growth) … [known](http://stackoverflow.com/questions/20134891/skphysicsbody-bodywithpolygonfrompath-memory-leaks) … [to](http://stackoverflow.com/questions/22323189/memory-leak-in-sprite-kit-application) … [leak](http://stackoverflow.com/a/22282920/290913) … [memory](http://tonychamblee.com/2013/11/18/tcprogresstimer-a-spritekit-progress-timer/)." };
        p { "Unfixable memory leaks is already enough reason to avoid using an API. But wait, there's more…" };
    }

    li {
        id is "linewidth";
        p { qq{From `SKShapeNode`'s [documentation](https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKShapeNode_Ref/Reference/Reference.html#//apple_ref/occ/instp/SKShapeNode/lineWidth), "A line width larger than `2.0` may cause rendering artifacts in the final rendered image."} };
        p { "It's good that they are up front about this limitation. But that is still pretty weak." };
    }

    li {
        id is "setstrokecolor";
        p { "Sometimes `setStrokeColor:[SKColor redColor]` has no visual effect at all. So you have to trick the `SKShapeNode` into redrawing itself. Changing its `alpha` is one way to do it:" };

code_snippet 'objc' => << 'CODE';
#if BUSTED_SKSHAPENODE_SETSTROKECOLOR
    CGFloat oldAlpha = shape.alpha;
    shape.alpha = 0;
    shape.alpha = oldAlpha;
#endif
    shape.strokeColor = [SKColor redColor];
CODE

        p { "Note that it is _not_ sufficient to simply say `shape.alpha = shape.alpha`. That does not trigger a display. For whatever reason, the internals demand you actually change the property value." };

        p { "You know, I wouldn't be surpised to learn that internally, Sprite Kit uses a `setNeedsDisplay:` system like `CALayer`. That is an optimization to eliminate useless redraws. If that's the case, then whoever was working on `SKShapeNode` apparently forgot to have `setStrokeColor:` invoke the `setNeedsDisplay:` of Sprite Kit." };

        br {};

        p { "Digging deeper, it seems this problem manifests itself only when the `SKShapeNode` is a descendent of `SKEffectNode`. To see it in action, start a new project using the Sprite Kit template and replace your scene class's implementation with this:" };

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

        p { "For me, the round rect stays red indefinitely. If you change that `if (0)` to a true value, then the alpha change causes the subsequent `setStrokeColor:` to have the intended visible effect." };

        p { "I've reported this to Apple as [rdar://16400219](http://openradar.appspot.com/radar?id=5827279825403904)." };
    }

    li {
        id is "detritus";
        p { "`SKShapeNode` sometimes drops little rendering glitches throughout my scenes." }

        img {
            width is "163";
            height is "136";
            src is "/img/blog/skshapenode-you-are-dead-to-me/detritus.png";
        };

        p { "Those red lines are from `SKShapeNode` instances that once rendered red rectangles. _Many_ frames ago. For whatever reason `SKShapeNode` decided to try to resurrect them, but only did half the job." };
    };

    li {
        id is "resizing";
        p { "This one is the most baffling and upsetting. It seems that if you have too many `SKShapeNode` instances visible on screen, it completely screws up the scene rendering. The scene shrinks to about 60% of its height for a few moments. In the following screenshots you can see what happens when I tiptoe past the apparent `SKShapeNode` limit (thanks to all that detritus from the previous point). The game becomes completely unusable." };

        img {
            width is "320";
            height is "568";
            src is "/img/blog/skshapenode-you-are-dead-to-me/shrink-pre.png";
        };
        img {
            width is "320";
            height is "568";
            src is "/img/blog/skshapenode-you-are-dead-to-me/shrink-post.png";
        };
        p { "This problem seems to yet again be the fault of `SKShapeNode` inside of an `SKEffectNode`. My guess is that `SKEffectNode`'s unique rendering model is triggering this. `SKEffectNode` lets you apply Core Image filters (which are akin to Photoshop filters) to some of your nodes. It's amazingly powerful. Seriously next level shit. But to achieve that, `SKEffectNode` must render its subtree into a separate buffer to which it can apply its CI filter. This different codepath is probably the cause of all the problems. But if `SKShapeNode` freaks out when it's being rendered into an `SKEffectNode`, I seriously question how robust Sprite Kit is. (Incidentally, `SKEffectNode` also doesn't respect the `zPosition`s of its children, but that's another post altogether. The solution for that one is to interject a plain `SKNode` into the node tree.)" };
        p { "Anyway. I've luckily been able to replicate this crazy rendering bug with a small amount of code. I've recorded a [video showing this bug](http://sartak.org/misc/shape-in-effect.mov). As before, replace the Sprite Kit template's scene class's implementation with the following:" };
        code_snippet 'objc' => << 'CODE';
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        SKEffectNode *container = [SKEffectNode node];
        [self addChild:container];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    SKEffectNode *container = self.children[0];

    SKShapeNode *shape = [SKShapeNode node];
    shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-10, -10, 20, 20) cornerRadius:4].CGPath;
    shape.position = [touch locationInNode:self];
    shape.strokeColor = [SKColor colorWithHue:drand48() saturation:1 brightness:1 alpha:1];
    shape.blendMode = SKBlendModeAdd;
    [container addChild:shape];
}
CODE

        p { "Tap the screen a few times. All's well." };
        p { "Tap the screen a few more time… <em>Hey what the hell was</em> that<em>?</em>" };
        p { "What in the world did Apple do to cause this bug? Regardless, I've reported this one as [rdar://16400203](http://openradar.appspot.com/radar?id=5866175049236480)." };
    };
}

br {};

p { "Because of all these flaws, **`SKShapeNode` is completely untrustworthy**. I now refuse to use `SKShapeNode` for any new code I write. I have also been refactoring existing code that uses it to stop using it. Here are some ways I've been able to do that." };

ol {
    li {
        id is "nuke";
        p { "Just remove the `SKShapeNode`. For some effects it's not worth all the trouble. You'll soon think of something better to replace it." };
    };
    li {
        id is "colorsprite";
        p { "For borders on opaque nodes, just use a `SKShapeNode` instantiated with <nobr>`+[SKSpriteNode spriteNodeWithColor:size:]`</nobr>. This gets you a rectangular block of the provided `SKColor`. Beyond just borders, I've converted my HP bars this way too." };
        p { "The output even looks better too. And you won't have to fear using a border width of greater than 2.0. Cripes!" };
    };

    li {
        id is "shapelayer";
        p { "Sprite Kit plays well enough with `CALayer` and friends. When you can get away with it, stick a `CAShapeLayer` into your `SKView`'s layer. I use this in two places in my game: a drawing pad and a procedurally-generated lightning bolt." };

        img {
            width is "200";
            height is "200";
            src is "/img/blog/skshapenode-you-are-dead-to-me/drawing.png";
        };
        img {
            width is "135";
            height is "103";
            src is "/img/blog/skshapenode-you-are-dead-to-me/lightning.png";
        };

        p { "This works fine if your `CAShapeLayer` is going to be the topmost UI component. However if you need to display Sprite Kit content _over_ the layer, things would get tricky. Maybe you can use two `SKView` instances, sandwiching the `CAShapeLayer`. That sounds like an awful lot of work though. Personally, I've chosen my battles carefully; there will be nothing in my game that renders above that drawing pad or lightning bolt." };
        p { "Be aware that using `CALayer` requires jumping through a few `convertPoint:` hurdles. The coordinate system of Sprite Kit is different from the coordinate system of Core Animation. Natch." };
    };
    li {
        id is "rasterizeshape";
        p { "Render a `CGPathRef` offscreen using a disconnected `CAShapeLayer`. Then snapshot that into an image. Then create an `SKSpriteNode` with that snapshot as a texture. While I haven't personally used this technique, I see no reason it wouldn't work." };
        p { "Now you can add that sprite to your scene, animate it all over town, put it over or under other nodes, etc. You now have an unchanging `SKShapeNode` without all of the insane, unfixable bugs." };
    };
};

br {};

p { "You know, maybe that one is worth doing *right*. The first person to implement the complete `SKShapeNode` API using an `SKSpriteNode` backed by a `CALayer` wins … my undying respect!" };
