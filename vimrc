let mapleader=","

filetype off                   " required for vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Bundles
Bundle 'VundleVim/Vundle.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-rails'
Bundle 'pangloss/vim-javascript'
Bundle 'Valloric/YouCompleteMe'
Bundle "lepture/vim-jinja"
Bundle "leafgarland/typescript-vim"
Bundle "peitalin/vim-jsx-typescript"
Bundle "w0rp/ale"
Bundle 'editorconfig/editorconfig-vim'
Bundle 'chemzqm/vim-jsx-improve'
Bundle 'flowtype/vim-flow'
Bundle 'junegunn/goyo.vim'
Bundle 'jlanzarotta/bufexplorer'

call vundle#end()

function! NumberToggle()
  if (&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

filetype plugin indent on
syntax on
set relativenumber
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smartindent
set autoindent
set hlsearch
set incsearch
set backspace=2

set background=dark
colorscheme solarized

" Project specific .vimrc files
set exrc
set secure

nmap ,t :CtrlP<cr>

nmap ,a :A<cr>
nmap <F4> :NERDTreeClose<cr>
nmap <F5> :NERDTreeFind<cr>
nmap <F6> :NERDTree<cr>
"nmap ,r :!python pingpongbot.py Bottitude boris.helloworldopen.fi 9090<cr>
nmap ,w :echo @%<cr>
nmap ,j :%!python -m json.tool<cr>
nmap ,f zfat
nmap ,fj :set ft=jinja<cr>
nnoremap <C-n> :call NumberToggle()<cr>
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
:nnoremap <F7> :buffers<CR>:buffer<Space>

"In visual mode, search the selection with //
vnoremap // y/<C-R>"<CR>

"Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>

map <Tab> :bnext<CR>
map <S-Tab> :bprev<CR>

"YCM
nnoremap <leader>d :YcmCompleter GoToDefinition<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
nnoremap <leader>i :YcmCompleter GoToInclude<CR>
nnoremap <leader>j :YcmCompleter GetType<CR>

" Override Ycm when using javascript
au FileType javascript nnoremap <buffer> <leader>j :FlowType<CR>
au FileType javascript nnoremap <buffer> <leader>d :FlowJumpToDef<CR>

"BufExplorer
nnoremap <leader>p :BufExplorer<CR>

let g:flow#enable = 0
let g:flow#omnifunc = 0

if !has('nvim')
  set ttymouse=xterm2
  set mouse=v
endif

if has('nvim')
  set mouse=""
  language en_US
  set completeopt-=preview
endif

" Hilight trailing whitespaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:au BufWinEnter * let w:m1=matchadd('ExtraWhitespace', '\s\+$', -1)

" Ctrl+c pastes visual to clipboard
map <C-c> "+y<CR>

" Sometimes vim get confused from initial hash in beginning of file so force
" filetype to be python when the file ends with .py
autocmd BufRead,BufNewFile *.py set filetype=python

" Disable some rules from flake8 checker
let g:ale_python_flake8_args='--ignore=E301,W601,W191 --max-line-length=119'

let g:ale_linters = {
\   'typescript': ['tsserver'],
\   'go': ['gofmt', 'golint', 'go vet', 'gotype', 'go build'],
\   'javascript': ['eslint', 'flow'],
\   'python': ['flake8']
\}
let g:ale_typescript_tslint_use_local_config = 1
let g:ale_javascript_prettier_use_local_config = 1

set wildignore+=*/build/*,*/bower_components/*,*/public/*,*.pyi

function! Coffee()
    nmap ,c :!coffee --compile %<cr>
endfunction

" Clear invisible buffers
function! ClearBuffers()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction

function! WriteMode()
  Goyo x30
endfunction

" Uncommenting this breaks JS indentation
"let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers = ['jsxhint']

let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|vendor\|coverage\|dist'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=2000

" Remove preview window from YCM
set completeopt-=preview

" Make sure editrconfig works nicely with fugitive and prevent loading any
" remote editorconfigs
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:CommandTMaxFiles=50000

augroup dockerfile
  au!
  autocmd BufNewFile,BufRead Dockerfile.*   set filetype=Dockerfile
augroup END
