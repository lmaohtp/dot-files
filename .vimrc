set number
syntax on
set tabstop=4

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'rust-lang/rust.vim'
call vundle#end()            " required
filetype plugin indent on    " required
