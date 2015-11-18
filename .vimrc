set nocompatible
" Vundle
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle
    let iCanHazVundle=0
endif

" required for Vundle
filetype off

set rtp+=~/.vim/bundle/Vundle/
call vundle#rc()


" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------
" Required for vundle
Bundle 'gmarik/vundle'

" Elegant buffer explorer - takes very little screen space
Bundle 'fholgado/minibufexpl.vim'

" File browser
Bundle 'scrooloose/nerdtree'

" Code commenter
Bundle 'scrooloose/nerdcommenter'

" Python and other languages code checker
Bundle 'scrooloose/syntastic'

" Class/module browser
Bundle 'majutsushi/tagbar'

" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'

" Tab list panel
Bundle 'kien/tabman.vim'

" Airline
Bundle 'bling/vim-airline'

" Autoclose
Bundle 'Townk/vim-autoclose'

" Indent text object
Bundle 'michaeljsmith/vim-indent-object'

" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
Bundle 'klen/python-mode'

" Better autocompletion
Bundle 'Shougo/neocomplcache.vim'

" Useful python snippets
Bundle 'honza/vim-snippets'

" Git/mercurial/others diff icons on the side of the file lines
Bundle 'mhinz/vim-signify'

" Window chooser
Bundle 't9md/vim-choosewin'

" Paint css colors with the real color
Bundle 'lilydjwg/colorizer'

" Search results counter
Bundle 'IndexedSearch'

" XML/HTML tags navigation
Bundle 'matchit.zip'

" Yank history navigation
" Bundle 'YankRing.vim'

" Collection of colours
Bundle 'flazz/vim-colorschemes'

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" -----------------------------------------------------------------------------
"  Detect OS to make things nicer
" -----------------------------------------------------------------------------
if has("unix")
  " 'Darwin' or 'Linux'.
  let s:uname = system("echo -n \"$(uname -s)\"")
  let $PLATFORM = tolower(s:uname)
else
  let s:uname = ""
end

" Set the font, colour scheme, etc. appropriately.
if has("gui_running")
  colors desert
  if has("gui_gtk2")
    set guifont=Monospace\ 10
  elseif has("gui_win32")
    set guifont=Consolas:h10:cANSI
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h11
  endif
endif

" On Mac OS X, "set lines" causes the terminal window to be resized; we don't want that.
if has("gui_running")
  " gui_running => not in a terminal => safe to resize.
  if &lines < 50
    set lines=50
  endif
  if &columns < 120
    set columns=120
  endif
endif

" In terminal mode, use a different coloured cursor for insert mode:
if s:uname != "Darwin" && &term =~ "xterm-256color" && !has("gui_running")
  " Use an orange cursor in insert mode.
  let &t_SI = "\<Esc>]12;orange\x7"
  " Use a white cursor otherwise, and set it initially.
  let &t_EI = "\<Esc>]12;white\x7"
  silent !echo -ne "\E]12;white\x7"
  " Reset it when exiting.
  autocmd VimLeave * silent !echo -ne "\E]12;white\x7"
end


" -----------------------------------------------------------------------------
" Plugins Configuration
" -----------------------------------------------------------------------------
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" check also when just opened the file
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
" Better :sign interface symbols
let g:syntastic_auto_jump=0
" " don't put icons on the sign column (it hides the vcs status icons of
" signify)
let g:syntastic_enable_signs = 0
let syntastic_python_flake8_args='--ignore=E501,E225,W293,E126,E127,E128'
let g:syntastic_python_checker_args='--ignore=E501,E225,W293,E126,E127,E128'


" Tagbar

" shortcuts
let g:tagbar_autofocus = 1

" CtrlP

" file finder mapping
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" don't change working directory
let g:ctrlp_working_path_mode = 0
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" check also when just opened the file
let g:syntastic_check_on_open = 1
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
" custom icons (enable them if you use a patched font, and enable the previous
" setting)
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" Python-mode

" don't use linter, we use syntastic for that
let g:pymode_lint_on_write = 0
let g:pymode_lint_signs = 0
" don't fold python code on open
let g:pymode_folding = 0
" don't load rope by default. Change to 1 to use rope
let g:pymode_rope = 0
" open definitions on same window, and custom mappings for definitions and
" occurrences
let g:pymode_rope_goto_definition_bind = '<C-b>'
let g:pymode_rope_goto_definition_cmd = 'new'


" NeoComplCache

" most of them not documented because I'm not sure how they work
" (docs aren't good, had to do a lot of trial and error to make
" it play nice)
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_manual_completion_start_length = 1
let g:neocomplcache_min_keyword_length = 1
let g:neocomplcache_min_syntax_length = 1

" complete with workds from any opened file
let g:neocomplcache_same_filetype_lists = {}
let g:neocomplcache_same_filetype_lists._ = '_'

" TabMan

" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" Autoclose

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Signify

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]

" colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227


" Airline
"
let g:airline_powerline_fonts = 1
let g:airline_theme = 'badwolf'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" -----------------------------------------------------------------------------
" GUI / Look & Feel
" -----------------------------------------------------------------------------

" Indicate matching brackets when cursor is over them.
set showmatch

" Ignore non-text or back-up files.
set wildignore=*.o,*.obj,*.a,*.lib,*.so,*.dll,*.exe,*.pyc,*.class,*.swp,*~

set lazyredraw          " redraw only when we need to.

" Hide buttons in gVim
if has("gui_running")
  if has("gui_gtk2")
    set guioptions-=T
  endif
endif

" -----------------------------------------------------------------------------
" Editing
" -----------------------------------------------------------------------------

syntax on

" Allow plugins by file type
filetype plugin on
filetype indent on
set number

" Make "<BS>" and "<Del>" behavior less surprising. (fix backspace problem )
set backspace=indent,eol,start
set encoding=utf-8

set pastetoggle=<F1>

set colorcolumn=79

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------

set expandtab " insert space chars whenever a tab key is pressed
set tabstop=4 " how many columns a tab counts for
set softtabstop=4 " use 4 space chars for tab with insert mode (since expandtab is enabled)
set shiftwidth=4 " Number of spaces to use for each step of (auto)indent

" Tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" for showing status bar always
set ls=2


" -----------------------------------------------------------------------------
" Mapped Key Bindings
" -----------------------------------------------------------------------------

set pastetoggle=<F1>
map <F2> :NERDTreeToggle<CR>
map <F3> :TagbarToggle<CR>
map <F5> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
map <leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>

" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

" tab navigation mappings
map tn :tabn<CR> map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" tags (symbols) in current file finder mapping
nmap <C-g> :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap <C-n> :CtrlPBufTagAll<CR>

" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>

nmap <C-S-b> :tab split<CR>:PymodePython rope.goto()<CR>
nmap <C-u> :RopeFindOccurrences<CR>

" Write file with sudo
cmap w!! %!sudo tee > /dev/null %


" -----------------------------------------------------------------------------
" Hooks
" -----------------------------------------------------------------------------

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

autocmd BufWritePre * :call Trim()


" -----------------------------------------------------------------------------
" Custom Functions
" -----------------------------------------------------------------------------
" Re-indent the whole buffer.
" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction


" Remove trailing whitespace in the whole buffer.
function! Trim()
      call Preserve('%s/\s\+$//e')
endfunction
