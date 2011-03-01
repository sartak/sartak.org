use Sartak::Blog;

BEGIN { print "title: End-of-Line Whitespace in Vim\ndraft: 1\n" }

code_snippet vim => << 'EOV';
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red
EOV

code_snippet vim => << 'EOV';
nmap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>
EOV
