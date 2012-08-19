use Sartak::Blog;

BEGIN { print "title: DTracing Moose\ndraft: 1\n" }

p { "Moose has long had a perception of incurring a huge compile-time hit. And loading Moose is certainly not free:" };

code_snippet sh => << 'DONE';
$ time perl -e 'use Moose';
perl -e 'use Moose'  0.21s user 0.02s system 96% cpu 0.236 total
DONE

p { "I thought since I've been lightly using and pimping DTrace for a while now, what better way to both promote DTrace and to improve Moose by using the one to make the other better!" };

p { "I started by writing this script to load Moose in a loop. Each iteration it forks a new Perl, prints out the process ID, then waits for me to hit enter. This is so I could test loading Moose fresh in a new process and I can attach it to DTrace. There are other ways to do this but this seems the most robust. The script also calls a couple functions that I happened to name `dtrace_begin` and `dtrace_end`, simply so I could zero in on just the Moose load time, ignoring all the other incidental initialization like firing up a new Perl interpreter." };

code_snippet perl => << 'DONE';
#!/usr/bin/env perl
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
        system("purge");
        dtrace_begin();
        require Moose;
        dtrace_end();
        exit;
    }
}
DONE

p { "That call to `purge` is using a builtin OS X utility to free up as much unused memory as possible. The purpose is to eject the Moose files from the filesystem cache so that I can get a clear picture of what launching Moose _from scratch_ looks like." };

p { "The first DTrace script I wrote simply looks at how much time is spent between `dtrace_begin` and `dtrace_end`. This is just to get a sense of how long it takes to load Moose with some tracing enabled." };

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

p { "When Moose is loaded from disk (and is being traced), DTrace reports that it takes about 0.56 seconds. When Moose is loaded from cache (and is being traced), it takes about 0.33 seconds." };
