use Sartak::Blog;

BEGIN { print "title: Preserving Class::MOP commit history in Moose\ndraft: 1\n" }

p { "Ever use git blame or log in the Class::MOP parts of the Moose repository? You've probably seen Dave Rolsky's mega-commit `38bf2a25`." };

code_snippet text => << 'TEXT';
$ git blame lib/Class/MOP/Package.pm

38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600   1)
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600   2) package Class::MOP::Package;
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600   3)
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600   4) use strict;
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600   5) use warnings;
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600   6)
0db1c8dc (Jesse Luehrs 2011-04-17 19:11:28 -0500   7) use Scalar::Util 'blessed', 'reftype', 'weaken';
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600   8) use Carp         'confess';
0db1c8dc (Jesse Luehrs 2011-04-17 19:11:28 -0500   9) use Devel::GlobalDestruction 'in_global_destruction';
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600  10) use Package::Stash;
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600  11)
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600  12) use base 'Class::MOP::Object';
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600  13)
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600  14) # creation ...
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600  15)
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600  16) sub initialize {
38bf2a25 (Dave Rolsky  2010-12-27 08:48:08 -0600  17)     my ( $class, @args ) = @_;
TEXT

p { "This is problematic because there is a rich and certainly important four years' worth of history in Class::MOP before December 27th, 2010, which is when it was merged into the Moose repository. For example, I was curious when exactly Moose started forbidding bare references for attribute `default`. I had to resort to clumsily bisecting Class::MOP releases on metacpan to find that the restriction was added in version 0.33 (August 19th, 2006). I was sad that I was not able to use my usual `git blame` or `git log` tools because all Class::MOP history leads to `38bf2a25`." };

p { "Ideally we would be able to tweak `38bf2a25`, two years later, to add a second parent commit (namely, the last commit in Class::MOP, `d004c8d5`). This would turn it into a merge commit, which is how we could inject the entire Class::MOP commit history into Moose's history. From then on git would inspect both histories to produce blame reports, commit logs, and so on. Just like any other merge commit." }

p { "Alas, we cannot just go ahead and change the public Moose repository to have the Class::MOP history like that. Adding a second parent to `38bf2a25` would change that commit's SHA. That would cause a cascade of changes to every subsequent commit (and their SHAs) in the two years' worth of commits since. However! you, my friend, can fix it for your own checkout without worrying about screwing anybody up. git has a tool for rewiring parent commits. Two, in fact. The original tool was called `git graft` but there is a newer, more powerful replacement called, well, `git replace`. These tools allow you to tweak individual commits in your local repository without disrupting other commits and their SHAs. This means you can still freely and painlessly share your branches and commits with GitHub and other developers." };

p { "To do this, start by cloning up a new copy of the Moose repository for playing around. Not strictly necessary, but caution is definitely warranted here. You want to make sure this procedure works before I, through you, potentially damage your working copy." };

code_snippet sh => << 'BASH';
git clone gitmo@git.moose.perl.org:Moose.git
cd Moose
BASH

p { "Next, fetch Class::MOP's master so its commits also exist within the Moose repository." };

code_snippet sh => << 'BASH';
git remote add cmop gitmo@git.moose.perl.org:Class-MOP.git
git fetch cmop master
BASH

p { "Finally, fix the sledgehammer-merge commit `38bf2a25` to include both its original parent commit **and** the last Class::MOP commit. To do that we create an entirely new commit object that is exactly like `38bf2a25` except it has that second parent commit, `d004c8d5`. Then we use `git replace` to tell git to use the new SHA (probably `f18fded8`) in place of `38bf2a25`." };

code_snippet sh => << 'BASH';
NEW_MERGE=$(git cat-file commit 38bf2a25 | perl -ple '/^parent / && print "parent d004c8d565f9b314da7652e9368aeb4587ffaa3d"' | git hash-object -t commit -w --stdin)
git replace 38bf2a25 $NEW_MERGE
BASH

p { "All done. Enjoy your new (old) history!" };

code_snippet text => << 'BASH';
$ git log --grep associated_metaclass --format='format:%h %ad %an%n    %s' lib/Class/MOP

cc03c2b Sun Feb 19 12:51:48 2012 -0600 Dave Rolsky
    Weaken the associated_metaclass after cloning a method.
        -- post-merge commit
aa5bb36 Mon Apr 25 10:38:05 2011 -0500 Jesse Luehrs
    fix setting associated_metaclass and attribute on accessor objects
        -- post-merge commit
09ea7f8 Sun Aug 10 18:24:02 2008 +0000 Yuval Kogman
    package_name >= associated_metaclass->name
        -- pre-merge commit!
5e60726 Sun Aug 10 17:42:29 2008 +0000 Yuval Kogman
    add associated_metaclass to Method
        -- pre-merge commit!
BASH

code_snippet text => << 'TEXT';
$ git blame lib/Class/MOP/Package.pm

2243a22b (Stevan Little   2006-06-29 18:27:47 +0000   1)
2243a22b (Stevan Little   2006-06-29 18:27:47 +0000   2) package Class::MOP::Package;
2243a22b (Stevan Little   2006-06-29 18:27:47 +0000   3)
2243a22b (Stevan Little   2006-06-29 18:27:47 +0000   4) use strict;
2243a22b (Stevan Little   2006-06-29 18:27:47 +0000   5) use warnings;
2243a22b (Stevan Little   2006-06-29 18:27:47 +0000   6)
0db1c8dc (Jesse Luehrs    2011-04-17 19:11:28 -0500   7) use Scalar::Util 'blessed', 'reftype', 'weaken';
6d5355c3 (Stevan Little   2006-06-29 23:28:32 +0000   8) use Carp         'confess';
0db1c8dc (Jesse Luehrs    2011-04-17 19:11:28 -0500   9) use Devel::GlobalDestruction 'in_global_destruction';
407a4276 (Jesse Luehrs    2010-05-10 23:20:29 -0500  10) use Package::Stash;
2243a22b (Stevan Little   2006-06-29 18:27:47 +0000  11)
f197afa6 (Jesse Luehrs    2010-05-10 21:13:19 -0500  12) use base 'Class::MOP::Object';
6e57504d (Stevan Little   2006-08-12 06:13:02 +0000  13)
6d5355c3 (Stevan Little   2006-06-29 23:28:32 +0000  14) # creation ...
6d5355c3 (Stevan Little   2006-06-29 23:28:32 +0000  15)
6d5355c3 (Stevan Little   2006-06-29 23:28:32 +0000  16) sub initialize {
3be6bc1c (Yuval Kogman    2008-08-14 18:21:45 +0000  17)     my ( $class, @args ) = @_;
TEXT
