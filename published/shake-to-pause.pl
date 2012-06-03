use Sartak::Blog;

BEGIN { print "title: Shake to Pause\ndate: 2012-06-03\n" }

p { "This morning I was groggily playing the game I'm [working on](/2012/05/introducing-kanaswirl.html) called [KanaSwirl](http://itunes.apple.com/us/app/kanaswirl/id525332301), supine in bed. Phone inches above my face, purring along in the game, then ***pow!***, I slipped and the bastard hit me right in the cheek. Of course, my game kept running, ignoring my curse, smarting, and eventual rescue of my phone off the floor. But it got me [thinking](http://twitter.com/RPGlanguage/status/208923480887005184): why _didn't_ the game pause? The iPhone has an accelerometer: surely it would be trivial to sense the sudden jolt of glass hitting flesh." };

p { "And it turns out the implementation was indeed trivial. I simply just want to capture the moral equivalent of the \"shake\" gesture and then automatically launch the pause screen. Most games, mine included, already have automatic pausing, so that part's free. Luckily KanaSwirl doesn't use the accelerometer for in-game effects, so I can abuse it for this feature." };

p { "The new code follows. I use the [cocos2d](http://www.cocos2d-iphone.org/) game framework which has tiny abstractions over the [accelerometer API](http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIAcceleration_Class/Reference/UIAcceleration.html#//apple_ref/doc/uid/TP40006901), but I'm sure it's trivially applicable to other systems as well." };

code_snippet objc => '
/* during initialization ... */
self.isAccelerometerEnabled = YES;
[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"shakeToPause"]) {
        if (abs(acceleration.x) > 1 || abs(acceleration.y) > 1 || abs(acceleration.z) > 1) {
            [self autoPause];
        }
    }
}';

p { "I'm sure that `if` check for acceleration could be improved (compare the overall magnitude instead of each component separately?), but what I have here has worked well for me. It doesn't automatically trigger when I'm walking even animatedly, but it does pass the phone-falls-into-cheek test." };

p { "On the off-chance you don't want this behavior, I went ahead and added a snarky setting too." };

image "shake-to-pause/settings.png";

p { "I'm sure many other games could benefit from this shake to pause idea. If you add it to your game, I'd like to hear about it!" };
