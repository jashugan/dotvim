filetype off

" Basic Settings ---------------------------- {{{

syntax on

" Ignore file types -- there should be a plugin that looks at either .hgignore
" or .gitignore.
set wildignore=*.pyc,*~

" Incremental searching. Highlights and moves screen, but not cursor to
" next matching word, you still need to press enter to jump cursor to
" match 
set incsearch

" Highlights search results
set hlsearch

" Allow switching out of modified buffers without having to 
" save them first.
set hidden

" Set line numbers
set number

" Erasing whitespace characters with backspace in insert mode
set backspace=indent,eol,start

" }}}

" Mappings ---------------------------- {{{

" Setting Leaders - I know the default leader is '\', but
" I like having this code here in case I want to change
" things
let mapleader = "\\"
let maplocalleader = "-"

" Quick edit .vimrc, quick load it as well.
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Enable cold folding
set foldmethod=indent
set foldlevel=99

" Mapping window navigation (normally it's CTRL+W, then j, k, l, or h)
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Change behavior of shift+Y to be similar to shift+C and shift+D (i.e.
" copy everything under the cursor until the end of the line.
nnoremap Y y$

" Escape out of insert mode. Disable normal <esc> for now. 
inoremap jk <esc>
inoremap <esc> <nop>

" Press Space to turn off highlighting and clear any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" }}}

" Plugins ---------------------------- {{{

" Pathogen allows us to load bundles for vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Mapping NERD Tree
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$']

" Mapping Gundo
nnoremap <leader>g :GundoToggle<CR>

" Mapping Ack (for find in project functionality)
nnoremap <leader>a <Esc>:Ack!

" Don't use quickfix window for pyflakes
let g:pyflakes_use_quickfix=0

" Jump to PEP8 violations in its quickfix window
let g:pep8_map='<leader>8'

" Configure SuperTab plugin to be context sensitive
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType="context"
set completeopt=menuone,longest,preview

" Configure ctrlp.vim to ignore things that I may still want to
" open using vim.
let g:ctrlp_custom_ignore = {
  \ 'dir': '\vve/',
  \ }

" }}}

" Theme and Appearance ---------------------------- {{{

" Syntax Highlighting and color
set background=dark
colorscheme solarized

" Highlight the current line in the current window
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" }}}

" Attempts to detect filetypes, and loads indent file for filetype
filetype on
filetype plugin indent on

" Change indentation after open parens, braces, etc.
" I don't use continuations, but to make everything the same,
" I'll set the indentation to one for that as well.
let g:pyindent_open_paren = '&sw'
let g:pyindent_continue = '&sw'

" Function to show diff when doing mercurial commits. It opens a new split 
" with diff inside.  (http://stackoverflow.com/questions/8009333/vim-show-diff-on-commit-in-mercurial)
" You must put this in your .hgrc:
"   editor = vim "+call HgCiDiff()"
" Note: the exclamation point at the end of function (i.e. function!) means
" that the function can be safely reloaded.
function! HgCiDiff()
    let changed_files = []
    let pattern = '\vHG: changed \zs(.+)\ze'
    while search("HG: changed", "W") > 0
        let line_text = getline(line("."))
        call add(changed_files, matchstr(line_text, pattern))
    endwhile
    let diff_cmd = "hg diff " . join(changed_files, " ")
    call cursor(1, 1) " Need to reset the cursor to the beginning of the buffer
    rightbelow vnew
    setlocal buftype=nofile
    let diff_output = system(diff_cmd)
    call append(0, split(diff_output, "\n"))
    call cursor(1, 1) " Need to reset the cursor to the beginning of the buffer
    setlocal ft=diff
    wincmd p
    setlocal spell spelllang=en_us
    cnoremap wq wqa
    cnoremap q qa!
endfunction
