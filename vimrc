let mapleader=","

filetype off                   " required for vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Bundles
Bundle 'VundleVim/Vundle.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'godlygeek/tabular.git'
Bundle 'derekwyatt/vim-scala'
Bundle 'tpope/vim-rails'
Bundle 'mtscout6/vim-cjsx'
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'Valloric/YouCompleteMe'
Bundle "lepture/vim-jinja"
Bundle "leafgarland/typescript-vim"
Bundle "peitalin/vim-jsx-typescript"
Bundle "w0rp/ale"

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
set shiftwidth=4
set softtabstop=4
set tabstop=4
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
nmap <F4> :NERDTree<cr>
nmap <F5> :NERDTreeFind<cr>
nmap <F6> :NERDTreeClose<cr>
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
nnoremap <leader>d :YcmCompleter GoTo<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
nnoremap <leader>i :YcmCompleter GoToInclude<CR>

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

" Hilight too long lines
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%119v.*/

" Ctrl+c pastes visual to clipboard
map <C-c> "+y<CR>

" Config file for coffeelint in syntastic
let g:syntastic_coffee_coffeelint_args="--csv -f ~/.coffeelint_config"
let g:syntastic_python_flake8_args="--max-line-length=120"

" Sometimes vim get confused from initial hash in beginning of file so force
" filetype to be python when the file ends with .py
autocmd BufRead,BufNewFile *.py set filetype=python

" Disable some rules from flake8 checker
let g:ale_python_flake8_args='--ignore=E301,W601,W191 --max-line-length=119'

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

let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers = ['jsxhint']

let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Remove preview window from YCM
set completeopt-=preview
