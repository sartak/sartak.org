title: Shaders are Easy (Step 1: Spend Years Writing C Code)
date: 2018-01-27
rownav: 1

Today I wrote my first shader! I'd never written code directly for the GPU before. It turns out to be pretty straightforward. Mostly because in high school I wrote a lot of C, and also nowadays I've been writing a _lot lot_ of Objective-C (which you can pry from my cold dead hands, thankyouverymuch).

<small><i>That said, I don't intend to intimidate you if you are interested in learning to write shaders. You don't need to have the same scars that I do. It's just that I was able to piggyback on my past experience.</i></small>

<img class="right" width=240 height=480 src="/img/blog/shaders/streak-bar.png" /></span>

Step 2 was I took <a href="https://www.shadertoy.com/view/XsSXz3">an existing shader by one xaot88</a>&mdash;which generates a moving star field&mdash;and bashed my head against it until it was malleable enough to do what I wanted. Incidentally, that's how I'd originally started out with programming. I learn best by getting my hands dirty. Anyway, that customized shader is now part of my upcoming game, [Yomi the Witch](https://yomithewitch.com). The first place it's used is in a progress bar that fills up as you build a streak of correctly-cast spells. See the bottom left of the adjacent screenshot.

This bar was previously a bland rectangle of a single color, fading from red to yellow to green based on how charged up your magic is. Much better this way, especially because it animates nicely, too.

<div style="clear:both"></div>

The second place I use this shader is in the credits scene. I hadn't planned to use it anywhere besides the spell-power bar. However, while I was debugging the shader, I had it cover my entire phone screen to better diagnose issues. I thought it looked quite nice, especially with the iPhone X's display, so I had to use that effect for something. The credits seemed natural.

<figure><img style="width: 320px" width=320 height=480 src="/img/blog/shaders/photo.jpg" /></figure>

This first shader was me remixing someone else's work. The second one, an [animated pinwheel shader](https://www.shadertoy.com/view/MtjBWy), I wrote from scratch. Surprisingly, Shadertoy didn't already have something like this. There was [one shader](https://www.shadertoy.com/view/MtsXzn) that was vaguely close, but I wanted the traditional two-color effect. Here's the code I ended up with:

<div class="code_container">
<pre class="glsl code_snippet">
<span class="synType">void</span> mainImage(out <span class="synType">vec4</span> o, <span class="synType">vec2</span> i)
{
    <span class="synType">vec4</span> color1 = vec4(<span class="synConstant">1</span>, <span class="synConstant">1</span>, <span class="synConstant">1</span>, <span class="synConstant">1</span>);
    <span class="synType">vec4</span> color2 = vec4(<span class="synConstant">0</span>, <span class="synConstant">0</span>, <span class="synConstant">0</span>, <span class="synConstant">1</span>);
    <span class="synType">float</span> speed = <span class="synConstant">2.0</span>;
    <span class="synType">float</span> spokes = <span class="synConstant">12.0</span>;
    <span class="synType">vec2</span> anchorPoint = vec2(<span class="synConstant">0.5</span>, <span class="synConstant">0.5</span>);

    <span class="synType">vec2</span> uv = i / iResolution.xy;

    <span class="synType">float</span> theta = atan(uv.y - anchorPoint.y, uv.x - anchorPoint.x);
    <span class="synType">float</span> percent = theta / (<span class="synConstant">2.0</span>*<span class="synConstant">3.14159</span>);
    <span class="synStatement">if</span> (floor(mod(percent * spokes + speed*iTime, <span class="synConstant">2.0</span>)) == <span class="synConstant">0.0</span>) {
        o = color1;
    }
    <span class="synStatement">else</span> {
        o = color2;
    }
}
</pre>
</div>

To explain briefly what's happening if you're unfamiliar with shaders: recall that the GPU executes this program once for each and every pixel, on each and every frame (of which there will hopefully be 60 per second). The function parameter <tt>i</tt> is the <tt>x</tt>, <tt>y</tt> coordinate of that pixel. After some variable declarations (to make it easy to customize this shader's effects), we create a variable <tt>uv</tt> which normalizes this pixel's coordinates into the unit square so <tt>x</tt> and <tt>y</tt> are both between <tt>0</tt> and <tt>1</tt>. Then we find the angle, <tt>theta</tt>, between the pixel and the center point. We divide the angle by <tt>atan()</tt>'s range (in radians, so 2π) to again normalize to a fraction between <tt>0</tt> and <tt>1</tt>, called <tt>percent</tt>. If at this point we were to render each pixel's <tt>percent</tt> as a grayscale color, we would see a round gradient except for a hard border between white and black. However, instead of a gradient from black to white, we want to see only pure black and white, alternating. We can achieve that with a combination of the modulus operator ("is this an even or an odd spoke?") and <tt>floor()</tt>. We mix the current timestamp, <tt>iTime</tt> into the operation to produce animation. Finally, we assign one of the two colors to the function parameter <tt>o</tt> which the display then uses to color that pixel.

Anyway, the reason I wanted to write this pinwheel shader was simple. When the player learns a brand new spell, it is important to really kick up the visuals to indicate how important and exciting it is. This, which is what I had up until this morning, is very much _not_ exciting:

<figure><img style="width: 436px" width=436 height=480 src="/img/blog/shaders/old-banner.gif" /></figure>

So having done the hard part of writing the shader, SpriteKit makes it very easy to plug it into the game. Edith immediately dubbed this the "Powerpuff Girls effect" which is right on.

<figure><img style="width: 436px" width=436 height=480 src="/img/blog/shaders/intermediate.gif" /></figure>

And then, combining the pinwheel with a "focus" feature I already had, the resulting effect now looks like this:

<figure><img style="width: 436px" width=436 height=526 src="/img/blog/shaders/final.gif" /></figure>

<p>I hope you'll agree, adding all this little polish really makes a big difference. Not bad for <s>less than a day</s> <i>like five years</i> of work. Though watching it now I need to clean up some of those animations… especially on fade out… rendering the pinwheel as a square is a bit too crude… all right, back to work!</p>

