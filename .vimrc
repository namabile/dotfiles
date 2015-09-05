set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'derekwyatt/vim-scala'
Plugin 'flazz/vim-colorschemes'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Raimondi/delimitMate'
Plugin 'EasyMotion'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'jpalardy/vim-slime'
Plugin 'juvenn/mustache.vim'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'mikewest/vimroom'

call vundle#end()            " required

syntax enable
colorscheme Monokai

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set number
set laststatus=2
set smartindent
set autoindent
set nowrap
set magic
imap jj <Esc>

" custom tabs by file type
set nowrap
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set magic
set shiftround

filetype on
filetype indent on
filetype plugin indent on 
filetype plugin on

set cinoptions=(0,10,t0,(0,w1

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType scala setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType sql setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType md setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

" Stip trailing whitespace from files on save
autocmd FileType c,scala,cpp,python,ruby,java,sql,php,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

" Markdown, people
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.markdown set filetype=markdown

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell
"
" Set word wrap for markdown filetypes
" autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,javascript    let b:comment_leader = '// '
autocmd FileType sql                            let b:comment_leader = '--  '
autocmd FileType sh,ruby,python                 let b:comment_leader = '# '
autocmd FileType conf,fstab                     let b:comment_leader = '# '
autocmd FileType vim                            let b:comment_leader = '" '
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR> 
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

let mapleader=" "
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :e<Space>

map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>     " And load session with F3
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>] :tabn<CR>
nnoremap <Leader>[ :tabp<CR>
nnoremap <Leader>n :tabnew<CR>
nnoremap <Leader>i i<CR><ESC>
nnoremap <Leader>d :bd<CR>
inoremap II <Esc>I
inoremap AA <Esc>A
inoremap OO <Esc>O
inoremap CC <Esc>Ci
inoremap SS <Esc>Si
inoremap DD <Esc>ddi
inoremap UU <Esc>ui

vmap <C-c> :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -sel clip -i<CR>u
map <Insert> :set paste<CR>i<CR><CR><Esc>k:.!xclip -o<CR>JxkJx:set nopaste<CR>

command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

set encoding=utf-8
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" Vim Slime Describe table leader key: Place cursor on a table name and
" execute to describe a table in Vertica
" via jperkins
nnoremap <Leader>dt "ayiW:SlimeSend1 \d <C-r>a<cr>

" Generate SQL DML Statement for the table under the cursor
nnoremap <Leader>dml "ayiW:SlimeSend1 select export_objects('','<C-r>a');<cr>

" SelectStar: Grab 50 records from the table under the cursor
nnoremap <Leader>ss "ayiW:SlimeSend1 select * from <C-r>a limit 50;<cr>

set pastetoggle=<F10>
set tags=tags;/

let g:vimroom_width=160
let g:vimroom_sidebar_height=0

set includeexpr=substitute(v:fname,'_','/','g').'.php'
set suffixesadd=.tpl
set suffixesadd=.js
