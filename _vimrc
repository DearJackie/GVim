source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" Jackie CAI custimized options
set number      " show line number
set noautochdir " do not change directory when open files, buffers
set nobackup
set noswapfile
set nowrap      " do not wrap long lines
set ignorecase  " search case insensitive
set smartcase   " When 'ignorecase' and 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not. For example, /The would find only "The", while /the would find "the" or "The" etc.
set nowrapscan  " do not wrap around for search
set showmatch   " show matching bracket
set autoindent
set smartindent
set tabstop=4
set clipboard+=unnamed  " share the default registers with system clipboard
set noundofile          " no persistent undo file: .un~
set laststatus=2        " last window always has a status line

" set third party programs path into PATH
let thirdpartypath=$VIM.'\'.'thirdparty'
let $PATH=$PATH.';'.thirdpartypath
let ctagspath=thirdpartypath.'\'.'ctags'
let $PATH=$PATH.';'.ctagspath
let cscopepath=thirdpartypath.'\'.'cscope'
let $PATH=$PATH.';'.cscopepath

" key mappings
let mapleader=" "
"nmap <C-tab>               :bn <CR>
nmap <leader>e             :e $MYVIMRC <CR>
nmap <silent> <leader>cmd  :!start cmd /k cd %:p:h<cr>  " open a CMD under the current directory
nmap <leader>h             :nohlsearch<CR>              " clear highlights after search
"nmap <F7>                  :cscope find s


if has("gui_running")
    colorscheme Tomorrow-Night
	set cursorline
	set mousehide		" Hide the mouse when typing text
    set guioptions-=T   " Hide Toolbar
    set guioptions-=m   " Hide Menubar
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    set guioptions-=e   " default tab style instead of gui style
    if has("gui_win32")
        set guifont=Consolas:h12:cANSI
    else
  
    endif
endif

" plugins
"
" Netrw
"let g:netrw_liststyle=3  " View type is Tree
"nmap <F10> :Lexplore <cr> 

" Ctags
set tags=./tags;,tags;         " look for "tags" file in the current directory and working directory then upward until "/"; 

" Tagbar
let g:tagbar_left=1            " tagbar windown locates on the left
let g:tagbar_autofocus=1       " cursor will move to tagbar window when it's opened
let g:tagbar_autoclose=1       " close tagbar automatically when selected one tag
nmap <F8> :TagbarToggle <cr> 
