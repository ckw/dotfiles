
runtime! debian.vim
set nocompatible

if has("syntax")
  syntax on
endif

set encoding=utf-8

let g:LazyLoad_plugins = ["vundle"]
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


set t_Co=256
set termguicolors
set fillchars+=stl:\ ,stlnc:\
set background=dark

try
  colorscheme ckw
  "colorscheme inkpot
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme slate
endtry



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
    autocmd BufNewFile,BufRead *.metal :set ft=cpp
    autocmd BufNewFile,BufRead *.bot :set ft=bot

  augroup END
endif



":::::::::::::::::::::::::::::::::settings::::::::::::::::::::::::::::::::::::
"
set clipboard=unnamedplus
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
hi CursorLine term=none cterm=none ctermbg=17
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

"nnoremap / /\v
nnoremap <leader>f :Telescope current_buffer_fuzzy_find<CR>
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
"exe "nnoremap " . g:leader_prime . "s :FZF\<CR>"
exe "nnoremap " . g:leader_prime . "s :Telescope find_files\<CR>"

"open scratch buffer => sd
exe "nnoremap " . g:leader_prime . "d :Scratch\<CR>"

"execute the contents of the current line => sx
exe "nnoremap " . g:leader_prime . "x :call ExecuteCurrentLine()\<CR>"

exe "nnoremap " . g:leader_prime . "p :call ExecuteCurrentParagraph()\<CR>"

exe "nnoremap " . g:leader_prime . "c :call ExecuteCurrentLineWithBC()\<CR>"

exe "nnoremap " . g:leader_prime . "k :call ExecuteCurrentParagraphAsFileWithPython3()\<CR>"

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
"nnoremap <leader>a :Rg<Space><c-r><c-W><CR>
nnoremap <leader>a :Telescope grep_string<CR>
"nmap <silent> <Leader><Leader> :LustyJuggler<CR>
"nmap <silent> <Leader><Leader> :Buffers<CR>
nmap <silent> <Leader><Leader> :Telescope buffers<CR>

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

function! ExecuteCurrentLine()
  exe "norm! mc"
  let l:com = substitute(getline('.'), '\#', '\\#', 'g')
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

function! ExecuteCurrentParagraphAsFileWithPython3()
  let l:init = line('.')
  exe "norm! {j"
  let l:start = line('.')
  exe "norm! }k"
  let l:end = line('.')

  " Generate a unique temporary file path
  let temp_file_path = tempname() . '.py'

  " Write the paragraph to the temporary file
  call writefile(getline(l:start, l:end), temp_file_path)

  " Execute the temporary file with Python
  exe "r!python3 " . shellescape(temp_file_path)

  " Optionally, delete the temporary file after execution
  call delete(temp_file_path)

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

"ls -l /Users/ckw/.vim/vim-colorschemes/colors
":::::::::::::::::::::::::Theme Rotating:::::::::::::::::::::::::::::::::::::::
let themeindex = 0
let c_schemes = ["inkpot",
     \ "deus",
     \ "cobalt",
     \ "Dev_Delight",
     \ "borland",
     \ "asu1dark",
     \ "breeze",
     \ ]

     "\ "0x7A69_dark",

function! RotateColorTheme()
  let g:themeindex = (g:themeindex + 1) % len(g:c_schemes)
  let newtheme = g:c_schemes[g:themeindex]
  execute ":colorscheme ".newtheme
  hi CursorLine term=none cterm=none ctermbg=17
  echom g:colors_name
endfunction

let cthemeindex = 0
function! RotateCursorTheme()
  let g:cthemeindex = (g:cthemeindex + 1) % 80
  let l:com = 'hi CursorLine term=none cterm=none ctermbg=' . g:cthemeindex
  exec l:com
  echom g:cthemeindex
endfunction

"::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

"      \ "slate",
"      \ "ron",
"      \ "blue",
"      \ "elflord",
"      \ "evening",
"      \ "koehler",
"      \ "murphy",
"      \ "pablo",
"      \ "desert",
"      \ "torte",
"      \ "vibrantink",
"      \ "metacosm",
"      \ "jellybeans",
"      \ "wombat",
"      \ "zenburn",
"      \ "0x7A69_dark",
"      \ "1989",
"      \ "256-grayvim",
"      \ "256-jungle",
"      \ "256_noir",
"      \ "3dglasses",
"      \ "Atelier_CaveDark",
"      \ "Atelier_CaveLight",
"      \ "Atelier_DuneDark",
"      \ "Atelier_DuneLight",
"      \ "Atelier_EstuaryDark",
"      \ "Atelier_EstuaryLight",
"      \ "Atelier_ForestDark",
"      \ "Atelier_ForestLight",
"      \ "Atelier_HeathDark",
"      \ "Atelier_HeathLight",
"      \ "Atelier_LakesideDark",
"      \ "Atelier_LakesideLight",
"      \ "Atelier_PlateauDark",
"      \ "Atelier_PlateauLight",
"      \ "Atelier_SavannaDark",
"      \ "Atelier_SavannaLight",
"      \ "Atelier_SeasideDark",
"      \ "Atelier_SeasideLight",
"      \ "Atelier_SulphurpoolDark",
"      \ "Atelier_SulphurpoolLight",
"      \ "Benokai",
"      \ "Black",
"      \ "BlackSea",
"      \ "Blue2",
"      \ "C64",
"      \ "CandyPaper",
"      \ "Chasing_Logic",
"      \ "ChocolateLiquor",
"      \ "ChocolatePapaya",
"      \ "CodeFactoryv3",
"      \ "Dark",
"      \ "Dark2",
"      \ "DarkDefault",
"      \ "DevC++",
"      \ "Dev_Delight",
"      \ "Dim",
"      \ "Dim2",
"      \ "DimBlue",
"      \ "DimGreen",
"      \ "DimGreens",
"      \ "DimGrey",
"      \ "DimRed",
"      \ "DimSlate",
"      \ "Green",
"      \ "Light",
"      \ "LightDefault",
"      \ "LightDefaultGrey",
"      \ "LightTan",
"      \ "LightYellow",
"      \ "Monokai",
"      \ "MountainDew",
"      \ "OceanicNext",
"      \ "OceanicNextLight",
"      \ "PapayaWhip",
"      \ "PaperColor",
"      \ "PerfectDark",
"      \ "Red",
"      \ "Revolution",
"      \ "SerialExperimentsLain",
"      \ "Slate",
"      \ "SlateDark",
"      \ "Spink",
"      \ "SweetCandy",
"      \ "Tomorrow-Night-Blue",
"      \ "Tomorrow-Night-Bright",
"      \ "Tomorrow-Night-Eighties",
"      \ "Tomorrow-Night",
"      \ "Tomorrow",
"      \ "VIvid",
"      \ "White2",
"      \ "abbott",
"      \ "abra",
"      \ "abyss",
"      \ "adam",
"      \ "adaryn",
"      \ "adobe",
"      \ "adrian",
"      \ "advantage",
"      \ "adventurous",
"      \ "af",
"      \ "afterglow",
"      \ "aiseered",
"      \ "alduin",
"      \ "ancient",
"      \ "anderson",
"      \ "angr",
"      \ "anotherdark",
"      \ "ansi_blows",
"      \ "antares",
"      \ "apprentice",
"      \ "aqua",
"      \ "aquamarine",
"      \ "arcadia",
"      \ "archery",
"      \ "argonaut",
"      \ "ashen",
"      \ "asmanian2",
"      \ "asmanian_blood",
"      \ "asmdev",
"      \ "asmdev2",
"      \ "astronaut",
"      \ "asu1dark",
"      \ "atom",
"      \ "aurora",
"      \ "automation",
"      \ "autumn",
"      \ "autumnleaf",
"      \ "ayu",
"      \ "babymate256",
"      \ "badwolf",
"      \ "bandit",
"      \ "base",
"      \ "base16-ateliercave",
"      \ "base16-atelierdune",
"      \ "base16-atelierestuary",
"      \ "base16-atelierforest",
"      \ "base16-atelierheath",
"      \ "base16-atelierlakeside",
"      \ "base16-atelierplateau",
"      \ "base16-ateliersavanna",
"      \ "base16-atelierseaside",
"      \ "base16-ateliersulphurpool",
"      \ "base16-railscasts",
"      \ "basic-dark",
"      \ "basic-light",
"      \ "basic",
"      \ "bayQua",
"      \ "baycomb",
"      \ "bclear",
"      \ "beachcomber",
"      \ "beauty256",
"      \ "beekai",
"      \ "behelit",
"      \ "benlight",
"      \ "bensday",
"      \ "billw",
"      \ "biogoo",
"      \ "birds-of-paradise",
"      \ "bitterjug",
"      \ "black_angus",
"      \ "blackbeauty",
"      \ "blackboard",
"      \ "blackdust",
"      \ "blacklight",
"      \ "blaquemagick",
"      \ "blazer",
"      \ "blink",
"      \ "blue",
"      \ "bluechia",
"      \ "bluedrake",
"      \ "bluegreen",
"      \ "bluenes",
"      \ "blueprint",
"      \ "blues",
"      \ "blueshift",
"      \ "bluez",
"      \ "blugrine",
"      \ "bluish",
"      \ "bmichaelsen",
"      \ "boa",
"      \ "bocau",
"      \ "bog",
"      \ "boltzmann",
"      \ "borland",
"      \ "breeze",
"      \ "breezy",
"      \ "brighton",
"      \ "briofita",
"      \ "broduo",
"      \ "brogrammer",
"      \ "brookstream",
"      \ "brown",
"      \ "bubblegum-256-dark",
"      \ "bubblegum-256-light",
"      \ "bubblegum",
"      \ "buddy",
"      \ "burnttoast256",
"      \ "busierbee",
"      \ "busybee",
"      \ "buttercream",
"      \ "bvemu",
"      \ "bw",
"      \ "c",
"      \ "c16gui",
"      \ "cabin",
"      \ "cake",
"      \ "cake16",
"      \ "calmar256-dark",
"      \ "calmar256-light",
"      \ "camo",
"      \ "campfire",
"      \ "candy",
"      \ "candycode",
"      \ "candyman",
"      \ "caramel",
"      \ "carrot",
"      \ "carvedwood",
"      \ "carvedwoodcool",
"      \ "cascadia",
"      \ "celtics_away",
"      \ "cgpro",
"      \ "chalkboard",
"      \ "chance-of-storm",
"      \ "charged-256",
"      \ "charon",
"      \ "chela_light",
"      \ "cherryblossom",
"      \ "chlordane",
"      \ "chocolate",
"      \ "chroma",
"      \ "chrysoprase",
"      \ "clarity",
"      \ "cleanphp",
"      \ "cleanroom",
"      \ "clearance",
"      \ "cloudy",
"      \ "clue",
"      \ "cobalt",
"      \ "cobalt2",
"      \ "cobaltish",
"      \ "coda",
"      \ "codeblocks_dark",
"      \ "codeburn",
"      \ "codedark",
"      \ "codeschool",
"      \ "coffee",
"      \ "coldgreen",
"      \ "colorer",
"      \ "colorful",
"      \ "colorful256",
"      \ "colorsbox-faff",
"      \ "colorsbox-greenish",
"      \ "colorsbox-material",
"      \ "colorsbox-stblue",
"      \ "colorsbox-stbright",
"      \ "colorsbox-steighties",
"      \ "colorsbox-stnight",
"      \ "colorzone",
"      \ "contrastneed",
"      \ "contrasty",
"      \ "cool",
"      \ "corn",
"      \ "corporation",
"      \ "crayon",
"      \ "crt",
"      \ "crunchbang",
"      \ "cthulhian",
"      \ "custom",
"      \ "cyberpunk",
"      \ "d8g_01",
"      \ "d8g_02",
"      \ "d8g_03",
"      \ "d8g_04",
"      \ "dante",
"      \ "dark-ruby",
"      \ "darkZ",
"      \ "darkblack",
"      \ "darkblue",
"      \ "darkblue2",
"      \ "darkbone",
"      \ "darkburn",
"      \ "darkdevel",
"      \ "darkdot",
"      \ "darkeclipse",
"      \ "darker-robin",
"      \ "darkerdesert",
"      \ "darkglass",
"      \ "darkocean",
"      \ "darkrobot",
"      \ "darkslategray",
"      \ "darkspectrum",
"      \ "darktango",
"      \ "darkzen",
"      \ "darth",
"      \ "dawn",
"      \ "deep-space",
"      \ "deepsea",
"      \ "default",
"      \ "delek",
"      \ "delphi",
"      \ "denim",
"      \ "derefined",
"      \ "desert",
"      \ "desert256",
"      \ "desert256v2",
"      \ "desertEx",
"      \ "desertedocean",
"      \ "desertedoceanburnt",
"      \ "desertink",
"      \ "despacio",
"      \ "detailed",
"      \ "deus",


" unchecked
"      \ "devbox-dark-256",
"      \ "deveiate",
"      \ "developer",
"      \ "diokai",
"      \ "disciple",
"      \ "distill",
"      \ "distinguished",
"      \ "django",
"      \ "donbass",
"      \ "donttouchme",
"      \ "doorhinge",
"      \ "doriath",
"      \ "dracula",
"      \ "dual",
"      \ "dull",
"      \ "duotone-dark",
"      \ "duotone-darkcave",
"      \ "duotone-darkdesert",
"      \ "duotone-darkearth",
"      \ "duotone-darkforest",
"      \ "duotone-darkheath",
"      \ "duotone-darklake",
"      \ "duotone-darkmeadow",
"      \ "duotone-darkpark",
"      \ "duotone-darkpool",
"      \ "duotone-darksea",
"      \ "duotone-darkspace",
"      \ "dusk",
"      \ "dw_blue",
"      \ "dw_cyan",
"      \ "dw_green",
"      \ "dw_orange",
"      \ "dw_purple",
"      \ "dw_red",
"      \ "dw_yellow",
"      \ "dzo",
"      \ "earendel",
"      \ "earth",
"      \ "earthburn",
"      \ "eclipse",
"      \ "eclm_wombat",
"      \ "ecostation",
"      \ "editplus",
"      \ "edo_sea",
"      \ "ego",
"      \ "eink",
"      \ "ekinivim",
"      \ "ekvoli",
"      \ "elda",
"      \ "eldar",
"      \ "elflord",
"      \ "elise",
"      \ "elisex",
"      \ "elrodeo",
"      \ "elrond",
"      \ "emacs",
"      \ "enigma",
"      \ "enzyme",
"      \ "erez",
"      \ "eva",
"      \ "eva01-LCL",
"      \ "eva01",
"      \ "evening",
"      \ "evening1",
"      \ "evokai",
"      \ "evolution",
"      \ "fahrenheit",
"      \ "fairyfloss",
"      \ "falcon",
"      \ "far",
"      \ "felipec",
"      \ "feral",
"      \ "fight-in-the-shade",
"      \ "fine_blue",
"      \ "firewatch",
"      \ "flatcolor",
"      \ "flatland",
"      \ "flatlandia",
"      \ "flattened_dark",
"      \ "flattened_light",
"      \ "flattown",
"      \ "flattr",
"      \ "flatui",
"      \ "fnaqevan",
"      \ "fog",
"      \ "fokus",
"      \ "forneus",
"      \ "foursee",
"      \ "freya",
"      \ "frood",
"      \ "frozen",
"      \ "fruidle",
"      \ "fruit",
"      \ "fruity",
"      \ "fu",
"      \ "fx",
"      \ "garden",
"      \ "gardener",
"      \ "gemcolors",
"      \ "genericdc-light",
"      \ "genericdc",
"      \ "gentooish",
"      \ "getafe",
"      \ "getfresh",
"      \ "ghostbuster",
"      \ "github",
"      \ "gobo",
"      \ "golded",
"      \ "golden",
"      \ "goldenrod",
"      \ "goodwolf",
"      \ "google",
"      \ "gor",
"      \ "gotham",
"      \ "gotham256",
"      \ "gothic",
"      \ "grape",
"      \ "gravity",
"      \ "grayorange",
"      \ "graywh",
"      \ "grb256",
"      \ "greens",
"      \ "greenvision",
"      \ "greenwint",
"      \ "grey2",
"      \ "greyblue",
"      \ "greygull",
"      \ "grishin",
"      \ "gruvbox",
"      \ "gryffin",
"      \ "guardian",
"      \ "guepardo",
"      \ "h80",
"      \ "habiLight",
"      \ "happy_hacking",
"      \ "harlequin",
"      \ "heliotrope",
"      \ "hemisu",
"      \ "herald",
"      \ "heroku-terminal",
"      \ "heroku",
"      \ "herokudoc-gvim",
"      \ "herokudoc",
"      \ "hhazure",
"      \ "hhdblue",
"      \ "hhdcyan",
"      \ "hhdgray",
"      \ "hhdgreen",
"      \ "hhdmagenta",
"      \ "hhdred",
"      \ "hhdyellow",
"      \ "hhorange",
"      \ "hhpink",
"      \ "hhspring",
"      \ "hhteal",
"      \ "hhviolet",
"      \ "highlighter_term",
"      \ "highlighter_term_bright",
"      \ "highwayman",
"      \ "hilal",
"      \ "holokai",
"      \ "hornet",
"      \ "horseradish256",
"      \ "hotpot",
"      \ "hual",
"      \ "hybrid-light",
"      \ "hybrid",
"      \ "hybrid_material",
"      \ "hybrid_reverse",
"      \ "hydrangea",
"      \ "iangenzo",
"      \ "ibmedit",
"      \ "icansee",
"      \ "iceberg",
"      \ "immortals",
"      \ "impact",
"      \ "impactG",
"      \ "impactjs",
"      \ "industrial",
"      \ "industry",
"      \ "ingretu",
"      \ "inkpot",
"      \ "inori",
"      \ "ir_black",
"      \ "ironman",
"      \ "itg_flat",
"      \ "itg_flat_transparent",
"      \ "itsasoa",
"      \ "jaime",
"      \ "jammy",
"      \ "janah",
"      \ "japanesque",
"      \ "jelleybeans",
"      \ "jellybeans",
"      \ "jellygrass",
"      \ "jellyx",
"      \ "jhdark",
"      \ "jhlight",
"      \ "jiks",
"      \ "jitterbug",
"      \ "kalahari",
"      \ "kalisi",
"      \ "kalt",
"      \ "kaltex",
"      \ "kate",
"      \ "kellys",
"      \ "khaki",
"      \ "kib_darktango",
"      \ "kib_plastic",
"      \ "kings-away",
"      \ "kiss",
"      \ "kkruby",
"      \ "koehler",
"      \ "kolor",
"      \ "kruby",
"      \ "kyle",
"      \ "laederon",
"      \ "lakers_away",
"      \ "landscape",
"      \ "lanox",
"      \ "lanzarotta",
"      \ "lapis256",
"      \ "last256",
"      \ "late_evening",
"      \ "lazarus",
"      \ "legiblelight",
"      \ "leglight2",
"      \ "leo",
"      \ "less",
"      \ "lettuce",
"      \ "leya",
"      \ "lightcolors",
"      \ "lightning",
"      \ "lilac",
"      \ "lilydjwg_dark",
"      \ "lilydjwg_green",
"      \ "lilypink",
"      \ "lingodirector",
"      \ "liquidcarbon",
"      \ "literal_tango",
"      \ "lizard",
"      \ "lizard256",
"      \ "lodestone",
"      \ "loogica",
"      \ "louver",
"      \ "lucid",
"      \ "lucius",
"      \ "luinnar",
"      \ "lumberjack",
"      \ "luna-term",
"      \ "luna",
"      \ "lxvc",
"      \ "lyla",
"      \ "mac_classic",
"      \ "macvim-light",
"      \ "made_of_code",
"      \ "madeofcode",
"      \ "magellan",
"      \ "magicwb",
"      \ "mango",
"      \ "manuscript",
"      \ "manxome",
"      \ "marklar",
"      \ "maroloccio",
"      \ "maroloccio2",
"      \ "maroloccio3",
"      \ "mars",
"      \ "martin_krischik",
"      \ "material-theme",
"      \ "material",
"      \ "materialbox",
"      \ "materialtheme",
"      \ "matrix",
"      \ "maui",
"      \ "mayansmoke",
"      \ "mdark",
"      \ "mellow",
"      \ "messy",
"      \ "meta5",
"      \ "metacosm",
"      \ "midnight",
"      \ "miko",
"      \ "minimal",
"      \ "minimalist",
"      \ "mint",
"      \ "mizore",
"      \ "mod8",
"      \ "mod_tcsoft",
"      \ "mohammad",
"      \ "mojave",
"      \ "molokai",
"      \ "molokai_dark",
"      \ "monoacc",
"      \ "monochrome",
"      \ "monokai-chris",
"      \ "monokai-phoenix",
"      \ "monokain",
"      \ "montz",
"      \ "moody",
"      \ "moonshine",
"      \ "moonshine_lowcontrast",
"      \ "moonshine_minimal",
"      \ "mophiaDark",
"      \ "mophiaSmoke",
"      \ "mopkai",
"      \ "more",
"      \ "moria",
"      \ "moriarty",
"      \ "morning",
"      \ "moss",
"      \ "motus",
"      \ "mourning",
"      \ "mrkn256",
"      \ "mrpink",
"      \ "mud",
"      \ "muon",
"      \ "murphy",
"      \ "mushroom",
"      \ "mustang",
"      \ "mythos",
"      \ "native",
"      \ "nature",
"      \ "navajo-night",
"      \ "navajo",
"      \ "nazca",
"      \ "nedit",
"      \ "nedit2",
"      \ "nefertiti",
"      \ "neodark",
"      \ "neon",
"      \ "neonwave",
"      \ "nerv-ous",
"      \ "nes",
"      \ "nets-away",
"      \ "neuromancer",
"      \ "neutron",
"      \ "neverland-darker",
"      \ "neverland",
"      \ "neverland2-darker",
"      \ "neverland2",
"      \ "neverness",
"      \ "nevfn",
"      \ "new-railscasts",
"      \ "newspaper",
"      \ "newsprint",
"      \ "nicotine",
"      \ "night",
"      \ "nightVision",
"      \ "night_vision",
"      \ "nightflight",
"      \ "nightflight2",
"      \ "nightshade",
"      \ "nightshade_print",
"      \ "nightshimmer",
"      \ "nightsky",
"      \ "nightwish",
"      \ "no_quarter",
"      \ "noclown",
"      \ "nocturne",
"      \ "nofrils-acme",
"      \ "nofrils-dark",
"      \ "nofrils-light",
"      \ "nofrils-sepia",
"      \ "nord",
"      \ "nordisk",
"      \ "northland",
"      \ "northpole",
"      \ "northsky",
"      \ "norwaytoday",
"      \ "nour",
"      \ "nuvola",
"      \ "obsidian",
"      \ "obsidian2",
"      \ "oceanblack",
"      \ "oceanblack256",
"      \ "oceandeep",
"      \ "oceanlight",
"      \ "off",
"      \ "olive",
"      \ "onedark",
"      \ "orange",
"      \ "osx_like",
"      \ "otaku",
"      \ "oxeded",
"      \ "pablo",
"      \ "pacific",
"      \ "paintbox",
"      \ "paramount",
"      \ "parsec",
"      \ "peachpuff",
"      \ "peaksea",
"      \ "pencil",
"      \ "penultimate",
"      \ "peppers",
"      \ "perfect",
"      \ "petrel",
"      \ "pf_earth",
"      \ "phd",
"      \ "phoenix",
"      \ "phphaxor",
"      \ "phpx",
"      \ "pink",
"      \ "pixelmuerto",
"      \ "plasticine",
"      \ "playroom",
"      \ "pleasant",
"      \ "potts",
"      \ "predawn",
"      \ "preto",
"      \ "pride",
"      \ "primaries",
"      \ "primary",
"      \ "print_bw",
"      \ "prmths",
"      \ "professional",
"      \ "proton",
"      \ "ps_color",
"      \ "pspad",
"      \ "pt_black",
"      \ "putty",
"      \ "pw",
"      \ "py-darcula",
"      \ "pyte",
"      \ "python",
"      \ "quagmire",
"      \ "quantum",
"      \ "radicalgoodspeed",
"      \ "raggi",
"      \ "railscasts",
"      \ "rainbow_autumn",
"      \ "rainbow_fine_blue",
"      \ "rainbow_fruit",
"      \ "rainbow_night",
"      \ "rainbow_sea",
"      \ "rakr-light",
"      \ "random",
"      \ "rastafari",
"      \ "rcg_gui",
"      \ "rcg_term",
"      \ "rdark-terminal",
"      \ "rdark",
"      \ "redblack",
"      \ "redstring",
"      \ "refactor",
"      \ "relaxedgreen",
"      \ "reliable",
"      \ "reloaded",
"      \ "revolutions",
"      \ "robinhood",
"      \ "rockets-away",
"      \ "ron",
"      \ "rootwater",
"      \ "sadek1",
"      \ "sand",
"      \ "sandydune",
"      \ "satori",
"      \ "saturn",
"      \ "scheakur",
"      \ "scite",
"      \ "scooby",
"      \ "seagull",
"      \ "sean",
"      \ "seashell",
"      \ "seattle",
"      \ "selenitic",
"      \ "seoul",
"      \ "seoul256-light",
"      \ "seoul256",
"      \ "seti",
"      \ "settlemyer",
"      \ "sexy-railscasts",
"      \ "sf",
"      \ "shades-of-teal",
"      \ "shadesofamber",
"      \ "shine",
"      \ "shiny-white",
"      \ "shobogenzo",
"      \ "sialoquent",
"      \ "sienna",
"      \ "sierra",
"      \ "sift",
"      \ "silent",
"      \ "simple256",
"      \ "simple_b",
"      \ "simple_dark",
"      \ "simpleandfriendly",
"      \ "simplewhite",
"      \ "simplon",
"      \ "skittles_autumn",
"      \ "skittles_berry",
"      \ "skittles_dark",
"      \ "sky",
"      \ "slate2",
"      \ "smarties",
"      \ "smp",
"      \ "smpl",
"      \ "smyck",
"      \ "soda",
"      \ "softblue",
"      \ "softbluev2",
"      \ "softlight",
"      \ "sol-term",
"      \ "sol",
"      \ "solarized",
"      \ "solarized8_dark",
"      \ "solarized8_dark_flat",
"      \ "solarized8_dark_high",
"      \ "solarized8_dark_low",
"      \ "solarized8_light",
"      \ "solarized8_light_flat",
"      \ "solarized8_light_high",
"      \ "solarized8_light_low",
"      \ "sole",
"      \ "sonofobsidian",
"      \ "sonoma",
"      \ "sorcerer",
"      \ "soruby",
"      \ "soso",
"      \ "sourcerer",
"      \ "southernlights",
"      \ "southwest-fog",
"      \ "space-vim-dark",
"      \ "spacegray",
"      \ "spacemacs-theme",
"      \ "spartan",
"      \ "spectro",
"      \ "spiderhawk",
"      \ "spring-night",
"      \ "spring",
"      \ "sprinkles",
"      \ "spurs_away",
"      \ "srcery-drk",
"      \ "srcery",
"      \ "stackoverflow",
"      \ "stefan",
"      \ "stereokai",
"      \ "stingray",
"      \ "stonewashed-256",
"      \ "stonewashed-dark-256",
"      \ "stonewashed-dark-gui",
"      \ "stonewashed-gui",
"      \ "stormpetrel",
"      \ "strange",
"      \ "strawimodo",
"      \ "summerfruit",
"      \ "summerfruit256",
"      \ "sunburst",
"      \ "surveyor",
"      \ "swamplight",
"      \ "sweater",
"      \ "symfony",
"      \ "synic",
"      \ "synthwave",
"      \ "tabula",
"      \ "tango-desert",
"      \ "tango-morning",
"      \ "tango",
"      \ "tango2",
"      \ "tangoX",
"      \ "tangoshady",
"      \ "taqua",
"      \ "tatami",
"      \ "tayra",
"      \ "tchaba",
"      \ "tchaba2",
"      \ "tcsoft",
"      \ "telstar",
"      \ "tender",
"      \ "termschool",
"      \ "tesla",
"      \ "tetragrammaton",
"      \ "textmate16",
"      \ "thegoodluck",
"      \ "thermopylae",
"      \ "thestars",
"      \ "thor",
"      \ "thornbird",
"      \ "tibet",
"      \ "tidy",
"      \ "tigrana-256-dark",
"      \ "tigrana-256-light",
"      \ "tir_black",
"      \ "tolerable",
"      \ "tomatosoup",
"      \ "tony_light",
"      \ "toothpik",
"      \ "torte",
"      \ "transparent",
"      \ "triplejelly",
"      \ "trivial256",
"      \ "trogdor",
"      \ "tropikos",
"      \ "true-monochrome",
"      \ "turbo",
"      \ "turtles",
"      \ "tutticolori",
"      \ "twilight",
"      \ "twilight256",
"      \ "twitchy",
"      \ "two-firewatch",
"      \ "two2tango",
"      \ "ubaryd",
"      \ "ubloh",
"      \ "umber-green",
"      \ "understated",
"      \ "underwater-mod",
"      \ "underwater",
"      \ "unicon",
"      \ "up",
"      \ "valloric",
"      \ "vanzan_color",
"      \ "vc",
"      \ "vcbc",
"      \ "vertLaiton",
"      \ "vexorian",
"      \ "vibrantink",
"      \ "vice",
"      \ "vilight",
"      \ "vim-material",
"      \ "vimbrains",
"      \ "vimbrant",
"      \ "vimicks",
"      \ "visualstudio",
"      \ "vividchalk",
"      \ "vj",
"      \ "void",
"      \ "vorange",
"      \ "vydark",
"      \ "vylight",
"      \ "wargrey",
"      \ "warm_grey",
"      \ "warriors-away",
"      \ "wasabi256",
"      \ "watermark",
"      \ "wellsokai",
"      \ "welpe",
"      \ "white",
"      \ "whitebox",
"      \ "whitedust",
"      \ "widower",
"      \ "wikipedia",
"      \ "win9xblueback",
"      \ "winter",
"      \ "winterd",
"      \ "wintersday",
"      \ "woju",
"      \ "wolfpack",
"      \ "wombat",
"      \ "wombat256",
"      \ "wombat256dave",
"      \ "wombat256i",
"      \ "wombat256mod",
"      \ "wood",
"      \ "wuye",
"      \ "wwdc16",
"      \ "wwdc17",
"      \ "xcode-default",
"      \ "xcode",
"      \ "xedit",
"      \ "xemacs",
"      \ "xian",
"      \ "xmaslights",
"      \ "xoria256",
"      \ "xterm16",
"      \ "yeller",
"      \ "yuejiu",
"      \ "zazen",
"      \ "zellner",
"      \ "zen",
"      \ "zenburn",
"      \ "zenesque",
"      \ "zephyr",
"      \ "zmrok",
"      \ "znake",
"      \ ]

