filetype off

" Pathogen allows us to load bundles for vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Enable cold folding
set foldmethod=indent
set foldlevel=99

" Mapping window navigation (normally it's CTRL+W, then j, k, l, or h)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Change behavior of shift+Y to be similar to shift+C and shift+D (i.e.
" copy everything under the cursor until the end of the line.
noremap Y y$

" Mapping NERD Tree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$']

" Mapping Gundo
map <leader>g :GundoToggle<CR>

" Mapping Ack (for find in project functionality)
nmap <leader>a <Esc>:Ack!

" Syntax Highlighting and color
syntax on
set background=dark
colorscheme solarized

" Attempts to detect filetypes, and loads indent file for filetype
filetype on
filetype plugin indent on

" Don't use quickfix window for pyflakes
let g:pyflakes_use_quickfix=0

" Jump to PEP8 violations in its quickfix window
let g:pep8_map='<leader>8'

" Configure SuperTab plugin to be context sensitive
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType="context"
set completeopt=menuone,longest,preview

" Ignore file types -- there should be a plugin that looks at either .hgignore
" or .gitignore.
set wildignore=*.pyc,*~

" Incremental searching. Highlights and moves screen, but not cursor to
" next matching word, you still need to press enter to jump cursor to
" match 
set incsearch

" Highlights search results
set hlsearch

" Press Space to turn off highlighting and clear any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Highlight the current line in the current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Change indentation after open parens, braces, etc.
" I don't use continuations, but to make everything the same,
" I'll set the indentation to one for that as well.
let g:pyindent_open_paren = '&sw'
let g:pyindent_continue = '&sw'

" Allow switching out of modified buffers without having to 
" save them first.
set hidden
