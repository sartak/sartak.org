title: Learning to Build Abstractions in Quartz Composer
draft: 1

I decided today that I would learn a bit of [Quartz Composer](http://en.wikipedia.org/wiki/Quartz_Composer). I had never touched it before, beyond reading a couple articles and watching a conference talk. The most useful article for me was "[UI Prototyping with Quartz Composer and Origami](http://www.pasanpremaratne.com/2014/03/15/UI-Prototyping-with-Quartz-Composer-and-Origami/)" by Pasan Premaratne. It takes you from absolute zero to having built a simpler version to [Path's attractive spinout menu](http://codepen.io/sparanoid/pen/nHAmi) with Facebook's [Origami](http://facebook.github.io/origami/).

I recommend you not only read the post, but also *actually* follow along! At worst you'll have spent twenty minutes examining at another way of doing things. At best you'll have acquired a new tool for your kit and become even more handsome.

At the end of Pasan's post, he mentions:

> The only downside that I see right now to using Quartz
> Composer is that if you're protoyping something complex,
> your composition can get **unwieldy and convoluted fairly quickly**.
> In just creating a radial menu with three buttons we have
> over 20 patches in our composition.

I agree that it can become unwieldy. Here's a snapshot of my small composition:

<img width="392" height="267" src="/img/blog/learning-to-build-abstractions-in-quartz-composer/notes.png">

Those three yellow blocks contain essentially the same code. Each block does not explicitly group its contained patches; they are spacially contained in a particular region on the canvas. Nothing more. So a yellow block is about as constructive as a source code comment.

These blocks contain the same patches duplicated with slightly different parameters. That is of course a bit offensive to me as a programmer. If possible I would like to clean up that repetition. But I'm not even sure that I can.

Here's the rub. If Quartz Composer provides no tools to abstract away chunks of your composition, then it is nothing more than a shiny toy. It would be like a programming language that does not support creating functions. But if QC *does* enable building bigger, reusable units of design, then it is worthy of my attention.

So! Let's learn how to build abstractions in Quartz Composer. Together! This is my very first day with Quartz Composer, so there are going to be some false starts. Bear with me. :)

## Macros

Step one is to read and follow along with everything in Pasan's post.

Go do it. I'll be here.

As I went through Pasan's tutorial, I kept seeing mention of a "Macro" feature all over Quartz Composer. If it's like any other system's macro, it would be one way to encapsulate complexity in your composition.

The next step, then, must be to select the group of patches responsible for one of the buttons and click `Create Macro` in the toolbar. This replaces all the patches with a single `Macro Patch`. The noodle from `Interaction 2`'s Drag outlet is connected to this macro patch, which is a good sign. In fact if you go over to the Viewer you should see that nothing has changed.

Double click the macro patch (careful: double click its body, not its titlebar) to edit its contents. We can see that it is almost identical to what we had before for a button. However there is a new patch called `Number Splitter` near the top. This must be how Quartz Composer connects the Drag interaction outside the macro to the input of the bouncy and classic animations inside the macro. Note that `Number Splitter`'s inlet is green, presumably to indicate that.

If we want to make this macro generic, we would need to create our own parameters. The button image must be a parameter otherwise every button will be labeled "A". The best place to start is probably to delete the image patch which is hardcoded in this macro to be `ButtonA.png`.

To parameterize the image, right click the Layer patch. Under `Publish Inputs` select the `Image` property. QC offers to let you name the parameter differently from what the Layer patch expects, but in this case we can stick with `Image`. This turns the inlet green, which matches the `Number Splitter` parameter. Here's to hoping!

Clicking `Edit Parent` in the QC toolbar leaves the macro and returns to our overall composition. If you look at the macro patch you can see that it now has an `Image` inlet. Success! Drag that `ButtonA.png` file back into the composition, delete its layer, and hook up its outlet to the macro's `Image` input.

If all went according to plan, there should be no change in the Viewer. Indeed there are three spinout buttons labeled A, B, and C.

<br>

*Here begins one of my false starts. Read on before making changes to your composition.*

Let's get rid of the other two buttons and replace them with macros. Copy and paste works just fine on macro patches. Make sure that each of the three macros has its `Input` and `Image` inlets populated.

<img width="533" height="347" src="/img/blog/learning-to-build-abstractions-in-quartz-composer/macros.png">

Running the Viewer you now see that there's only one button. The problem of course is that all three buttons are animating between the same positions at the same times, so the other two buttons are hiding below the visible one.

Clearly we need more macro parameters. But to add them I would have to edit the macro three times, once for each button. This is because I used copy and paste to duplicate the macros. Just like in programming, copy and paste is a worst practice.

*Lesson learned. False start over.*

## User-Defined Patches

How else can we achieve the abstraction we need besides copying and pasting macros?

Another button in the QC toolbar is `Add to Library`. I presume that is for reusing the components you have created. Let's add the macro to our library as a new patch type. After playing around a little I've discovered that rather than adding the macro to your library directly, it's better to explode the macro first (available under the right-click menu). Call the new patch type `Radial Button`.

Then from the Patch Library drag in two more Radial Buttons and wire them up. You'll notice that the inlets are now called "Enable", "Input", and "Input". Not great, so let's fix that problem first.

In the Patch Library, right click the `Radial Button` object and select `Edit`. Then without selecting a patch, open up the Patch Inspector. This inspects the Radial Button patch itself. In the dropdown at the top select "Published Inputs & Outputs". You'll see a table of `Input` mapped to `input_proxy_1` and another `Input` mapped to `input_proxy_2`. Change one of the `Input` labels to `Progress` and the other to `Image`. I don't know if there's a way to immediately see which is which. However if you save and reopen `Radial Button`, the label on the image layer should say "Image" not "Progress". If you guessed wrong be sure to flip them the other way.

Now that we've renamed the properties let's go back to our composition to see our change.

<img width="143" height="78" src="/img/blog/learning-to-build-abstractions-in-quartz-composer/radial-input-input.png">

Ah crud. Still two generic `Input` inlets. I bet that every time we edit `Radial Button` we must remove it from our composition and add the new version back in. What a pain!

**Beware!** Don't forget to adjust the layer ordering after you add new layers. `Hit Area` should be the layer with the highest number, then the `Plus Button` layer should be the next layer below that. If you miss this step, you will see rendering bugs. Or worse, the drag handler mysteriously won't fire, because it is obscured by other layers.

Next let's make more properties into parameters. `x-` and `y-coordinate` are as good a place to start as any. Recall that in Pasan's post we assigned different end values to each of the transition patches. However, notice that the `Start Value` and `End Value` of the transition patch have ordinary inlet ports. That means we could publish those inputs from `Radial Button` itself. Start by right clicking `Transition X`, selecting `Publish Inputs`, then `End Value`. Call it `End X`. Similarly, publish `Transition Y`'s `End Value` as `End Y`.

Go back to your composition, remove the Radial Button patches, and readd them. You'll see now that you have the new `End X` and `End Y` inputs. Hook up the `Progress` and `Image` inlets as before. Then, using the same method as in Pasan's post, assign constant values using the Patch Inspector for each of the `End X` and `End Y` inputs on each of the three buttons. For convenience they are:

- A button: `(-184.5, -408.5)`
- B button: `(0, -298.5)`
- C button: `(184.5, -408.5)`

Notice how the default values for `End X` and `End Y` are the values that had been assigned to each `End Value` of `Button A`'s two transitions. For extra credit, you can change them to better defaults (like `0`) by editing the `Radial Button` patch. Use the Patch Inspector with no patch selected, then changing the values under `Input Parameters`.

In the Viewer, confirm that the animation is working again. The only thing left to fix is the friction and tension of each of the buttons coming out. I'm sure you can now handle that.

## How Bout Dem Abstractions

Thanks to our custom `Radial Button` patch, there is less duplication in our composition. The number of patches has decreased by half, which makes the composition more comprehensible.

That is not good enough.

If we want to add or remove a button to this menu, you'll need to do a lot of work. You'll need to do some trigonometry to decide where each button ends up. No way! I want it to be as easy to add a button as it would be in, say, Interface Builder.

Before we do that, let's simplify the problem first. Let's move everything to the origin. That means you need to change the `Radial Button`'s `Start Value` for both `Transition X` and `Transition Y` to `0`. And then in your composition, change the `y-coordinate` of the `Add Button` and the `Hit Test` from `-512` to `0`.

This simplifies the problem in two ways. Everything is relative to the origin, instead of the magic value `-512`. Also, we'll lay the buttons across the complete circle around the plus button, rather than just half or a quarter of it.

To begin, we'll remove the `End X` and `End Y` published inputs from `Radial Button`. You remove them the same way you added them: just right click the patch and select the property under `Published Inputs`.

The new inputs we'll want are `Radius`, `Count`, and `Index`. `Radius` will tell us how far from the origin to push the button. `Count` and `Index` will be used to decide where on the circle the button will go.

To calculate the coordinates to put the button, we'll need access to `sin` and `cos`. Quartz Composer has a Mathematical Expression patch that evaluates expressions of arbitrarily many variables. We'll need one patch for the `x-coordinate` and another for the `y-coordinate`, so drag out two.

If you inspect a `Mathematical Patch`, under the `Settings` pane there is a text field for formula. Any undefined variables you use in this formula will end up as inputs to the patch (which is a wonderful bit of design).

For the `x-coordinate` patch, we'll want to use the formula `sin(360 * index/count) * radius`.

**Note**! `sin` uses degrees not radians. Knowing that will save you twenty minutes of self-doubt and headscratching. :)

For the `y-coordinate` patch, we'll use the same formula but with `cos` instead, producing `cos(360 * index/count) * radius`.

Hook the `Result` outlets of these two patches to the `End Values` of the corresponding transitions.

Now, we'll need to publish the `Index`, `Count`, and `Radius` properties. If we do that on one of the two `Mathematical Expression` patches, the other one won't get those inputs. If we do it on both patches, we might expect that Quartz Composer would send the same value to both patches, but that's not the case. The patch just publishes two sets of inputs with the same name. Useless!

What we want here is an `Input Splitter`. Right click one of the `Mathematical Expression` patches and select `Insert Input Splitter` for `Radius`. This gives you a tiny patch with an unnamed input and output. The key to using this is that you can sennd output from one patch as input to multiple other patches. So drag the noodle from the `Radius` `input splitter` to both `Mathematical Expression` patches' `Radius` input. Repeat for `Index` and `Count`.

Then finally we can publish the `Radius`, `Count`, and `Index` properties in the usual way from the `Input Splitter` patches.

Here is where my `Radial Button` patch stands:

<img width="640" height="423" src="/img/blog/learning-to-build-abstractions-in-quartz-composer/radial-splitters.png">

And then our Composition can use this new and improved version.

<img width="502" height="396" src="/img/blog/learning-to-build-abstractions-in-quartz-composer/composition-patch.png">

With each radius set to 200, count set to 3, and index from 0 to 2, I get the following result:

<img width="256" height="270" src="/img/blog/learning-to-build-abstractions-in-quartz-composer/composition-result.png">

Great! Now we can factor out the `Friction` parameter in the same way. That's your cue. :)

## Put Your Abstraction to Work

Now that was certainy a lot of work to build out that `Radial Button` patch. Let's see how well it serves us by adding a fourth and fifth button to the menu.

First, add your new images to the composition. Delete their `Layer` patches. Drag in two more `Radial Button`s. Hook up their `Image` and `Progress` inlets.

Then set the `Radius` of the two new patches to 200. Set the `Count` of all the `Radial Button` patches to 5. Then finally set the `Index` values of the new patches to 3 and 4.

That's all!

<img src="/img/blog/learning-to-build-abstractions-in-quartz-composer/finished.gif">

Success!

If you wanted to, you could use an `Input Splitter` to avoid duplicating the `Radius` and `Count` properties.

I wonder if there's an automatic way to specify the `Count` and `Index` properties. Is there a way to count or enumerate the number of connections from an outlet? Quartz Composer provides a *lot* of patches so I would not be surprised if it did.

To ace the composition, you could move the menu to the bottom left of the screen and make it cover only a quarter of the circle like Path does. I imagine you could implement the latter merely by choosing interesting values for `Index` and `Count`.

## Conclusion

Quartz Composer is certainly an interesting tool to have in the toolbelt. Origami does a lot to make it more usable and more flexible. For future projects I see no reason to start writing animations in code. Origami is faster to prototype with and gives that sweet, sweet [instantaneous feedback](http://vimeo.com/36579366).

Yes, it is too easy to create a mess of your composition with too many patches. However Quartz Composer thankfully does provide designers robust tools for creating and reusing abstractions. You just have to think like a programmer. ;)
