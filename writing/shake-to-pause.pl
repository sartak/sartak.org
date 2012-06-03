use Sartak::Blog;

BEGIN { print "title: Shake to Pause\ndraft: 1\n" }

p { "This morning I was groggily playing the game I'm [working on](/2012/05/introducing-kanaswirl.html) called [KanaSwirl](http://itunes.apple.com/us/app/kanaswirl/id525332301), supine in bed. Phone inches above my face, doing reviews, then **\*pow\***, I slipped and the bastard hit me right in the cheek. Of course, my game kept going despite my curse, smarting, and eventually collection of my phone off the floor. But it got me thinking: why _didn't_ the game pause? The iPhone has an accelerometer: surely it would be trivial to sense the sudden jolt of glass hitting flesh." };

p { "And it turns out the implementation was indeed trivial. I simply just want to capture the \"shake\" gesture and then quickly launch the pause screen (as I already do when the app notices it is going into the background). Luckily my game doesn't have, and probably will never need, to use the accelerometer for in-game effects." };

p { "The new code follows. I use the [cocos2d](http://www.cocos2d-iphone.org/) game framework which has an abstraction over the accelerometer API, but I'm sure it's trivially applicable to other systems as well." };

code_snippet objc => '
self.isAccelerometerEnabled = YES;
[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"shakeToPause"]) {
        if (abs(acceleration.x) > 1 || abs(acceleration.y) > 1 || abs(acceleration.z) > 1) {
            [self autoPause];
        }
    }
}';

