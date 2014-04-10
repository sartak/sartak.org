use Sartak::Blog;

BEGIN { print "title: Compile-Time Error for Incorrectly Cased <tt>#import</tt>
draft: 1
" }

p { "OS X uses a case-insensitive filesystem by default. That means the following code that purports to load `AFNetworking.h` both compiles and runs, nary a peep:" };

code_snippet 'objc' => << 'CODE';
#import "AfNeTwOrKiNg.H"
CODE

p { "Gawsh, I can't put my finger on it, but that kinda rubs me the wrong way." };

p { "The frequency of my typing `YWaction.h` when I meant `YWAction.h` would frighten children. One of my favorite things about working in a language like Objective-C (relative to my mother tongue Perl, anyway) is that I am immediately notified of most typos. But clang does not warn about this one. It's just plain sloppy. That I cannot abide. Practically, it would also lead to lots of tiny problems should anyone try to build this app on a case-sensitive filesystem." };

p { "Carefully reviewing all the `#import` statements in my project makes my eyes glaze over. So, let's put this high-falutin' typin' teevee machine to work. Here is how you can get [Xcode to text you](http://www.textfromxcode.com) more when you screw up your imports." };

ol {
    li { "Navigate to your app target. It's probably the first entry in your file navigator, then under Targets on the left pane." };
    li { "Select the Build Phases tab." };
    li { "Click the little `+` button at the top left." };
    li { 'Select "New Run Script Build Phase".' };
    li { 'This adds a "Run Script" entry to the bottom of this list. Pop it open by clicking its disclosure triangle.' };
    li { "Set the value of Shell to `/usr/bin/perl`" }
    li { "You heard that right. _Perl_." };
    li { outs "In the text field below Shell, paste in the following Perl script: ";

code_snippet 'perl' => << 'CODE';
my @files = glob("*/*.[hm]");
my %is_file = map { s{.*/}{}r => 1 } @files;
my %lc_file = map { lc($_) => $_ } keys %is_file;

my $errors = 0;

for my $file (@files) {
    open my $handle, "<", $file;
    while (<$handle>) {
        next unless my ($import) = /#import\s*"(.*)"/;
        next if $is_file{$import};

        print qq{$file:$.: warning "$import"};

        if (my $fixed_case = $lc_file{lc $import}) {
            print qq{ (should be "$fixed_case")};
        }

        print qq{\n};

        ++$errors;
    }
}

exit 1 if $errors;
CODE
   };
   li { "Rename the build phase by clicking its name twice. I called mine `Check #import Casing`." };
   li { "Drag and drop to reorder your build phases however you like. Mine's near the top, because I think it's better to fail fast." };
};

p { "When it's all said and done, your build phase should resemble mine. Unless you're from the future, in which case [you look different!](https://www.youtube.com/watch?v=3SbeIqPhtSk)" };

img {
    width is "627";
    height is "696";
    src is "/img/blog/compile-time-error-for-incorrectly-cased-import/build-phase.png";
};

p { "Now when you `⌘B`, Xcode will tell you about all your miscased `#import` statements just like any other builtin error. One less thing to be vigilant about! Happily, Xcode even shows these errors right in context." };

img {
    width is "858";
    height is "64";
    src is "/img/blog/compile-time-error-for-incorrectly-cased-import/sweet-sweet-error.png";
};

p { "You might notice that this is actually an error. That's because in my projects, all warnings are errors. Ain't nobody got time for anything less." };

