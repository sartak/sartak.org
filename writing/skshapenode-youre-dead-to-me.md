title: <tt>SKShapeNode</tt>, you're dead to me
draft: 1

For the past three months I've spent damn near every night and weekend moment building my next iOS game. I now regularly shut down [Diesel](http://www.diesel-cafe.com) at 11pm. The game is my most ambitious project yet and I'm having a blast making it. I've not got anything to announce just yet. Soon! In the meantime, I want to describe one recurring source of pain in [Sprite Kit](https://developer.apple.com/library/ios/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html).

**`SKShapeNode`** is a subclass of `SKNode` that lets you draw arbitrary shapes. Bézier curves, polygons, rings, whatever. You can set the stroke color of the shape, or its fill color, or both. This is certainly useful behavior. You could probably implement a decent chunk of your game's HUD with it. Bézier curves are a great way to give visual feedback of a user's gesture as in, say, [Flight Control](https://itunes.apple.com/us/app/flight-control/id306220440?at=11l7vX&ct=sartak-shape). Describing shapes at runtime rather than at design time (as in `SKSpriteNode`) unlocks worlds of possibilities.

However, `SKShapeNode` is by far the least-well engineered API in Sprite Kit. In fact, I have trouble naming a single lousier API that I've used since I started programming professionally. At least SOAP has an _ethos_.

I respect that iOS 7 was a rush order. Expecting everything to come out perfectly during a platform reinvention is unrealistic. However I maintain that Sprite Kit would have been improved by simply holding `SKShapeNode` back until iOS 8. It was not ready to ship. But since people have it, they want to use it. I figured I'd document the many ways it has burned me. And most importantly, how I've replaced it in my game.

`SKShapeNode`, how do I loathe thee? Let me count the ways.

<ol markdown="1">

<li>
<p>From `SKShapeNode`'s [documentation](https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKShapeNode_Ref/Reference/Reference.html#//apple_ref/occ/instp/SKShapeNode/lineWidth), "A line width larger than `2.0` may cause rendering artifacts in the final rendered image."</p>

<p>Wat.</p>
</li>

<li>
I've had quite a few problems with `setStrokeColor:` not working at all.

When I send a message like `setStrokeColor:[SKColor redColor]`, it sometimes has no effect at all. So I have to trick the `SKShapeNode` into redrawing itself. I've 

    shape.alpha = 0.99999f;
    shape.strokeColor = [SKColor redColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        shape.alpha = 1;
    });

</li>

<li>
Memory leaks
</li>

<li>
Weird shrinking behavior
</li>

<li>
`SKShapeNode` sometimes drops nice little rendering glitches throughout my scenes.

<img src="/img/blog/skshapenode-youre-dead-to-me/detritus.png">

Those red lines are from `SKShapeNode` that were red-stroked round rects. _Many_ frames ago. For whatever reason `SKShapeNode` decided to try to resurrect them, but only did half the job.
</ol>
