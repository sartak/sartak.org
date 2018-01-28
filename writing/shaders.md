title: Shaders
date: 2018-01-27
rownav: 1
draft: 1

Today I wrote my first shader! I'd never written code directly for the GPU before. It turns out to be pretty straightforward. At least if you have done the prerequisite multiple years of programming in C. 😜

But before I did that, I took someone else's shader&mdash;to generate a moving star field&mdash;and bashed my head against it until I got it to do what I wanted. (Which is, incidentally, how I started learning how to program). That shader is now used in my upcoming game, [Yomi the Witch](https://yomithewitch.com) in two places. The first is in a progress bar that fills up as you correctly cast a lot of spells in a row. See the bottom left:

<figure><img style="width: 240px" width=240 height=480 src="/img/blog/shaders/streak-bar.png" /></figure>

The second is in the credits scene. I hadn't planned to use it anywhere besides the spell power bar. However, while I was debugging the shader, I had it cover my entire phone screen to better diagnose issues. It looked quite nice, especially on the iPhone X, so I felt I had to use that effect for something.

<figure><img style="width: 320px" width=320 height=480 src="/img/blog/shaders/photo.jpg" /></figure>

The [shader I wrote](https://www.shadertoy.com/view/MtjBWy) generates an animated pinwheel effect. Surprisingly, Shadertoy didn't have something like this. There was [one shader](https://www.shadertoy.com/view/MtsXzn) that was vaguely close, but I wanted the traditional two-color effect. Here's the code I ended up with:

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

The reason I wanted to write this particular shader was to take the very exciting event of learning a new spell, and kick up the visuals to indicate how important it is. This is _not_ very exciting:

<figure><img style="width: 436px" width=436 height=480 src="/img/blog/shaders/old-banner.gif" /></figure>

So having written the shader, it was easy to turn it into this. Edith now calls it the "Powerpuff Girls effect" which feels right on.

<figure><img style="width: 436px" width=436 height=480 src="/img/blog/shaders/intermediate.gif" /></figure>

And then, combining it with a "focus" feature I already had, the resulting effect now looks like this:

<figure><img style="width: 436px" width=436 height=526 src="/img/blog/shaders/final.gif" /></figure>

<p>I hope you'll agree, adding all this little polish really makes a big difference. Not bad for less than a day of work, including the whole "learn how to command the GPU" thing.</p>
