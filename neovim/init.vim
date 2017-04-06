" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
"átlátszóság miatt kikommenteltem
"if (has("termguicolors"))
" set termguicolors
"endif
syntax on
set modeline
set nu 
set rnu 
set ruler 
set colorcolumn=80
set textwidth=0
set wrapmargin=0 
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nohlsearch
set smartindent
filetype indent on
set undodir=~/.config/nvim/undodir
set undofile
set undolevels=10000
set undoreload=100000
set background=dark
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
set dir=~/tmp
"set filetype indent on
set autoindent
set visualbell
set showbreak=⌁⌁⌁
set listchars=eol:⏎,tab:»·,trail:•,nbsp:≡
"set listchars="eol:⏎,tab:⇥,trail:•,nbsp:≡"
set list
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=utf-8,latin2
endif"
"set t_Co=256
"Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10gt
"Open files always in tabs
" autocmd VimEnter * tab all
" autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'
set foldmethod=syntax
set foldlevel=4
set clipboard=unnamedplus
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

"autocomplition, snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
" Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
"For JS development
Plug 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_jsxhint_exec = 'eslint'
Plug 'pangloss/vim-javascript'
"Plug 'jelera/vim-javascript-syntax'
"Plug 'othree/yajs'
"Plug 'othree/es.next.syntax.vim'
Plug 'mxw/vim-jsx'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'Valloric/YouCompleteMe'
"Plug 'lervag/vimtex'
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview
"Tern analysis for javascript
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
"Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"SQL kiegészítés
Plug 'vim-scripts/dbext.vim'
"Plug 'skammer/vim-css-color'
"Plug 'ap/vim-css-color'
"Plug 'chrisbra/Colorizer'
Plug 'chauncey-garrett/vim-colorizer'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Add plugins to &runtimepath

"Plug 'FelikZ/ctrlp-py-matcher'
"Plug 'Keithbsmiley/tmux.vim'
"Plug 'Lokaltog/vim-distinguished'
Plug 'Lokaltog/vim-easymotion'
"Plug 'PeterRincker/vim-argumentative'
"Plug 'Raimondi/delimitMate'
"Plug 'Wolfy87/vim-enmasse'
"Plug 'Wolfy87/vim-expand'
"Plug 'Wolfy87/vim-syntax-expand'
"Plug 'adimit/prolog.vim'
"Plug 'aklt/plantuml-syntax'
"Plug 'andreimaxim/vim-io'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'derekwyatt/vim-scala'
"Plug 'embear/vim-localvimrc'
"Plug 'guns/vim-clojure-highlight'
"Plug 'guns/vim-clojure-static'
"Plug 'guns/vim-sexp'
"Plug 'haya14busa/incsearch.vim'
"Plug 'haya14busa/vim-asterisk'
"Plug 'helino/vim-json'
"Plug 'junegunn/vim-easy-align'
"Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
"Plug 'mhinz/vim-signify'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'pangloss/vim-javascript'
"Plug 'raymond-w-ko/vim-niji'
"Plug 'rking/ag.vim'
"Plug 'scrooloose/syntastic'
"Plug 'sevko/vim-nand2tetris-syntax'
"Plug 'sjl/gundo.vim'
"Plug 'terryma/vim-multiple-cursors'
"Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
"asyncron futtatás 
Plug 'skywind3000/asyncrun.vim'
"Plug 'tpope/vim-dispatch'
Plug 'vim-scripts/errormarker.vim'
"Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-eunuch'
"Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
"legyenek oldal sávban +-~kijelzések
Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/taglist.vim'
"Plug 'tpope/vim-projectionist'
"xml-html bilélenytűzet mapping snippetek
"Plug 'tpope/vim-ragtag'
"vim-surround -ot tudjam ismételni
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-sensible'
"Plug 'tpope/vim-sexp-mappings-for-regular-people'
"Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
"navigálásban segít
Plug 'tpope/vim-unimpaired'
"beépített projekt(netrw) nézegetpt egészíti ki
"Plug 'tpope/vim-vinegar'
"Plug 'Shutnik/jshint2.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'flazz/vim-colorschemes'
""Plug 'vim-scripts/Vimchant'
"session management automatikusan
Plug 'tpope/vim-obsession'
Plug '907th/vim-auto-save'
Plug 'jparise/vim-graphql'
Plug 'felixge/vim-nodejs-errorformat'
"vim test plugin for mocha etc...
Plug 'janko-m/vim-test'
Plug 'vim-scripts/plantuml-syntax'
call plug#end()
let g:auto_save = 0  " enable AutoSave on Vim startup
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#right_sep = ' '
" let g:airline#extensions#tabline#right_alt_sep = '|'
" let g:airline_left_sep = ' '
" let g:airline_left_alt_sep = '|'
" let g:airline_right_sep = ' '
" let g:airline_right_alt_sep = '|'
colorscheme monokai-phoenix
let g:airline_theme= 'wombat'
let jshint2_save = 1
let jshint2_read = 1
let g:jsx_ext_required = 1
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
let g:tex_flavor='latex'
let g:vimchant_spellcheck_lang = 'hu'
let g:auto_save_events = ["InsertLeave", "TextChanged"]

autocmd BufRead,BufNewFile *.css,*.qss,*.html ColorHighlight
autocmd BufRead,BufNewFile .babelrc,.eslintrc,.jshintrc set filetype=json
" by default, the indent is 2 spaces. 
set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd BufRead,BufNewFile *.plantuml set filetype=plantuml
" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" for js/coffee/jade files, 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab
hi NonText ctermfg=7 guifg=white
" Path to store the cscope files (cscope.files and cscope.out)
" Defaults to '~/.cscope'
let g:cscope_dir = '~/.cscope'

" Map the default keys on startup
" These keys are prefixed by CTRL+\ <cscope param>
" A.e.: CTRL+\ d for goto definition of word under cursor
" Defaults to off
let g:cscope_map_keys = 1

" Update the cscope files on startup of cscope.
" Defaults to off
let g:cscope_update_on_start = 1
set cscopetag

".vimrc
"map <c-f> :call JsBeautify()<cr>
"" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" " for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" " for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" " for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
" delete multiple same line :%s/^\(.*\)\(\n\1\)\+$/\1/gec
"
"show numbers
autocmd FocusLost * :set number
autocmd FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let wn = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let wn = tabpagewinnr(i,'$')

      let s .= '%#TabNum#'
      let s .= i
      " let s .= '%*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        let file = '[No Name]'
      endif
      let s .= ' ' . file . ' '
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
  set showtabline=1
  highlight link TabNum Special
endif

"Running scripts save before run
command! SaveAndNode execute "w | !node %"
command! SaveAndTestFile execute "w | copen | wincmd p | TestFile | set filetype=javascript"
command! SaveAndTestNearest execute "w | copen | wincmd p | TestNearest | set filetype=javascript"
map <F2> :SaveAndNode<CR>
map <F5> :SaveAndTestFile<CR>
map <F6> :SaveAndTestNearest<CR>

"vim-test plugin shortcuts
" make test commands execute using dispatch.vim
let test#strategy = "asyncrun"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
"asyncrun settings, make it compatible with vim-fugitive and airline
" if exists(':Make') == 2
"   noautocmd Make
" else
"   silent noautocmd make!
"   redraw!
"   return 'call fugitive#cwindow()'
" endif
let g:asyncrun_auto = "make"
let g:asyncrun_exit = "silent !mpv ~/.config/nvim/test_end.oga &> /dev/null & disown"
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" for tern autocompletion omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
"let errormarker_disablemappings = 1
let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat 
"0x0001F41E
let errormarker_errortext = "⚡"
let errormarker_warningtext = "⚠"
let errormarker_erroricon = "/home/cauchy/.config/nvim/tools-report-bug.ico"
let errormarker_warningicon = "/home/cauchy/.config/nvim/dialog-warning.ico"
let test#javascript#mocha#options = '-R mocha-vim-reporter --compilers js:babel-core/register --bail'
"still no compile flags hibaüzenet miatt
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let mapleader="-"
