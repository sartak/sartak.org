use Sartak::Blog;

BEGIN { print "title: Path::Dispatcher's Features\ndraft: 1\n" }

p { "[vti's \"Perl routes dispatching comparison\"](http://showmetheco.de/articles/2011/3/perl-routes-dispatching-comparison.html) (which is reminiscent of (miyagawa's plack-dispatching-samples)[https://github.com/miyagawa/plack-dispatching-samples]) originally did not include the routing module that I wrote called `[Path::Dispatcher]`. I'm going to chalk that up to `Path::Dispatcher` not being well-known enough, hence this post. I'd like to describe some features beyond those included in vti's comparison, because `Path::Dispatcher`'s design (which shines through in its API) enables some features not supported by any of the other routing modules I've seen." };

ul {
    li { "more generic than URLs" }
    li { "autocompletion" }
    li { "non-regex-based constraints (Moose type constraints, coderefs)" }
    li { "dispatch inspection (which rule matched)" }
    li { "named captures" }
    li { "API instead of sugar layer" }
    li { "custom rules" }
    li { "including other dispatchers (sorta like subroutes)" }
}

# https://github.com/bestpractical/path-dispatcher/blob/master/t/027-custom-named-captures.t
