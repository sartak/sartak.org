title: Macros in Quartz Composer
draft: 1

I decided today that I would learn a bit of (Quartz Composer)[http://en.wikipedia.org/wiki/Quartz_Composer]. One very helpful article was "(UI Prototyping with Quartz Composer and Origami)[http://www.pasanpremaratne.com/2014/03/15/UI-Prototyping-with-Quartz-Composer-and-Origami/]" by Pasan Premaratne. This article takes you from zero to having built a simpler version to Path's attractive spinout menu with Facebook's (http://facebook.github.io/origami/)[Origami]. At the end of Pasan's post, he mentions,

> The only downside that I see right now to using Quartz
> Composer is that if you're protoyping something complex,
> your composition can get unwieldy and convoluted fairly quickly.
> In just creating a radial menu with three buttons we have
> over 20 patches in our composition. This can be mitigated
> to some effect by rearranging and using QC's notes feature.

I agree that it's unwieldy. Here's my version of the composition:

<img width="392" height="267" src="/img/blog/macros-in-quartz-composer/notes.png">

I thought I'd take this one step further and use this "Macro" feature I kept seeing all over Quartz Composer. Because I really try my hardest to never repeat myself! I'm writing this as I learn how macros work, so there may be some false starts.

Step one is to read and follow along with everything in Pasan's post. I'll be here.

## Macros

The next step, surely, must be to select the patches representing one of the buttons and click "Create Macro". This replaces all the patches with just a "Macro Patch". The noodle from "Interaction 2"'s Drag outlet is connected to this macro patch, which is a good sign. In fact if you go over to the Viewer you should see that nothing has changed.

Double click the macro (in its body, not its titlebar) to edit its contents. We can see that it's almost identical to what we had before for Button A. However there's a new patch called "Number Splitter" near the top. This must be how Quartz Composer models the input to the bouncy and classic animations from outside the macro. The patch's inlet is green presumably to indicate that.

If we want to make this macro generic, we need to create our own parameters. The button image must be a parameter otherwise every button will be labeled "A". The best place to start is probably to delete the image patch which is hardcoded to be `ButtonA.png`.

To parameterize the image, right click the Layer patch. Under "Publish Inputs" select the "Image" option. QC offers to let you name the parameter differently from what the Layer patch expects, but in this case we can stick with "Image". This turns the inlet green, which matches the "Number Splitter" parameter. Here's to hoping!

Clicking "Edit Parent" in the QC toolbar leaves the macro and goes back to our overall composition. If you look at the macro patch you can see that it now has an "Image" inlet. Success! Drag that `ButtonA.png` back into the composition, delete its layer, and hook up its outlet to the macro.

If all went according to plan, there should be no change in the Viewer. Still three spinout buttons labeled A, B, and C.

*Here begins one of those false starts. Read on a little bit before making changes to your composition.*

Let's get rid of the other two buttons and replace them with macros. Copy and paste works just fine. Make sure that each of the three Macros has its Input and Image inlets populated.

Running the Viewer you now see that there's only one button. The problem of course is that all three buttons are animating between the same positions at the same times, so the other two buttons are hiding below the visible one.

Need more macro parameters! But now I would have to edit the macro three times, once for each button, because I used copy and paste to duplicate the macros. That's no good!

*Lesson learned. False start over.*

## User-Defined Patches

Another button in the QC toolbar is "Add to Library". I presume that is for reusing components you've built up. So instead of copying and pasting the macro, let's add it to our library as a new patch type. After playing around a little I've discovered that rather than adding the macro to your library directly, it's better to explode the macro first (available under the right-click menu). Call the new patch type "Radial Button" or something.

Then from the Patch Library drag in two more Radial Buttons and wire them up. You'll notice that the inlets are now called "Enable", "Input", and "Input". Not great, let's fix that first.

In the Patch Library right click the Radial Button object and select Edit. Then without selecting a patch open up the Patch Inspector. This inspects the Radial Button patch itself. In the dropdown at the top select "Published Inputs & Outputs". You'll see a table of `Input` mapped to `input_proxy_1` and another `Input` mapped to `input_proxy_2`. Change one of the `Input` labels to `Progress` and the other to `Image`. I don't know if there's a way to immediately see which is which, but if you save and reopen the Radial Button the label on the layer should say "Image" not "Progress". If you messed it up just fix it in the inspector.

Now that we've renamed the properties let's go back to our composition and see the fruits of our labor.

<img width="143" height="78" src="/img/blog/macros-in-quartz-composer/radial-input-input.png">

Ah crud. It looks like every time we edit the Radial Button patch we'll need to remove it from our composition and add the new version back in. Be careful to adjust the layers after you do this. Hit Area should be the layer with the highest number, then the Plus Button Layer should be the next layer below that. If you miss this step it will cause a bit of frustration! :)

Next let's make more properties into parameters. x- and y-coordinate are as good a place to start as any. Recall that in Pasan's post we assigned different end values to each of the transition patches. However, notice that the Start Value and End Value of the transition patch are ordinary inputs. That means we can publish those inputs from the Radial Button patch itself. Start by right clicking Transition X, Publish Inputs, End Value. Call it "End X". Similarly, publish Transition Y's End Value as "End Y".

Go back to your composition, remove the Radial Button patches, and readd them. You'll see now that you have the new End X and End Y inputs. Hook up the Progress and Image inlets. Then, using the same method as in Pasan's post, assign static values for each of the End X and End Y inputs for each of the three buttons. For convenience they are:

- A button: (-184.5,-408.5)
- B button: (0,-298.5)
- C button: (184.5, -408.5)

Notice how the values for End X and End Y start as the values that had been assigned to each End Value of the two transitions. If you wish to, you can change them by editing the Radial Button patch, using the Patch Inspector with no patch selected, then changing the values under Input Parameters.

In the Viewer confirm that the animation is working again. The only thing left to fix is the friction and tension of each of the buttons coming out. I'm sure you can handle doing that at this point.

## How Bout Dem Abstractions

Thanks to our custom Radial Button patch, there is less duplication in our composition. The number of patches has decreased significantly, which makes the composition more easily comprehensible.

That is not good enough. We want it to be as easy to add a new button to this menu as it would be in, say, Interface Builder.

Let's simplify the problem first. Let's move everything to the origin. That means you need to change the Radial Button's Start Value for both Transition X and Transition Y to 0. And then in your composition, change the y-coordinate of the Add Button and the Hit Test from -512 to 0.

Next, we'll remove the End X and End Y published inputs from the Radial Button. The way you can remove them is the same way you add them: just right click the patch and select the property under Published Inputs.

The new inputs we'll want are Radius, Count, and Index. Radius will tell us how far from the origin to push the button. Count and Index will be used to decide where on the circle the button will go.

We'll need `sin` and `cos` to take the angle of `Index/Count` and decide which coordinates to put the button. We can use the Mathematical Expression patch to access these functions. We'll need one for the x-coordinate and another for the y-coordinate so drag out two.

If you inspect a Mathematical Patch, under the Settings pane there is a text field for formula. Any undefined variables you use in this formula will end up as inputs to the patch (which is a wonderful nugget of design).

For the x-coordinate patch, we'll want to use the formula `sin(360 * index/count) * radius`. Note that `sin` uses degrees not radians! Knowing that will save you twenty minutes of self-doubt and headscratching. :)

For the y-coordinate patch, we'll use the same formula but with `cos` instead, producing `cos(360 * index/count) * radius`.

Hook the Result outlets of these two patches to the End Values of the corresponding transitions.

Now, we'll need to publish the Index, Count, and Radius properties. If we do that on one of the two Mathematical Expression patches, the other one won't get those inputs. If we do it on both patches, we might expect that Quartz Composer would send the same value to both patches, but that's not the case. The patch just publishes two sets of inputs with the same name. Useless!

What we want here is an Input Splitter. Right click one of the Mathematical Expression patches and select Insert Input Splitter for radius. This gives you a tiny little patch with unnamed input and output. The key to using this is that you can push output from one patch as input to multiple other patches. So drag the noodle from the radius input splitter to both Mathematical Expression patches' radius input. Repeat for index and count.

Then finally we can publish the Radius, Count, and Index properties in the usual way from the Input Splitters.

Here is where my Radial Button patch stands:

<img width="640" height="423" src="/img/blog/macros-in-quartz-composer/radial-splitters.png">

And then from our Composition we can use this new and improved version.

<img width="502" height="396" src="/img/blog/macros-in-quartz-composer/composition-patch.png">

With each radius is set to 200, count set to 3, and index from 0 to 2, I get the following result:

<img width="256" height="270" src="/img/blog/macros-in-quartz-composer/composition-result.png">

Great! Now we can factor out the friction parameter in the same way. Exercise for the reader. :)

## Put Your Abstraction to Work

Now that was a lot of work to build out that Radial Button patch. Let's see how well it serves us by adding a fourth and fifth button to the menu.

First, add your new images to the composition. Delete their Layer patches. Drag in two more Radial Buttons. Hook up their Image and Progress inlets.

Then set the Radius of the two new patches to 200. Set the count of all the Radial Button patches to 5. Then finally set the index values of the new patches to 3 and 4.

That's all!

<img width="314" height="275" src="/img/blog/macros-in-quartz-composer/five-buttons.png">

If you wanted to, you could use an Input Splitter to avoid duplicating the Radius and Count properties.

I wonder if there's an automatic way to specify the Count and Index properties. Is there a way to count or enumerate the number of connections from an outlet?

Another next step would be to move the menu to the bottom left of the screen and make it cover only a quarter of the circle like Path does. I imagine you could implement the latter merely by choosing interesting values for Index and Count.

## Conclusion

Quartz Composer is certainly an interesting tool to have in the toolbelt. Origami does a lot to make it more usable and more flexible. For future projects I see no reason to start writing animations in code.

Yes it is too easy to create a mess of your composition with too many patches. However Quartz Composer does provide designers robust tools for creating and reusing abstractions. You just have to think like a programmer. ;)
