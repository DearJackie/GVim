" Gvim configuration file
" Maintainer:	Jackie CAI <caihuaqin@126.com>
" Last change:	2019 Mar 18
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"     for MS-DOS and Win32:  $VIM\_vimrc
"

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

"set t_Co = 256

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=""  " diable mouse
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif " has("autocmd")

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

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


" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

set number      " show line number
set noautochdir " do not change directory when open files, buffers
set nobackup
set noswapfile
set nowrap      " do not wrap long lines
set hlsearch    " hilight search
set ignorecase  " search case insensitive
set smartcase   " When 'ignorecase' and 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not. For example, /The would find only "The", while /the would find "the" or "The" etc.
" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif
set nowrapscan  " do not wrap around for search
set showmatch   " show matching bracket
set autoindent
set smartindent
set tabstop=4
set clipboard+=unnamed  " share the default registers with system clipboard
set noundofile          " no persistent undo file: .un~
set laststatus=2        " last window always has a status line
set foldmethod=syntax   " enable foldering by Syntax
set foldnestmax=20      "
set nofoldenable        " no fold when open a file
set foldlevel=10        " 
set cursorline


" set third party programs path into PATH
let thirdpartypath=$VIM.'\'.'thirdparty'
let $PATH=$PATH.';'.thirdpartypath
let ctagspath=thirdpartypath.'\'.'ctags'
let $PATH=$PATH.';'.ctagspath
let cscopepath=thirdpartypath.'\'.'cscope'
let $PATH=$PATH.';'.cscopepath

" key mappings
let mapleader=" "          " space as the map leader
"nmap <C-tab>               :bn <CR>
nmap <leader>e             :e $MYVIMRC <CR>
nmap <silent> <leader>cmd  :!start cmd /k cd %:p:h<cr>  " open a CMD under the current directory
nmap <silent> <leader>git  :!start "c:\Program Files\Git\git-bash.exe" <cr>  " open a git shell under the current directory
nmap <leader>h             :nohlsearch<CR>              " clear highlights after search
"nmap <F7>                  :cscope find s

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

"colorscheme jackie 

if has("gui_running")
    colorscheme tomorrow-night
    set mousehide		" Hide the mouse when typing text, only works in GUI
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
set tags=./tags;,tags;         " look for "tags" file in the current directory and working directory then upward until "/"(root directory); 
"autocmd BufWritePost !start cmd /k ctags -R -o newtags .        " update ctags file in the background once the source code is modified

" Cscope
"set cscopetag   " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t' and search cscope tag first

" Tagbar
let g:tagbar_left=1            " tagbar windown locates on the left
let g:tagbar_autofocus=1       " cursor will move to tagbar window when it's opened
let g:tagbar_autoclose=1       " close tagbar automatically when selected one tag
nmap <F8> :TagbarToggle <cr> 
