runtime! debian.vim
set nocompatible

if has("syntax")
  syntax on
endif

set encoding=utf-8
let g:ale_linters = {
  \  'haskell': ['stack build --fast -j2 --ghc-options -j4 --flag ExaTMS:dev', 'hlint'],
  \}

  " \  'sql': []
  "\  'haskell': ['hie-wrapper']
" , ]

let g:airline_theme='powerlineish'
"let g:airline_powerline_fonts = 1

"let g:EasyMotion_leader_key = '<Leader>_'
"let g:EasyMotion_keys = 'asdfjkl;eirughwptyo'
let g:EasyMotion_keys = 'asdferwqcgtvxz'
let g:leader_prime = 's'

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie-wrapper', '--lsp'],
    \ }

hi link ALEError Error
hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
hi link ALEWarning Warning
hi link ALEInfo SpellCap

    " \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    " \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    " \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    " \ 'python': ['/usr/local/bin/pyls'],

"map <Leader>dt :SyntasticToggleMode<CR>

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_aggregate_errors = 1


"let g:tsuquyomi_disable_default_mappings = 1
"let g:tsuquyomi_disable_quickfix = 1
"let g:syntastic_typescript_checkers = ['tsuquyomi']

"call pathogen#infect()

call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug '~/.vim/bundle/LustyJuggler'
Plug 'w0rp/ale'
Plug 'Shougo/vimproc'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Valloric/YouCompleteMe/'

"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }


call plug#end()

"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"

let g:LustyJugglerDefaultMappings = 0

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
    autocmd BufWinEnter quickfix nnoremap <buffer> <cr> :.cc<cr>:wincmd p<cr>
    autocmd BufNewFile,BufRead *.json :set ft=json
    autocmd BufNewFile,BufRead *.php :set ft=php
    autocmd BufNewFile,BufRead *.hs :set ft=haskell
    autocmd BufNewFile,BufRead *.rb :set ft=ruby
    autocmd BufNewFile,BufRead *.js :set ft=javascript
    autocmd BufNewFile,BufRead *.rs :set ft=rust
    autocmd BufNewFile,BufRead *.vimrc :set ft=vim
    autocmd BufNewFile,BufRead *.scala :set ft=scala
    autocmd BufNewFile,BufRead *.elm :set ft=elm
    autocmd BufNewFile,BufRead *.ts :set ft=typescript


    " Enable neocomplcache omni completion.
    "autocmd FileType php setlocal noexpandtab
    "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    "autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "autocmd FileType typescript setlocal omnifunc=typescriptcomplete#Complete

    " Ruby is an oddball in the family, use special spacing/rules
    if v:version >= 703
      " Note: Relative number is quite slow with Ruby, so is cursorline
      autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline
    else
      autocmd FileType ruby setlocal ts=2 sts=2 sw=2
    endif

    "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


    "autocmd FileType elm setglobal syntastic_always_populate_loc_list=1
    "autocmd FileType elm setglobal syntastic_auto_loc_list=1
    "autocmd FileType elm setglobal elm_syntastic_show_warnings=1

  augroup END

"  augroup tags
"  au BufWritePost *.hs            silent !init-tags %
"  au BufWritePost *.hsc           silent !init-tags %
"  augroup END
endif

":::::::::::::::::::::::::::::::::settings::::::::::::::::::::::::::::::::::::
"

if(&ft == 'elm')
  call ElmSettings()
endif

set clipboard="
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
set colorcolumn=120
set undofile
set lazyredraw
set noswapfile
set timeoutlen=500

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

"noremap <C-h> <C-w>h
"noremap <C-l> <C-w>l
onoremap <C-l> $
onoremap <C-h> 0
noremap <C-l> $
noremap <C-h> 0

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

"open scratch buffer => sd
exe "nnoremap " . g:leader_prime . "d :Scratch\<CR>"

"print to error log the contents of the variable under the cursor (php)
exe "nnoremap " . g:leader_prime . "l :norm oerror_log('__________________:' . print_r($" . '<C-r>=expand("<cword>")<CR>,true));<CR>'

"execute the contents of the current line => sx
exe "nnoremap " . g:leader_prime . "x :call ExecuteCurrentLine()\<CR>"

exe "nnoremap " . g:leader_prime . "p :call ExecuteCurrentParagraph()\<CR>"

exe "nnoremap " . g:leader_prime . "c :call ExecuteCurrentLineWithBC()\<CR>"

exe "nnoremap " . g:leader_prime . 's :Files<CR>'

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
nnoremap <leader>r "_d
nnoremap <leader>n q:inorm<space>
nnoremap <leader>p zfip
nnoremap <leader>u za

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nnoremap <leader>z :%s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <leader>; ,
nnoremap <silent> <leader>t :call RotateColorTheme()<CR>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>a :Rg <C-r>=expand("<cword>")<CR><CR>
nnoremap <leader>f :call LanguageClient#textDocument_definition()<CR>

nmap <silent> <Leader><Leader> :LustyJuggler<CR>

""""""""""""""""""""""unicode character mappings"""""""""""""""""""""""""""""
nnoremap <leader>u :call Unicodify()<CR>
nnoremap <leader>du :call DeUnicodify()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>b @@
nnoremap <CR> @:
nnoremap <C-b> <esc>:buffers<cr>
nnoremap n nzz
nnoremap N Nzz

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

nnoremap <C-j> 15gj
nnoremap <C-k> 15gk

onoremap <C-j> 15gj
onoremap <C-k> 15gk

vnoremap j gj
vnoremap k gk
vnoremap <C-j> 15gj
vnoremap <C-k> 15gk

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
"
"":::::::::::::::::::::::::CTRLP::::::::::::::::::::::::::::::::::::::::::::::::
""Use this option to change the mapping to invoke CtrlP in |Normal| mode: >
"let g:ctrlp_map = g:leader_prime . 's'
"
""Set the default opening command to use when pressing the above mapping: >
"let g:ctrlp_cmd = 'CtrlPMixed'
"
""Set the maximum height of the match window: >
"let g:ctrlp_max_height = 20
"
""When opening a file with <cr> or <c-t>, if the file's already opened somewhere
""CtrlP will try to jump to it instead of opening a new instance: >
"let g:ctrlp_switch_buffer = 1
"
""When starting up, CtrlP sets its local working directory according to this
""variable: >
"let g:ctrlp_working_path_mode = 'rc'
"
"
"let g:ctrlp_root_markers = ['.cabal', 'Gemfile', '.git']
"
""Set this to 0 to enable cross-session caching by not deleting the cache files
""upon exiting Vim: >
"let g:ctrlp_clear_cache_on_exit = 0
"
""Set the directory to store the cache files: >
"let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
"
""The maximum number of files to scan, set to 0 for no limit: >
"let g:ctrlp_max_files = 100000
"
""The maximum depth of a directory tree to recurse into: >
"let g:ctrlp_max_depth = 40
"
""Use this option to specify how the newly created file is to be opened when
""pressing <c-y>:
""  t - in a new tab
""  h - in a new horizontal split
""  v - in a new vertical split
""  r - in the current window
"let g:ctrlp_open_new_file = 'r'
"
"let g:ctrlp_open_multiple_files = 'ri'
"
""If non-zero, CtrlP will follow symbolic links when listing files: >
"let g:ctrlp_follow_symlinks = 0
"
"
"
"let g:ctrlp_prompt_mappings = {
"      \ 'PrtBS()':              ['<bs>', '<c-]>'],
"      \ 'PrtDelete()':          ['<del>'],
"      \ 'PrtDeleteWord()':      ['<c-w>'],
"      \ 'PrtClear()':           ['<c-u>'],
"      \ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
"      \ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
"      \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
"      \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
"      \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
"      \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
"      \ 'PrtHistory(-1)':       ['<c-n>'],
"      \ 'PrtHistory(1)':        ['<c-p>'],
"      \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
"      \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
"      \ 'AcceptSelection("t")': ['<c-t>'],
"      \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
"      \ 'ToggleFocus()':        ['<c-j><k>'],
"      \ 'ToggleRegex()':        ['<c-r>'],
"      \ 'ToggleByFname()':      ['<c-d>'],
"      \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
"      \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
"      \ 'PrtExpandDir()':       ['<tab>'],
"      \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
"      \ 'PrtInsert()':          ['<c-\>'],
"      \ 'PrtCurStart()':        ['<c-a>'],
"      \ 'PrtCurEnd()':          ['<c-e>'],
"      \ 'PrtCurLeft()':         ['<c-h>', '<left>', '<c-^>'],
"      \ 'PrtCurRight()':        ['<c-l>', '<right>'],
"      \ 'PrtClearCache()':      ['<F5>'],
"      \ 'PrtDeleteEnt()':       ['<F7>'],
"      \ 'CreateNewFile()':      ['<c-y>'],
"      \ 'MarkToOpen()':         ['<c-o>'],
"      \ 'OpenMulti()':          ['<c-u>'],
"      \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
"      \ }
"":::::::::::::::::::::::::CTRLP::::::::::::::::::::::::::::::::::::::::::::::::
"
":::::::::::::::::::::::::NEOCOMPL:::::::::::::::::::::::::::::::::::::::::::::
"let g:neocomplcache_enable_at_startup = 1
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
"" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
"" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1
"" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
"" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
"      \ 'default' : '',
"      \ 'vimshell' : $HOME.'/.vimshell_hist',
"      \ 'scheme' : $HOME.'/.gosh_completions'
"      \ }
"
"" Define keyword.
"if !exists('g:neocomplcache_keyword_patterns')
"  let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"
"" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^.  *\t]\.\w*\|\h\w*::'
""autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"let g:neocomplcache_omni_patterns.php = '[^.  \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"

":::::::::::::::::::::::::NEOCOMPL:::::::::::::::::::::::::::::::::::::::::::::
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
  exe '.s/\/=/≠/e'
endfunction

function! DeUnicodify()
  exe '.s/←/<-/e'
  exe '.s/∷/::/e'
  exe '.s/ → / -> /e'
  exe '.s/ ∘ / \. /e'
  exe '.s/∀/forall/e'
  exe '.s/ ⇒ / => /e'
  exe '.s/≠/\/=/e'
endfunction

function! ExecuteCurrentLine()
  let l:com = substitute(getline('.'), '\#', '\\#', 'g')
  let l:com_ = substitute(l:com, '\!', '\\!', 'g')
  exe "norm! o\<Esc>"
  exe "r! " . l:com_
  exe "norm! o\<Esc>"
endfunction

function! ElmSettings()
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:elm_syntastic_show_warnings = 1
    let g:elm_jump_to_error = 0

    let g:elm_make_output_file = "elm.js"
    let g:elm_make_show_warnings = 0
    let g:elm_syntastic_show_warnings = 0
    let g:elm_browser_command = ""
    let g:elm_detailed_complete = 0
    let g:elm_format_autosave = 0
    let g:elm_format_fail_silently = 0
    let g:elm_setup_keybindings = 0
endfunction

function! ExecuteCurrentParagraph()
  let l:init = line('.')
  exe "norm! {j"
  let l:start = line('.')
  exe "norm! }"
  let l:end = line('.')

"  if l:end == l:init && l:start == l:init
"    exe 'norm! ' . l:init . 'gg'
"    call ExecuteCurrentLine()
"    return
"  endif

  exe "norm! o\<Esc>"
  exe "r! " . join(getline(l:start,l:end), ' ')
  exe "norm! o\<Esc>"
endfunction

function! ExecuteCurrentLineWithBC()
  let l:com = getline('.')
  exe "norm! o\<Esc>"
  exe "r! " . "echo 'scale=6;" . l:com . "' | bc"
  exe "norm! o\<Esc>"
endfunction

function! RipgrepSearch()
  let l:term = expand("<cword>")
  "let l:dir = system("git rev-parse --show-toplevel")
  exe "norm! :Rg " . l:term . "\<Esc>"
endfunction

":::::::::::::::::::::::::EasyMotion:::::::::::::::::::::::::::::::::::::::::::
let g:EasyMotion_do_mapping = 0 " Disable default mappings

"Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key
"binding.
nmap f <Plug>(easymotion-s)

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


function! ClearUndo()
  let old_undolevels = &undolevels
  set undolevels=-1
  exe "normal a \<BS>\<Esc>"
  let &undolevels = old_undolevels
  unlet old_undolevels
endfunction

function! RotateColorTheme()
  let g:themeindex = (g:themeindex + 1) % len(g:c_schemes)
  let newtheme = g:c_schemes[g:themeindex]
  execute ":colorscheme ".newtheme
  hi CursorLine term=none cterm=none ctermbg=4
endfunction
"::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
