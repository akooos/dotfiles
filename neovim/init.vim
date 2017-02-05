"let NVIM_TUI_ENABLE_TRUE_COLOR=1
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
set noswapfile
"set filetype indent on
set autoindent
set showbreak=⌁⌁⌁
set listchars=eol:⏎,tab:»·,trail:•,nbsp:≡
"set listchars="eol:⏎,tab:⇥,trail:•,nbsp:≡"
set list
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
"Numbering tabs at title bar"
function! MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction
"Open files always in tabs
"autocmd VimEnter * tab all
"autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'
"set foldmethod=syntax
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
" I use vim-plug as a plugin manager
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" deoplete config
let g:deoplete#enable_at_startup = 1
" disable autocomplete
let g:deoplete#disable_auto_complete = 1
if has("gui_running")
    inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
else
    inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
endif
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"For JS development
Plug 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_jsxhint_exec = 'eslint'
"Plug 'pangloss/vim-javascript'
"Plug 'pangloss/vim-javascript'
"Plug 'jelera/vim-javascript-syntax'
"Plug 'othree/yajs'
"Plug 'othree/es.next.syntax.vim'
"Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Valloric/YouCompleteMe'
Plug 'lervag/vimtex'
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview
Plug 'marijnh/tern_for_vim'
"Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

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
"Plug 'tpope/vim-dispatch'
"Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-eunuch'
"Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-markdown'
"Plug 'tpope/vim-projectionist'
"Plug 'tpope/vim-ragtag'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-sensible'
"Plug 'tpope/vim-sexp-mappings-for-regular-people'
"Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-unimpaired'
"Plug 'tpope/vim-vinegar'
"Plug 'Shutnik/jshint2.vim'
Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/Vimchant'
Plug 'tpope/vim-obsession'
Plug '907th/vim-auto-save'
call plug#end()
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
colorscheme molokai 
let g:airline_theme= 'molokai'
let jshint2_save = 1
let jshint2_read = 1
let g:jsx_ext_required = 0
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
let g:tex_flavor='latex'
let g:vimchant_spellcheck_lang = 'hu'
let g:auto_save_events = ["InsertLeave", "TextChanged"]
set tabline=%!MyTabLine()  " custom tab pages line

autocmd BufRead,BufNewFile *.css,*.qss,*.html ColorHighlight
autocmd BufRead,BufNewFile .babelrc,.eslintrc,.jshintrc set filetype=json
" by default, the indent is 2 spaces. 
set shiftwidth=2
set softtabstop=2
set tabstop=2

" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" for js/coffee/jade files, 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab
