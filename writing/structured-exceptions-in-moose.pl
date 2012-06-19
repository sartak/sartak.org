use Sartak::Blog;

BEGIN { print "title: Structured Exceptions in Moose\ndraft: 1\n" }

p { "At [YAPC::NA 2012](http://yapcna.org/2012), my friend [John Anderson](http://genehack.org/) gave a talk [Code Fast, Die Young, Throw Structured Exceptions](http://act.yapcna.org/2012/talk/126) [(slides)](http://www.slideshare.net/genehackdotorg/code-fast-die-young-throw-structured-exceptions-13313567). During the Q&A portion of that talk I stood up and asked:" };

blockquote { "I am asking this primarily to bother the person \[[Jesse Luehrs](http://tozt.net/), the current maintainer of Moose\] sitting next to me. What would it take to get structured exceptions in Moose?" };

p { "The answer was _patches!_ of course. So at YAPC, John and I started working it out to see how much work it would be. Turns out there about two hundred places where Moose throws exceptions. These errors cover everything from type errors to passing no roles to `with`. And the code is quite ugly. It is littered with comments like:" };

code_snippet perl => << 'X;';
# XXX ugh ugh UGH

# FIXME This

# XXX ignore $args for now, nothing currently uses it anyway

# yes, this is a huge hack, but so is the entire error system, so.
X;

p { "Moose already has a pluggable error system, but it is just as terrible as the above comments suggest. So while John started by adding a structured exception plugin to the existing system, I went with ripping out that system and replacing it with the solid foundation of structured exceptions. New plugins can be added on top of that to stringify exceptions as the user wishes, so we do not lose anything except a lot of cruddy code." };

p { "Moose leads by example." };

p { "Avoid fragile regex-based error selection, which means we have more freedom in the future. Changing error messages can break code. As a practical example of where this hurts, Perl 5.10 changed the text of the undef warning message. The change added a very useful bit of information: the name of the variable that was undefined. But unfortunately this broke all of the test code that looked for such warnings by parsing the message. If instead the Perl core issued warnings and exceptions as objects, then tests could check the exception's classes or roles, which is far less volatile." };

code_snippet perl => << 'X;';
try {
}
catch {
};
X;
