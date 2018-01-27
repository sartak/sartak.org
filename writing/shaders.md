title: Shaders
date: 2018-01-27
rownav: 1
draft: 1

Today I wrote my first shader! I'd never written code directly for the GPU before.

But before I did that, I took someone else's shader&mdash;to generate a moving star field&mdash;and bashed my head against it until I got it to do what I wanted. That shader is now used in my upcoming game, [Yomi the Witch](https://yomithewitch.com) in two places. The first is in a progress bar that fills up as you correctly cast a lot of spells in a row. See the bottom left:

<figure><img width=240 height=480 src="/img/blog/shaders/streak-bar.png" /></figure>

The second is in the credits scene. I hadn't planned to use it here. However, while I was debugging the shader, I had it displayed on my entire phone screen. It looked quite nice, especially on the iPhone X, so I felt I had to use that effect for something.

<figure><img width=320 height=480 src="/img/blog/shaders/photo.jpg" /></figure>

The [shader I wrote](https://www.shadertoy.com/view/MtjBWy), as in from scratch, generates an animated pinwheel effect. Surprisingly, Shadertoy didn't have something like this. There was [one shader](https://www.shadertoy.com/view/MtsXzn) that was vaguely close, but I wanted the traditional two-color effect.

The plan was to to turn this:

<figure><img width=436 height=480 src="/img/blog/shaders/old-banner.gif" /></figure>

into this:

<figure><img width=436 height=480 src="/img/blog/shaders/intermediate.gif" /></figure>

And then, combining the new shader with a "focus" feature I already had, the resulting effect looks like this:

<figure><img width=436 height=526 src="/img/blog/shaders/final.gif" /></figure>

<p>I hope you'll agree, adding all this little polish really makes a big difference. Not bad for less than a day of work, including the whole "learn how to command the GPU" thing.</p>
