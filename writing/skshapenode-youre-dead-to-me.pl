use Sartak::Blog;

BEGIN { print "title: <tt>SKShapeNode</tt>, you're dead to me
draft: 1
" }

p { "For the past three months I've spent damn near every night and weekend moment building my next iOS game. I now regularly shut down [Diesel](http://www.diesel-cafe.com) at 11pm. The game is my most ambitious project yet and I'm having a blast making it. I've not got anything to announce just yet. Soon! In the meantime, I want to describe one recurring source of pain in [Sprite Kit](https://developer.apple.com/library/ios/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html)." };

p{ "**`SKShapeNode`** is a subclass of `SKNode` that lets you draw arbitrary shapes. Bézier curves, polygons, rings, whatever. You can set the stroke color of the shape, or its fill color, or both. This is certainly useful behavior. You could probably implement a decent chunk of your game's HUD with it. Bézier curves are a great way to give visual feedback of a user's gesture as in, say, [Flight Control](https://itunes.apple.com/us/app/flight-control/id306220440?at=11l7vX&ct=sartak-shape). Describing shapes at runtime rather than at design time (as in `SKSpriteNode`) unlocks worlds of possibilities." };

p { "However, `SKShapeNode` is by far the least-well engineered API in Sprite Kit. In fact, I have trouble naming a single lousier API that I've used since I started programming professionally. At least SOAP has an _ethos_." };

p { "I respect that iOS 7 was a rush order. Expecting everything to come out perfectly during a platform reinvention is unrealistic. However I maintain that Sprite Kit would have been improved by simply holding `SKShapeNode` back until iOS 8. It was not ready to ship. But since people have it, they want to use it. I figured I'd document the many ways it has burned me. And most importantly, how I've replaced it in my game." };

p { "`SKShapeNode`, how do I loathe thee? Let me count the ways." };

ol {
    li {
        p { qq{From `SKShapeNode`'s [documentation](https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKShapeNode_Ref/Reference/Reference.html#//apple_ref/occ/instp/SKShapeNode/lineWidth), "A line width larger than `2.0` may cause rendering artifacts in the final rendered image."} };
        p { "Wat." };
    }
    li {
        p { "Sometimes, when I send a message like `setStrokeColor:[SKColor redColor]`, it sometimes has no visual effect at all. So I have to trick the `SKShapeNode` into redrawing itself. Changing its `alpha` is one way to do it:" };

code_snippet 'objc' => << 'CODE';
#if BUSTED_SKSHAPENODE_SETSTROKECOLOR
    CGFloat oldAlpha = shape.alpha;
    shape.alpha = 0;
    shape.alpha = oldAlpha;
#endif
shape.strokeColor = [SKColor redColor];
CODE

        p { "Note that it is _not_ sufficient to simply say `shape.alpha = shape.alpha`. That isn't enough to trigger a display." };

        p { "I wouldn't be surpised to learn that internally, Sprite Kit uses a `setNeedsDisplay:` system like `CALayer` to redraw only when necessary. If that's the case, then whoever was working on `SKShapeNode` apparently forgot to have `setStrokeColor:` invoke Sprite Kit's version of `setNeedsDisplay:`." };

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
    }

    li {
        "Memory leaks"
    }

    li {
        "Weird shrinking behavior"
    }
    li {
        p { "`SKShapeNode` sometimes drops nice little rendering glitches throughout my scenes." }

        img {
            width is "163";
            height is "136";
            src is "/img/blog/skshapenode-youre-dead-to-me/detritus.png";
        };

        p { "Those red lines are from `SKShapeNode` instances that once rendered red-stroked round rects. _Many_ frames ago. For whatever reason `SKShapeNode` decided to try to resurrect them, but only did half the job." };
    }
}
