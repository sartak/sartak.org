use Sartak::Blog;

BEGIN { print "title: End-of-Line Whitespace in Vim\ndraft: 1\n" }

p { "Whitespace characters at the ends of lines are sloppy and useless. Not to mention when you notice and remove them, they clutter up your version control history, though this can be mitigated somewhat by using `git diff --ignore-space-at-eol` or similar. So I have two settings in [my vimrc](https://github.com/sartak/conf/blob/master/vimrc) that help me avoid committing EOL whitespace to any of my hobby or work projects." };

p { "The first one highlights EOL whitespace so you can tell that it's even there, but in a way that isn't _obnoxious_. Vim does offer a builtin option to do this. But it sucks." };

code_snippet vim => << 'EOV';
set list
set listchars=trail:.
EOV

p { "These two settings make it so when whitespace occurs at the end of a line, each character is displayed as a blue period. This is good in theory, but actually it means that whenever you're typing new content, these blue periods show up every single time you're done typing a word and continue on to the next one. This is what I mean by _obnoxious_. Of course there's going to be lots of fleeting EOL whitespace if I'm typing a sentence or a line of code. So a few years ago [Jesse Luehrs](http://tozt.net) and I banged our heads against our own separate walls until we came up with something that worked for us:" };

code_snippet vim => << 'EOV';
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red
EOV

p { "What this does is highlight EOL whitespace with a red background **except on the line you're editing**. Which means it's not _obnoxious_. The highlighting only occurs when you leave insert mode or if you leave that line, such as by hitting insert." };

p { "The `syn clear EOLS` is needed so when you leave insert mode and go back into it, the regex with `\\%#\\@!` runs. This abomination of regex has two components: `\\%#` matches cursor position, and `\@!` is like a negative lookahead from Perl for the previous atom. So in effect this matches end of line whitespace except if the cursor is after that space." };

p { "The other tool I use to combat EOL whitespace is to unceremoniously execute it. This remapping makes `\\w` (or more likely `,w` -- my leader is nonstandard) just kill all EOL whitespace." };

code_snippet vim => << 'EOV';
nmap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>
EOV

p { "This sets up a new normal-mode command `<leader>w`. The `<leader>` is like a user-specific namespace for custom commands; for most people it's going to be `,` but I have it set to `\\`. The `:let @/=''` bit empties the `/` register so that regular expression is not used for the `n` command or `hlsearch` highlighting." };

p { "Some people run a whitespace stripper like this in a `BufWritePre` autocommand. But I don't like that solution because sometimes whitespace at the end of a line _is_ important -- such as in [Markdown](http://daringfireball.net/projects/markdown/syntax#p). Instead, the configuration I've described gives you tools for dealing with EOL whitespace sanely." };

