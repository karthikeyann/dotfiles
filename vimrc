" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"

set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ericcurtin/CurtineIncSw.vim'
Plugin 'bfrg/vim-cpp-modern'
Plugin 'vim-airline/vim-airline'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'rhysd/vim-clang-format'
"let c_no_curly_error=1


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
"set textwidth=120
" turn syntax highlighting on
set t_Co=256
set viminfo='20,<1000,s1000

syntax on
" colorscheme wombat256
if &diff
    colorscheme elflord
endif
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=../tags
set tags+=../../tags
set tags+=../../../tags
set tags+=../../../../tags
set tags+=../../../../../tags
set tags+=../../../../../../tags
set tags+=../../../../../../../tags
set tags+=../../../../../../../../tags

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_authorName="Karthikeyan Natarajan"
function! OpenLog()
    let line = getline(".")
    let items = split(line, ':')
    if filereadable(items[0])
      " tabnew
	    exe "e ".items[0]
	    exe ":".items[1]
endif
endfunction
nnoremap gf :call OpenLog()<CR>



" Enhanced keyboard mappings
"
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" recreate tags file with F5
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
map <F7> :make<CR>
" build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>
" goto definition with F12
map <F12> <C-]>
" Sebastian Raschka
" 09/11/2013
"

syntax on
"set nonumber
set ruler

" search
set incsearch
set ignorecase
set smartcase
set hlsearch

set tabstop=2
set shiftwidth=2 " controls the depth of autoindentation
set expandtab    " converts tabs to spaces
set laststatus=2 " show status line always

"autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 syntax=cpp11
"autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.cu,*.cuh set ft=cuda

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"let c_no_curly_error=1

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cuda_checkers = ['cpplint']
let g:syntastic_cpp_checkers = ['cpplint']

"a.vim
let g:alternateSearchPath = 'sfr:../../src/,sfr:../src,sfr:../include,sfr:includes,sfr:../../include/cudf,sfr:../../../include/cudf/*/,sfr:../../../src/*/*/*/'

"vim clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}
"\ "BreakBeforeBraces": "Custom",
            \ "BraceWrapping": {
            \   "AfterClass":      "true",
            \   "AfterFunction":   "true"} }
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc,cuda nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc,cuda vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
"autocmd FileType c,cpp,objc ClangFormatAutoEnable

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
hi Search ctermbg=DarkYellow

