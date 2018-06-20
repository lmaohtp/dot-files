iletype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'valloric/youcompleteme'
Plugin 'kien/ctrlp.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'lervag/vimtex'
Plugin 'rust-lang/rust.vim'
Plugin 'nkantar/GHT.vim'
Plugin 'fmoralesc/vim-pad'
Plugin 'DrawIt'
Plugin 't1mxg0d/vim-lucario'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'skywind3000/asyncrun.vim'
call vundle#end()
filetype plugin indent on

map <C-n> :NERDTreeToggle<CR>

command Unit execute "new | 0read !/usr/bin/vagrant global-status | awk 'FNR == 3 {print $1}' | xargs vagrant ssh -c 'cd /var/www/phpapps/player.api.stv.tv/ && php7.1 vendor/bin/codecept run unit'"
command Functional execute "new | 0read !/usr/bin/vagrant global-status | awk 'FNR == 3 {print $1}' | xargs vagrant ssh -c 'cd /var/www/phpapps/player.api.stv.tv/ && php7.1 vendor/bin/codecept run functional'"
command Ssh execute "new | 0read !/usr/bin/vagrant global-status | awk 'FNR == 3 {print $1}' | xargs vagrant ssh"
command Provision execute "new | 0read !/usr/bin/vagrant global-status | awk 'FNR == 3 {print $1}' | xargs vagrant provision"
command Up execute "new | 0read !/usr/bin/vagrant global-status | awk 'FNR == 3 {print $1}' | xargs vagrant up"
command Live execute "!osascript ~/Projects/AppleScriptStuff/Live-Conn.scpt"
command QA execute "!osascript ~/Projects/AppleScriptStuff/QA-Conn.scpt"

let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

colorscheme lucario

set encoding=utf-8

" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction

nnoremap <F6> :call<SID>unitTests()<CR>

function! s:unitTests()
    exec "AsyncRun! time /usr/bin/vagrant global-status | awk 'FNR == 3 {print $1}' | xargs vagrant ssh -c 'cd /var/www/phpapps/player.api.stv.tv/ && php7.1 vendor/bin/codecept run unit"
endfunction

" augroup SPACEVIM_ASYNCRUN
"     autocmd!
"    " Automatically open the quickfix window
"     autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
" augroup END
"
" asyncrun now has an option for opening quickfix automatically
let g:asyncrun_open = 15
