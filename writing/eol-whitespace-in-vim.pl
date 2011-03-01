use Sartak::Blog;

BEGIN { print "title: End-of-Line Whitespace in Vim\ndraft: 1\n" }

code_snippet vim => << 'EOV';
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red
EOV

p { "autocmd sets up a trigger in vim to run some code on some _event_. In this case we want to run code on InsertEnter and InsertLeave. The next argument to each is the filename pattern. We specify `*` which says we want this trigger for all files. Then the interesting stuff happens." };


code_snippet vim => << 'EOV';
nmap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>
EOV

p { "The `:let @/=''` bit empties the `/` register so that the whitespace you deleted is not used accidentally in an :hlsearch." };
