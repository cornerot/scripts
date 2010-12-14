"
" Mathieu Comandon's vimrc
"
" This file is under a WTFPL License :
" http://sam.zoy.org/wtfpl/
"
" You can get the latest version of this file at:
" http://github.com/strycore/scripts/blob/master/vimrc
"
" One day this vimrc file will be the best vimrc EVAR!
" Right now it just needs a lot of work done.
"
" This vimrc is optimised for :
" - PHP and symfony
" - Javascript, CSS, HTML
" - Python
" - Bash
"
" Inspirations:
" How I boosted my Vim (nvie)
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://github.com/nvie/vimrc/blob/master/vimrc
"
" Hacking Vim – The Ultimate Vimrc
" http://www.jonlee.ca/hacking-vim-the-ultimate-vimrc/
"
" Vim as a Python IDE
" http://code.google.com/p/trespams-vim/
"
" Plugins
" -------
" For automatic plugin installation, see the vim-setup script
"
" NERDTree
" taglist
" command-t: https://wincent.com/products/command-t
" ack-grep
"
"
" Extarnal programs
" -----------------
"
"  These are needed by this vim config
"
"  tidy : apt-get install tidy
"  ctags : apt-get install ctags
"  json_xs : http://search.cpan.org/dist/JSON-XS/
"
"  may include in the near future:
"
"  PHP_Beautifier : pear install PHP_Beautifier-0.1.15
"

" Function keys:
" F1:  Help
" F2:  Close buffer
" F3:  Toggle NERDTree
" F4:  Toggle TagList
" F5:  Previous buffer
" F6:  Next buffer
" F7:  Toggle paste mode
" F8:  Toggle between action and template in symfony
" F9:  Reindent whole file
" F10: Available
" F11: Reserved for fullscreen switching by WM or Terminal emulator
" F12: Available

" Other shortcuts:
"
" ,/ Remove search highlight
" ,l Toggle invisible characters
" ,t open command-t filesearch
" :w!! save file with sudo
" "+y  copy to system clipboard
" <Shift>Ins paste from system clipboard
"
set nocompatible
set showcmd
set showmode
set showmatch
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set laststatus=2          " always show status line
set viminfo='1000,f1,:1000,/1000  " big viminfo :)
set mouse=a
syntax on

" Color scheme
" available schemes : desert256, railscasts, wombat, wombat256, wombat256mod,
"                     tango, django
set t_Co=256
colorscheme wombat256

" Identation and tabs
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set copyindent
set backspace=indent,eol,start

set linespace=4
set ruler
set hidden     "don't whine when trying to move away from an unsaved buffer

" Searching
set ignorecase "ignore case when searching
set smartcase  " ignore case if search pattern is all lowercase,
               " case-sensitive otherwise
set hlsearch   " highlight search terms
nmap <silent> ,/ :nohlsearch<CR>
set incsearch

set foldmethod=indent
set foldlevelstart=99
set nofoldenable
set nowrap
set gdefault  " Search all occurrences by default
set history=1000
set undolevels=1000
set wildmenu
set wildmode=longest:full,list
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set noerrorbells
set nobackup    " Backup files are sooo 90's
set noswapfile  " Swap files are very annoying
set lazyredraw
set scrolloff=3 "Keep 3 lines below and above the cursor

set cursorline
set number
set numberwidth=1
set shortmess+=a
set report=0
set confirm
set encoding=utf8
set foldmethod=manual
set matchpairs+=<:>
set showfulltag

let mapleader=","
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_enable = 1


" Highlight long lines
" TODO Hightlight only the 80th character, having the whole end of line in red
"      is ugly and confusing
if has('colorcolumn')
	set colorcolumn=+80
else
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endif

highlight BadWhitespace ctermbg=red guibg=red

filetype plugin on
filetype indent on
if has('autocmd')
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    autocmd FileType c set omnifunc=ccomplete#Complete

    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd BufRead,BufNewFile *.py  set ai sw=4 sts=4 et tw=72

    " Display tabs at the beginning of a line in Python mode as bad.
    autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
    " Make trailing whitespace be flagged as bad.
    autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html set equalprg=tidy\ -i\ -q

    autocmd BufNewFile,BufRead *.rss setfiletype xml
    autocmd BufNewFile,BufRead *.less setfiletype css

    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType css set equalprg=csstidy

    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType php set ft=php.html
    autocmd FileType php set equalprg=php_beautifier\ -l\ \"Pear()\ ArrayNested()\"\ -s2

    " run file with PHP CLI (CTRL-M)
    autocmd FileType php noremap <C-M> :w!<CR>:!php %<CR>

    " PHP parser check (CTRL-L)
    autocmd FileType php noremap <C-L> :!php -l %<CR>
    autocmd FileType php noremap <C-P> :!phpcs %<CR>

    autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    autocmd BufRead,BufNewFile *.vala setfiletype vala
    autocmd BufRead,BufNewFile *.vapi setfiletype vala
endif
if has("gui_running")
    highlight SpellBad term=underline gui=undercurl guisp=Orange
    set guifont=Inconsolata\ Medium\ 12
endif

" Invisible characters
set listchars=tab:▸\ ,trail:.,extends:#,nbsp:.,eol:¬
nmap <leader>l :set list!<CR>

" I think this part remove useless trailing spaces
autocmd BufRead * silent! %s/[\r \t]\+$//
autocmd BufEnter *.php :%s/[ \t\r]\+$//e

map <silent> <A-Right> :tabnext<CR>
map <silent> <A-Left> :tabprevious<CR>
noremap <silent> <C-Left> <C-T>
noremap <silent> <C-Right> <C-]>

noremap <C-S-PageUp> gt
noremap <C-S-pageDown> gT

" Remap autocompletion to Ctrl-Space
inoremap <Nul> <C-x><C-o>
imap <C-space> <C-x><C-o>

" MiniBufExplorer configuration
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" TagList configuration
map <silent> <F4> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1  " split to the right side of the screen
let Tlist_Sort_Type = "order"   " sort by order or name
let Tlist_Compart_Format = 1    " Remove extra information and blank lines.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_GainFocus_On_ToggleOpen =  0 " Jump to taglist window on open.
let Tlist_WinWidth = 40

set tags=.vimtags
set tags+=$HOME/.vim/tags/python.ctags
set tags+=$HOME/.vim/tags/django.ctags

" SnipMate config
let g:snips_author = 'Mathieu Comandon'

" json formating
map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" Toggle NerdTree
map <silent> <F2> :bd<CR>:vsp<CR>
map <silent> <F3> :NERDTreeToggle<CR>

" Move between buffers
map <silent> <F5> :bprevious<CR>
map <silent> <F6> :bnext<CR>

" Toggle paste mode
set pastetoggle=<F7>

"symfony plugin configuration
map <silent> <F8> :SfSwitchView<CR>

"Shortcut to auto indent entire file
nmap <F9> 1G=G
imap <F9> <ESC>1G=Ga

" Save file with sudo
cmap w!! w !sudo tee % > /dev/null

nmap SQ <ESC>:NERDTreeClose<CR>:mksession! ~/.vim/session.vim<CR>:wqa<CR>

" After trying the RestoreSession, it has proved to be fucking annoying
" It will be commented out until sessions work per directory.
"
" The best way to achieve this should be by storing the session.vim inside
" each  individual directory.
"
"function! RestoreSession()
"    if argc() == 0
"    	execute 'source ~/.vim/session.vim'
"    end
"endfunction

"autocmd VimEnter * call RestoreSession()

set path=$PWD/**

python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
