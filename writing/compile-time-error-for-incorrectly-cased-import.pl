use Sartak::Blog;

BEGIN { print "title: Compile-Time Error for Incorrectly Cased <tt>#import</tt>
draft: 1
" }

p { "OS X has a case-insensitive filesystem. I don't see that default changing any time soon. That, unfortunately, means it's easy to be sloppy in your file handling. Since the filesystem is case-insensitive, the following code that loads `AFNetworking.h` compiles and runs without a peep:" };

code_snippet 'objc' => << 'CODE';
#import "AfNeTwOrKiNg.H"
CODE

p { "Gee, I can't quite put my finger on it, but that somehow rubs me the wrong way." };

p { "" };
