use Sartak::Blog;

BEGIN { print "title: Structured Exceptions in Moose\ndraft: 1\n" }

p { "At [YAPC::NA 2012](http://yapcna.org/2012), my friend [John Anderson](http://genehack.org/) gave a talk [Code Fast, Die Young, Throw Structured Exceptions](http://act.yapcna.org/2012/talk/126) [(slides)](http://www.slideshare.net/genehackdotorg/code-fast-die-young-throw-structured-exceptions-13313567). During the Q&A portion of that talk I stood up and asked:" };

blockquote { "I'm asking this primarily to bother the person \[[Jesse Luehrs](http://tozt.net/), the current maintainer of Moose\] sitting next to me. What would it take to get structured exceptions in Moose?" };

p { "Moose leads by example." };

p { "Avoid fragile regex-based error selection, which means we have more freedom in the future. Changing error messages can break code. As a practical example of where this hurts, Perl 5.10 changed the text of the undef warning message. The change added a very useful bit of information: the name of the variable that was undefined. But unfortunately this broke all of the test code that looked for such warnings by parsing the message. If instead the Perl core issued warnings and exceptions as objects, then tests could check the exception's classes or roles, which is far less volatile." };

code_snippet perl => << 'X;';
    try {
    }
    catch {
    };
X;


