use Sartak::Blog;

BEGIN { print "title: End-of-Line Whitespace in Vim\ndraft: 1\n" }

p { "Whitespace characters at the ends of lines are sloppy and useless. Not to mention, when you notice and remove them, they clutter up your version control history, though this can be mitigated somewhat by using `git diff --ignore-space-at-eol` or similar. So I have two settings in [my vimrc file](https://github.com/sartak/conf/blob/master/vimrc) that help me avoid committing EOL whitespace to any of my hobby or work projects." };

p { "The first one highlights EOL whitespace in a way that isn't _obnoxious_. vim does have a builtin way to do this. But it sucks." };

code_snippet vim => << 'EOV';
set list
set listchars=trail:.
EOV

p { "These two settings make it so when whitespace occurs at the end of a line, each character is displayed as a blue period. This is good in theory but in practice it means that whenever you're typing new content, these blue periods show up whenever you're done typing a word and continue on to the next one. This is what I mean by _obnoxious_. Of course there's going to be lots of fleeting EOL whitespace if I'm typing a sentence or a line of code. I don't need to be distracted by a blue dot bouncing around with my cursor. So a few years ago [Jesse Luehrs](http://tozt.net) and I banged our heads against our own separate walls until we came up with something that worked for us:" };

code_snippet vim => << 'EOV';
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red
EOV

p { "What this does is highlight EOL whitespace with a red background (we'd use a red foreground but it's whitespace, you see!) **except on the line you're editing**. Which means it's not _obnoxious_." };

p { "It's worth explaining how it works. `autocmd` is used to register triggers in vim, to run some code after some _event_. In this case we want to run code on the `InsertEnter` and `InsertLeave` events. The next argument to each `autocmd` is the filename pattern. We specify `*` which says we want this trigger for all files, not just `.html` or `Makefile` or whatever. Then the interesting stuff happens." };

p { "..." };

p { "The other tool I use to combat EOL whitespace is to unceremoniously execute it. This remapping makes `\\w` (or more likely `,w` -- my leader is nonstandard) just kill all EOL whitespace." };

code_snippet vim => << 'EOV';
nmap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>
EOV

p { "`nmap` sets up a normal mode command remapping (see also `imap`, `vmap`, etc). The `<leader>` is the user-configurable modifier key to provide you with a sort of namespace for your own commands. By default the leader is comma but I like backslash better. So `<leader>w` remaps the `\\w` in normal mode to run everything after the new command key sequence. When you type `\\w` then vim will act as if you had typed `:%s/\\s\\+\$//<CR>:let \@/=''<CR>`." };

p { "The first part should be familiar to anyone who's used vim seriously. `:%s/\\s\\+\$//` just runs a substitution to remove all whitespace characters that occur at end of line. `<CR>` is a way to mock typing the Enter key in vimscript. The `:let @/=''` bit empties the `/` register so that the whitespace you deleted is not used accidentally in an :hlsearch." };

