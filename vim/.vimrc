
runtime! debian.vim
set nocompatible

if has("syntax")
  syntax on
endif

set encoding=utf-8

let g:EasyMotion_keys = 'asdfjkl;eirughwptyo'
let g:LustyJugglerDefaultMappings = 0
let g:leader_prime = 's'

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" TODO SURROUND plugin
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'jremmen/vim-ripgrep'
Plugin 'easymotion/vim-easymotion'
Plugin 'preservim/nerdtree'

Plugin 'williamboman/mason.nvim'
Plugin 'williamboman/mason-lspconfig.nvim'
Plugin 'neovim/nvim-lspconfig'
Plugin 'hrsh7th/nvim-cmp'
Plugin 'hrsh7th/cmp-buffer'
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'hrsh7th/cmp-path'
Plugin 'hrsh7th/cmp-cmdline'

Plugin 'L3MON4D3/LuaSnip'
Plugin 'saadparwaiz1/cmp_luasnip'

Plugin 'nvim-lua/plenary.nvim'
Plugin 'mhanberg/elixir.nvim'
Plugin 'elixir-editors/vim-elixir'

Plugin 'tikhomirov/vim-glsl'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


set fillchars+=stl:\ ,stlnc:\
set background=dark

try
  colorscheme inkpot
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme slate
endtry


set t_Co=256

":::::::::::::::::::::::::::::::::::::::autocommands::::::::::::::::::::::::::

filetype plugin indent on
if has("autocmd")
  augroup augs
    autocmd!
    "jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    "load indentation rules and plugins according to the detected filetype.
    filetype plugin indent on

    " Remove any trailing whitespace
    autocmd BufRead,BufWrite * if ! &bin |:exe "norm mp" | silent! %s/\s\+$//ge | :exe "norm 'p" |  endif

    autocmd CmdwinEnter * :nnoremap <CR> <CR>
    autocmd CmdwinLeave * :nnoremap <CR> @:
    autocmd BufwinEnter quickfix :nnoremap <CR> <CR>
    autocmd BufwinLeave quickfix :nnoremap <CR> @:

    autocmd BufNewFile,BufRead *.json :set ft=json
    autocmd BufNewFile,BufRead *.php :set ft=php
    autocmd BufNewFile,BufRead *.hs :set ft=haskell
    autocmd BufNewFile,BufRead *.rb :set ft=ruby
    autocmd BufNewFile,BufRead *.js :set ft=javascript
    autocmd BufNewFile,BufRead *.rs :set ft=rust
    autocmd BufNewFile,BufRead *.vimrc :set ft=vim
    autocmd BufNewFile,BufRead *.scala :set ft=scala

  augroup END
endif



":::::::::::::::::::::::::::::::::settings::::::::::::::::::::::::::::::::::::
"
set clipboard=unnamed
set cmdheight=4
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set modelines=0
set scrolloff=5
set hidden
set showmode
set autoindent
set wildmenu
set visualbell
set cursorline
hi CursorLine term=none cterm=none ctermbg=4
set ruler
set laststatus=2
set history=1000
set wrap
set textwidth=79
set formatoptions=qrn1
set gdefault
set incsearch
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set undolevels=2000
set ttyfast
set sw=2
set softtabstop=2
set expandtab
set ls=2
set synmaxcol=2048      " Syntax coloring too-long lines is slow
"set colorcolumn=140
set undofile
set lazyredraw
set noswapfile
set timeoutlen=500
set list listchars=tab:>\ ,trail:-,eol:$

let undodir = "/home/ckw/undo_dir_vim"

":::::::::::::::::::::::::::::::::::::::mapping:::::::::::::::::::::::::::::::
let mapleader=" "

inoremap jk  <ESC>

nnoremap ' `
nnoremap ` '

onoremap ' `
onoremap ` '

" Create Blank Newlines and stay in Normal mode, in same place
nnoremap <silent> <leader>o o<Esc>0d$k
nnoremap <silent> <leader>O O<Esc>0d$j

nnoremap / /\v
nnoremap % v%
nnoremap <tab> v%

noremap , "
noremap ; q:i
nnoremap / q/i\v
nnoremap ? q?i

noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
onoremap <C-l> $
onoremap <C-h> 0
nnoremap I gI
nnoremap gI I

nnoremap <silent> <up> :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <down> :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <right> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <left> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

vnoremap <tab> %
vnoremap / /\v

"::::::::::::::::::::::::::::::::::::GIT::::::::;::::::::::::::::::::::::::::::
nnoremap <leader>gj :GitGutterNextHunk<CR>
nnoremap <leader>gk :GitGutterPrevHunk<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gh :h fugitive<CR>
nnoremap <leader>gl :Glog<CR>:copen<CR>
":::::::::::::::::::::::::::::::::::::::::::::::;::::::::::::::::::::::::::::::

nnoremap <leader>dg :GundoToggle<CR>
nnoremap <leader>dq :copen<CR>
nnoremap <leader>dp :call TogglePaste()<CR>
nnoremap <leader>dC :CtrlPClearAllCaches<CR>
nnoremap <leader>dd <C-^>
nnoremap <leader>de :e<CR>
nnoremap <leader>dE :bufdo! e!<CR>
nnoremap <leader>da q:inorm! ==j0<cr>
nnoremap <leader>dr :set relativenumber! relativenumber?<cr>
nnoremap <leader>di :set invlist<cr>

nnoremap <leader>dsv :source $MYVIMRC<cr>
nnoremap <leader>dso :syn on<CR>

"nnoremap <leader>f :FZF<CR>

"open fuzzy file finder => ss
exe "nnoremap " . g:leader_prime . "s :FZF\<CR>"

"open scratch buffer => sd
exe "nnoremap " . g:leader_prime . "d :Scratch\<CR>"

"execute the contents of the current line => sx
exe "nnoremap " . g:leader_prime . "x :call ExecuteCurrentLine()\<CR>"

exe "nnoremap " . g:leader_prime . "p :call ExecuteCurrentParagraph()\<CR>"

exe "nnoremap " . g:leader_prime . "c :call ExecuteCurrentLineWithBC()\<CR>"

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<CR>

"format entire file
nnoremap <leader>i q:inorm! gg=G<CR>

"send to blackhole register
"nnoremap <leader>r "_d
nnoremap <leader>n q:inorm<space>
nnoremap <leader>p zfip
nnoremap <leader>u za

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nnoremap <leader>z :%s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <leader>; ,
nnoremap <silent> <leader>t :call RotateColorTheme()<CR>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>a :Rg<Space><c-r><c-W><CR>
"nmap <silent> <Leader><Leader> :LustyJuggler<CR>
nmap <silent> <Leader><Leader> :Buffers<CR>

""""""""""""""""""""""unicode character mappings"""""""""""""""""""""""""""""
"nnoremap <leader>u :call Unicodify()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <CR> @:
nnoremap <C-b> <esc>:buffers<cr>
nnoremap n nzz
nnoremap N Nzz

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

nnoremap <C-j> 15j
nnoremap <C-k> 15k

onoremap <C-j> 15j
onoremap <C-k> 15k

vnoremap j gj
vnoremap k gk
vnoremap <C-j> 15j
vnoremap <C-k> 15k

":::::::::::::::::::::::::::::::::::::::::::::::;::::::::::::::::::::::::::::::
let g:Powerline_symbols = 'fancy'
"call Pl#Theme#InsertSegment('color_scheme', 'before', 'fileformat')

":::::::::::::::::::::::::Gundo::::::::::::::::::::::::::::::::::::::::::::::::
let g:gundo_help = 0
let g:gundo_preview_bottom = 1
let g:gundo_close_on_revert = 1
let g:gundo_preview_height = 15
let g:gundo_width = 45
":::::::::::::::::::::::::Gundo::::::::::::::::::::::::::::::::::::::::::::::::

":::::::::::::::::::::::::helper functions:::::::::::::::::::::::::::::::::::::
function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! ShowColourSchemeName()
  try
    return g:colors_name
  catch /^Vim:E121/
    return "default"
  endtry
endfunction

function! TogglePaste()
  if(&paste)
    execute 'set nopaste '
    return
  endif

  execute 'set paste'
endfunction

function! Unicodify()
  exe '.s/<-/←/e'
  exe '.s/::/∷/e'
  exe '.s/ -> / → /e'
  exe '.s/ \. / ∘ /e'
  exe '.s/forall/∀/e'
  exe '.s/ => / ⇒ /e'
endfunction

"function! ExecuteCurrentLine()
"  exe ". !sh"
"endfunction

function! ExecuteCurrentLine()
  let l:com = substitute(getline('.'), '\#', '\\#', '')
  exe "norm! mc"
  exe "norm! o\<Esc>"
  exe "r! " . l:com
  exe "norm! mr"
  exe "norm! o\<Esc>"
endfunction

function! ExecuteCurrentParagraph()
  let l:init = line('.')
  exe "norm! {j"
  let l:start = line('.')
  exe "norm! }"
  let l:end = line('.')
  exe "norm! o\<Esc>"
  exe "r! " . join(getline(l:start,l:end), ' ')
  exe "norm! o\<Esc>"
endfunction

function! ExecuteCurrentLineWithBC()
  let l:com = getline('.')
  exe "norm! o\<Esc>"
  exe "r! " . "echo 'scale=12;" . l:com . "' | bc"
  exe "norm! o\<Esc>"
endfunction

":::::::::::::::::::::::::EasyMotion:::::::::::::::::::::::::::::::::::::::::::
let g:EasyMotion_do_mapping = 0 " Disable default mappings

"Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key
"binding.
"nmap f <Plug>(easymotion-s)
nmap f <Plug>(easymotion-bd-f)

"nmap <leader>j <Plug>(easymotion-j)
"nmap <leader>k <Plug>(easymotion-k)
"nmap <C-f> <Plug>(easymotion-lineforward)
"nmap <C-d> <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

"::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

":::::::::::::::::::::::::Theme Rotating:::::::::::::::::::::::::::::::::::::::
let themeindex = 0
let c_schemes = ["inkpot",
      \ "slate",
      \ "ron",
      \ "blue",
      \ "elflord",
      \ "evening",
      \ "koehler",
      \ "murphy",
      \ "pablo",
      \ "desert",
      \ "torte",
      \ "vibrantink",
      \ "metacosm",
      \ "jellybeans",
      \ "wombat",
      \ "zenburn",
      \ ]



function! RotateColorTheme()
  let g:themeindex = (g:themeindex + 1) % len(g:c_schemes)
  let newtheme = g:c_schemes[g:themeindex]
  execute ":colorscheme ".newtheme
  hi CursorLine term=none cterm=none ctermbg=4
endfunction

"::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
