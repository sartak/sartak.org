use Sartak::Blog;

BEGIN { print "title: TODO? vim ♥ ack\ndate: 2011-09-20\n" }

p { "One pattern I frequently find myself following is acking for a very specific set of results..." }

pre { outs_raw q{ack -a 'uri_for.*(contact|address|phone)'} }

p { "Then I launch vim to start editing the files that were matched here..." }

pre { outs_raw q{vim `ack -la 'uri_for.*(contact|address|phone)'`} }

p { "Then I rewrite the search term using vim's regular expressions instead of Perl's far superior syntax..." }

pre { outs_raw q{/uri_for.*\(contact\|address\|phone\)} }

p { "Then finally I get along with my editing, using both `n` and `:bn` to advance to the each match as needed." }

p { q{It's generally at the "mentally translate the Perl regex to vim" stage where I just say fuck it and fudge it a little bit. There's gotta be something better here. How do you do this? Do you _somehow_ have an editor that works better for this than mine? Surely there's room enough in this world for an ack + vim lovechild that not only loads the proper files into vim, but also automatically starts you off with the (translated!) regex in your search buffer, cursor already waiting at the first result.} }

p { "Do I have to write this thing myself?" }

