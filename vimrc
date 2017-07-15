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
Bundle 'scrooloose/syntastic.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'godlygeek/tabular.git'
Bundle 'derekwyatt/vim-scala'
Bundle 'tpope/vim-rails'
Bundle 'mtscout6/vim-cjsx'
Bundle 'mxw/vim-jsx'
Bundle 'pangloss/vim-javascript'
Bundle 'thinca/vim-localrc'
Bundle 'Valloric/YouCompleteMe'

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
set bs=2
set hlsearch
set incsearch

set background=dark
colorscheme solarized

" Project specific .vimrc files
set exrc
set secure

nmap ,t :CtrlP<cr>

nmap ,h :!haml % %<.html<cr>
nmap ,s :!sass % %<.css<cr>
nmap ,p :!python %<cr>
"nmap ,n :!nosetests --nocapture<cr>
nmap ,a :A<cr>
nmap ,m :!make app<cr>
nmap ,n :!make test<cr>
nmap <F4> :NERDTree<cr>
nmap <F5> :NERDTreeFind<cr>
nmap <F6> :NERDTreeClose<cr>
"nmap ,r :!python pingpongbot.py Bottitude boris.helloworldopen.fi 9090<cr>
nmap ,w :echo @%<cr>
nmap ,j :%!python -m json.tool<cr>
nmap ,f zfat
nnoremap <C-n> :call NumberToggle()<cr>
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
:nnoremap <F7> :buffers<CR>:buffer<Space>

map <Tab> :bnext<CR>
map <S-Tab> :bprev<CR>

set ttymouse=xterm2
set mouse=v

" Hilight trailing whitespaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:au BufWinEnter * let w:m1=matchadd('ExtraWhitespace', '\s\+$', -1)

" Ctrl+c pastes visual to clipboard
map <C-c> "+y<CR>

" Config file for coffeelint in syntastic
let g:syntastic_coffee_coffeelint_args="--csv -f ~/.coffeelint_config"
let g:syntastic_python_flake8_args="--max-line-length=120"


" Remove all html checkers because they validate over internet connection
let g:syntastic_html_checkers=[]
let g:syntastic_haml_checkers=[]

set wildignore+=*/build/*,*/bower_components/*

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

" Remove preview window from YCM
set completeopt-=preview
