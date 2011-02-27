use Sartak::Blog;

BEGIN { print "title: Plugins are Objects not Roles\ndraft: 1\n" }

p { "Say you're banging out a complex application and you want it to support plugins, both to enable optional functionality and to promote open extensibility. If you're doing this with [Moose](http://moose.perl.org), you have a number of options for getting plugins. Today I'm here to talk about plugins based on [roles](http://www.modernperlbooks.com/mt/2009/04/the-why-of-perl-roles.html)." };

h3 { "Plugins as Roles" };

p { "Because you can apply an assortment of roles to an object, it is alluring to design a system whereby **each plugin is a role** to be applied directly to the pluggable object. For Moose, `[MooseX::Object::Pluggable]` provides this for you with a minimum of fuss. Just consume the `MooseX::Object::Pluggable` role and call `load_plugin`." };

perl << 'EOP';
package App;
use Moose;
with 'MooseX::Object::Pluggable';

package App::Plugin::Foo;
use Moose::Role;

sub foo { print "This is a plugin method" }

my $app = App->new;
$app->load_plugin('Foo'); # applies App::Plugin::Foo to $app
$app->foo; # This is a plugin method 
EOP

p {
    outs "Moose roles support method modifiers to wrap existing methods during composition. This is a practical, but not strictly theoretically sound, extension of the original traits model.";
    footnote { "Roles are supposed to have the same effects no matter which order you consume them in, but method modifiers let you break this rule. Moose continues to support method modifiers in roles because the feature is very pragmatic." };
    outs "This empowers `MooseX::Object::Pluggable` style plugins to wrap any of the methods of the pluggable object. Needless to say, being able to run code before and after any method, and even to massage arguments and return values, is a powerful tool for extensibility.";
};

p { "`[Devel::REPL]` in particular makes heavy use of `MooseX::Object::Pluggable`. This project exposes each of its features as a plugin so that each can be enabled and disabled - and superseded - at the user's whim. For example `[Devel::REPL::Plugin::MultiLine::PPI]` wraps `Devel::REPL`'s `read` method to use `[PPI]` to test if the input is complete, and if not, read another line. This lets you type in `for (1 .. 10) {` and hit enter without an immediate syntax error for missing the corresponding `}`. And of course if a better `PPI` comes along, someone can write a new `Devel::REPL::Plugin::MultiLine::PPI6` that uses that new system and people can switch over to the new plugin at their leisure." };

h3 { "Plugins as Objects with Roles" };

p { "Another option, which I will argue is superior, is that **each plugin is an object consuming roles**." };

h3 { "Fight!" };

# separation of concerns
p { "Treating plugins as roles, as in MXOP, encourages the \"god object\" design antipattern. Because object-based plugins are delegate objects and are not composed into the owner object, separation of concerns is neatly maintained." };

#modularization
p { "Each plugin, because it's a class, gets its own namespace, so plugin authors do not need to worry about depleting or polluting the owner's namespace." };

#clean initialization

p { "In MXOP, plugins are added to an already initialized object, so `required`, `default`, `BUILD`, etc., do not work out of the box. Instead, you must remember to use `lazy` for your plugins' attributes, and possibly even extend the role metaobject code to add the concept of post-apply hooks to roles. But when plugins are classes, each undergoes the complete object initialization process." };

# removal

p { "As of this writing there is no way to remove a role from a class. I don't see anything that makes this technically impossible, but in addition to being a lot more possible, it's also a lot simpler to just remove a plugin from a list of objects." };

#role theory

p { "`MooseX::Object::Pluggable` relies heavily on method modifiers for actually augmenting behavior. Method modifiers are an unclean abuse of role theory and are implemented only in Moose for convenience - modifiers violate some of the most important principles of role theory (which is that role application order should never matter)." };

# TODO add a note that MXP is a model citizen of role land

#introspection

p { "Plugins must consume roles to effect any behavior changes. Because consuming a role declares particular semantics. Simply wrapping methods in a god object does not declare any semantics." };

# refactorability

p { "`MooseX::Object::Pluggable` relies primarily on method modifiers to achieve behavior extension. This means that the application designer cannot simply refactor methods that are wrapped by plugins without breaking them. The application designer has complete control over object-based-plugin hook points. Moving a hook point in use by several plugins can be done safely and without backwards compatibility issues." };

