use Sartak::Blog;

BEGIN { print "title: Role-Based Plugin Design\ndate: 2011-02-11\ndraft: 1\n" }

p { "Roles are a solid basis for a plugin system. Because you can apply a melange of roles to an object, it is alluring to design a system whereby each plugin is a role to be applied directly to the pluggable object. For [Moose], [MooseX::Object::Pluggable] implements this style of architecture for you with a minimum of fuss:" };

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

p { "[Devel::REPL] in particular makes heavy use of MooseX::Object::Pluggable. This project exposes each of its features as a plugin so that each can be enabled and disabled - and superseded - at the user's whim." };

p { "Moose roles support method modifiers to wrap existing methods during composition. This is a practical, but not theoretically sound, extension of the original traits model. This empowers MooseX::Object::Pluggable style plugins to wrap any of the methods of the pluggable object. Needless to say, being able to run code before and after methods, and even to massage arguments and return values, is a powerful tool for extensibility." };

__END__

=item separation of concerns

Treating plugins as roles, as in MXOP, encourages the "god object" design
antipattern. Because L<MooseX::Plugins> plugins are delegate objects and are
not composed into the owner object, separation of concerns is neatly maintained.

=item modularization

Each plugin, because it's a class, gets its own namespace, so plugin authors do
not need to worry about depleting or polluting the owner's namespace.

=item clean initialization

In MXOP, plugins are added to an already initialized object, so C<required>,
C<default>, C<BUILD>, etc., do not work out of the box. Instead, you must
remember to use C<lazy> for your plugins' attributes, and possibly even extend
the role metaobject code to add the concept of post-apply hooks to roles.

But when plugins are classes, each undergoes the complete object initialization
process.

=item removal

As of this writing there is no way to remove a role from a class. I don't see
anything that makes this technically impossible, but in addition to being a lot
more possible, it's also a lot simpler to just remove a plugin from a list of
objects.

=item role theory

L<MooseX::Object::Pluggable> relies heavily on method modifiers for actually
augmenting behavior. Method modifiers are an unclean abuse of role theory and
are implemented only in Moose for convenience - modifiers violate some of the
most important principles of role theory (which is that role application order
should never matter).

(todo: add a note that MXP is a model citizen of role land)

=item introspection

Plugins must consume roles to effect any behavior changes. Because consuming a
role declares particular semantics. Simply wrapping methods in a god object
does not declare any semantics.

=item refactorability

L<MooseX::Object::Pluggable> relies primarily on method modifiers to achieve
behavior extension. This means that the application designer cannot simply
refactor methods that are wrapped by plugins without breaking them.

The application designer has complete control over L<MooseX::Plugins> hook
points. Moving a hook point in use by several plugins can be done safely and
without backwards compatibility issues.
