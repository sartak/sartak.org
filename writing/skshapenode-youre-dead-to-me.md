title: <tt>SKShapeNode</tt>, you're dead to me
draft: 1

For the past three months I've spent every free moment working on my next iOS game. I now regularly shut down [Diesel](http://www.diesel-cafe.com) at 11pm. The game is ambitious and I'm having a blast making it. I've not got anything to announce just yet. Soon! But I figured in the meantime I'd document one recurring source of pain from [Sprite Kit](https://developer.apple.com/library/ios/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html).

**`SKShapeNode`** is a subclass of `SKNode` that lets you draw arbitrary shapes. Bézier curves, polygons, rings, whatever. You can set the stroke color of the shape, or its fill color, or both. This certainly looks to be a useful class. You could probably implement a decent chunk of your game's HUD with it. Bézier curves are a great way to give visual feedback of a user's gesture as in, say, [Flight Control](https://itunes.apple.com/us/app/flight-control/id306220440?at=11l7vX&ct=sartak-shape).

However, `SKShapeNode` is by far the least-well engineered API in Sprite Kit. In fact, I have trouble naming a single lousier API that I've used since I started programming professionally. At least SOAP has an _ethos_.

I respect that iOS 7 was a rush order. Expecting everything to come out perfectly during a platform reinvention is unrealistic. However I maintain that Sprite Kit would have been improved by simply holding `SKShapeNode` back until iOS 8. It was not ready to ship. But since people have it and want to use it, I figured I'd document the many ways it has burned me. And most importantly, how I've replaced it in my game.

<tt>SKShapeNode</tt>, how do I loathe thee? Let me count the ways.

<ul>

<li>
From SKShapeNode's [documentation](https://developer.apple.com/library/ios/documentation/SpriteKit/Reference/SKShapeNode_Ref/Reference/Reference.html#//apple_ref/occ/instp/SKShapeNode/lineWidth), "A line width larger than <tt>2.0</tt> may cause rendering artifacts in the final rendered image."

Wat.
</li>
<li>
`setStrokeColor:`
`#define`
</li>
<li>
Memory leaks
</li>
<li>
Weird shrinking behavior
</li>

</ul>
