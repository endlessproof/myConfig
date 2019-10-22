" ############################################### Magic Shortcut
" CTRL-j: force convert encoding to UTF-8
" CTRL-t: convert all tab to space
" CTRL-l: switch bracking mode

" ############################################### basic
set nocompatible        " not compatible to vi
set confirm             " enable confirm
set wrap                " auto show in newline if content is too long
set fileencodings=utf-8,utf-16,big5,gb2312,gbk,gb18030,euc-jp,euc-kr,latin1
set encoding=utf-8      " r/w - fileencodings/encoding

" ----------------------------------------------- search
set ignorecase          " ignore case when searching
set smartcase           " ignore in the smart way
set hlsearch            " highlight the search result
set incsearch           " enhance search (searching-when-typing)

" ----------------------------------------------- indent
set cindent             " C-liked auto indent
set expandtab           " expand tab to insert spaces
set tabstop=4           " tab width
set softtabstop=4       " virtual tab width (tab then space)
set shiftwidth=4        " auto indent width

" ----------------------------------------------- backspace
" start to enable CTRL+w (delete word) and CTRL+u
set backspace=indent,eol,start

" ----------------------------------------------- fold
"set foldenable
set foldmethod=indent
set foldlevel=1
set foldnestmax=2

" ----------------------------------------------- statusline
" could be replace by Powerline
" %t, %F, %y -> file name, path, type
" %c, %l, %L -> row, col, total row, view percentage
" %=         -> divided
" %*         -> set default color
" %#name#    -> set color to name
set history=100         " laststatus history
set laststatus=2        " enable laststatus
set statusline=%#filepath#[%{expand('%:p')}]%#filetype#[%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%#filesize#%{FileSize()}%{IsBinary()}%=%#position#%c,%l/%L\ [%3p%%]

function IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[Binary]"
    endif
endfunction

function FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return "[Empty]"
    elseif bytes < 1024
        return "[" . bytes . "]"
    elseif bytes < 1048576
        return "[" . (bytes/1024) . "KB]"
    elseif bytes < 1073741824
        return "[" . (bytes/1048576) . "MB]"
    else
        return "[" . (bytes/1073741824) . "GB]"
    endif
endfunction

" ############################################### visual
colorscheme torte
set t_Co=256            " support 256 colorsi
set cursorline          " show the row cursorline
set cursorcolumn        " show the column cursorline
set number              " show line number
set ruler               " show row:col status at right bottom
" set the line breaks and carriage return
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬
set list                " show the hidden character

" ----------------------------------------------- highlight setting
" available after colorscheme
" cterm: text (none, underline, bold, reverse)
" ctermbg / ctermfg: background and frontground color
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
hi CursorColumn cterm=none ctermbg=DarkMagenta ctermfg=White
hi Search cterm=reverse ctermbg=none ctermfg=White
hi filepath cterm=none ctermbg=238 ctermfg=40
hi filetype cterm=none ctermbg=238 ctermfg=45
hi filesize cterm=none ctermbg=238 ctermfg=225
hi position cterm=none ctermbg=238 ctermfg=228

" ----------------------------------------------- Powerling
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup

" ############################################### user-setting (afun)
" define scope: map, map!, [nvoic]map
" usage: map SHORTCUT CMD

map <C-j>: call ToUTF8()<CR>
map! <C-j> <Esc>: call ToUTF8()<CR>

map <C-t>: call TabToSpaces()<CR>
map! <C-t> <Esc>: call TabToSpaces()<CR>

map <C-l>: call SwitchLineBreakingMode()<CR>
map! <C-l> <Esc>: call SwitchLineBreakingMode()<CR>

" ----------------------------------------------- user-setting mapping function
function ToUTF8()
    if (&fileencoding == "utf-8")
        echo "It is already UTF-8 encoding"
    else
        let &fileencoding="utf-8"
        echo "Convert to UTF-8"
    endif
    let &ff="unix"
endfunction

function TabToSpaces()
    retab
    echo "Convert tab to spaces"
endfunction

function SwitchLineBreakingMode()
    if (&wrap == 0)
        set wrap
        echo "Switch to breaking mode"
    else
        set nowrap
        echo "Switch to one line mode"
    endif
endfunction

" ############################################### Vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'                 " Git wrapper, run git in vim
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}  " A parser for a condensed HTML format
Plugin 'fisadev/vim-isort'                  " Sort python imports using
Plugin 'junegunn/fzf.vim'                   " FZF + vim

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" ############################################### Vundle setting
let g:vim_isort_map= '<C-i>'
let g:vim_isort_python_version = 'python3'
