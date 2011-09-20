use Sartak::Blog;

BEGIN { print "title: TODO: vim ♥ ack\ndraft: 1\n" }

p { "One pattern I frequently find myself following is acking for a very specific set of results:" }

pre { q{ack -a 'uri_for.*(contact|address|phone)'} }

p { "Then I launch vim to start editing the files that were matched here." }

pre { q{vim `ack -la 'uri_for.*(contact|address|phone)'`} }

p { "Then I rewrite the search term using vim's regular expressions (instead of Perl's)" }

pre { q{/uri_for.*\(contact\|address\|phone\)} }

p { "Then finally I get along with my editing, using `n` and `:bn` to advance to the next match." }

p { "It's generally at the 'mentally translate the Perl regex to vim' stage where I just say fuck it and fudge it a little bit." }

p { "There's gotta be something better here. How do you do this? Do you have an editor that possibly works better here than mine?" }

