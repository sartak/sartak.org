use Sartak::Blog;

BEGIN { print "title: DTracing Moose\ndraft: 1\n" }

p { "Moose has long had a perception of incurring a huge compile-time hit. And loading Moose is certainly not free:" };

code_snippet sh => << 'DONE';
$ time perl -e 'use Moose';
perl -e 'use Moose'  0.21s user 0.02s system 96% cpu 0.236 total
DONE

p { "I've been lightly using and pimping DTrace for a while now. I figure what better way to both promote DTrace and to improve Moose by using the one to make the other better!" };

p { "I started by writing this script to load Moose in a loop. Each iteration it forks a new Perl, prints out the process ID, then waits for me to hit enter. This is so I could test loading Moose fresh in a new process and I can attach it to DTrace. There are other ways to do this but this seems the most robust. The script also calls a couple functions that I happened to name `dtrace_begin` and `dtrace_end`, simply so I could zero in on just the Moose load time, ignoring all the other incidental initialization like firing up a new Perl interpreter." };

code_snippet perl => << 'DONE';
#!/usr/bin/env perl

my $purge = shift;

sub dtrace_begin {}
sub dtrace_end {}

while (1) {
    my $child = fork;
    if ($child) {
        waitpid $child, 0;
    }
    else {
        warn $$;
        <>;
        system("purge") if $purge;
        dtrace_begin();
        require Moose;
        dtrace_end();
        exit;
    }
}
DONE

p { "That optional call to `purge` is using a builtin OS X utility to free up as much unused memory as possible. The purpose is to eject the Moose files from the filesystem cache so that I can get a clear picture of what launching Moose _from scratch_ looks like." };

p { "The first DTrace script I wrote simply hooks into the `dtrace_begin` and `dtrace_end` Perl function calls. This is just to get a sense of how long it takes to load Moose with some tracing enabled. It also sets up a variable `loading_moose` so I can filter all other DTrace probes to just track Moose compile time." };

code_snippet dtrace => << 'DONE';
perl$target:::sub-return /copyinstr(arg0) == "dtrace_begin"/ {
    self->loading_moose = 1;
    self->moose_start = timestamp;
}
perl$target:::sub-entry  /copyinstr(arg0) == "dtrace_end"/   {
    printf("spent %dµs loading Moose", (timestamp - self->moose_start) / 1000);
    self->loading_moose = 0;
}
DONE

p { "When Moose is loaded from disk (and is being traced), DTrace reports that it takes about 0.56 seconds. When Moose is loaded from cache (and is being traced), it takes about 0.33 seconds. So Moose spends 0.23 seconds (about 41% of its total time) apparently waiting for disk. That is a larger percentage than I would've expected, especially because I'm using an SSD. But, there's not much we can do to make disk faster except rely on it less. Let's investigate what else Moose is doing, so further investigations will stop purging the Moose code from filesystem cache." };

p { "Going back to `time perl -e 'use Moose'`, we see that loading Moose from cache spends about 0.21s in userland and 0.02s in the kernel. Let's investigate what's going on a little bit more closely." };

code_snippet dtrace => << 'DONE';
BEGIN { depth = 0 }

perl$target:::sub-entry /self->loading_moose/ {
    depth++;
    this->fqn = strjoin(copyinstr(arg3), strjoin("::", copyinstr(arg0)));
    s[depth] = timestamp;
}

perl$target:::sub-return /self->loading_moose/ {
    this->fqn = strjoin(copyinstr(arg3), strjoin("::", copyinstr(arg0)));
    @[this->fqn] = sum( (timestamp - s[depth]) / 1000);
    s[depth] = 0;
    depth--;
}

END { trunc(@, 10) }
DONE

p { "This script will list the inclusive time in microseconds of the top ten heaviest Perlspace function loading Moose. Here's the output." };

code_snippet text => << 'DONE';
Class::MOP::Method::Constructor::new                         235508
Class::MOP::Class::_inline_constructor                       264721
Class::MOP::Attribute::install_accessors                     269078
Moose::Meta::Attribute::BEGIN                                296803
Moose::Meta::TypeCoercion::BEGIN                             316385
Try::Tiny::try                                               408816
Class::MOP::Class::_install_inlined_code                     428425
Class::MOP::Class::_initialize_immutable                     430495
Class::MOP::Class::make_immutable                            514217
Moose::BEGIN                                                 772336
DONE

p { "Of course, `Moose::BEGIN` being the most expensive function makes a lot of sense. Next up is `make_immutable`, which happens to do a lot of work.
