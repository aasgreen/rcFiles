"General

"Sets how many lines of history VIM has to remeber
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'lervag/vimtex'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'plasticboy/vim-markdown'
Plugin 'vimwiki/vimwiki'
Plugin 'preservim/nerdtree'
Plugin 'vim-syntastic/syntastic'
"Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-obsession'
call vundle#end()
filetype plugin indent on
set history=700
let mapleader=','
"Enable filetype plugins

filetype plugin on
filetype indent on
set nocompatible

"set persistant undo
set undofile

"set to auto read when a file is changed from the outside

set autoread

"turn off bell
set visualbell
"Set scrolloff high so that the cursor stays in the middle of the screen --changed this, its getting annoying
set so=5
set colorcolumn=80
"Always show current position
set ruler
autocmd BufNewFile,BufRead *.tex setlocal textwidth=80
"A bugger becomes hidden when it is abandoned
set hid

set ignorecase
set smartcase

set hlsearch
set incsearch

set showmatch

"No sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"Colours"

"Enable syntac highlighting
syntax enable
syntax on

"set omnifunc=syntaxcomplete#Complete

colorscheme desert
"set background=dark

"Change colour scheme to zenburn
"
set t_Co=256
colorscheme zenburn

set guifont=DejaVu\ Sans\ Mono\ 20


"All about buffers
"
"Open new, empty buffer

nmap <leader>T :enew<cr>

" Move to next buffer
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>

 "Close buffer
    nmap <leader>bd :bp<BAR> bd #<CR>

 "Show all open buffers and their status
 "
nmap <leader>bl :ls<CR>

"Leave cursor where it lays
set nostartofline

"Turn backup off
"set nobackup
"set nowb
"set noswapfile

"swap files are useful, but put them in their own directory so they don't clutter up the directory`
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

"Use spaces instead of tabs
set expandtab
set smarttab

"i tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

"moving around

"treat long lines as break lines
map j gj
map k gk

"make easier line nav
"nnoremap $ H
"nnoremap ^ L

"python code folding
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf

" Get rid of escape key

:imap jj <Esc>

"delete, but don't save into register
nnoremap s "_d

nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" fortran

let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1

let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0

"navigating files
set suffixesadd={str}
"use markdown for vimwiki
" vimwiki/vimwiki
let g:vimwiki_list = [
                        \{'path': '/mnt/c/Users/rings/Dropbox/Notes/', 'syntax': 'markdown', 'ext': '.md'},
                        \{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
                        \{'diary_rel_path' : ' '}
                        \]
let g:vimwiki_global_ext = 0
"" FocusMode
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    execute 'colorscheme ' . g:colors_name
  endif
endfunc
noremap <F1> :call ToggleFocusMode()<cr>

function! ToggleEncrypt()
    set cm=blowfish2
    set viminfo=
    set nobackup
    set nowritebackup
endfunc
noremap <F12> :call ToggleEncrypt()<cr>
"""Autoboot into encrypt mode when opening .e files
autocmd BufReadPre,FileReadPre *.e :call ToggleEncrypt()
set pastetoggle=<F2>


"""Stop warnings for vimtex
"let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:vimtex_view_method='zathura'
let g:vimtex_complete_enabled=1
let g:vimtex_complete_img_use_tail=1
let g:vimtex_fold_enabled=1


"""Calender integration with google calender

function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map c :call ToggleCalendar()

set number

"" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR>

nmap <F6> :NERDTreeToggle<CR>

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
