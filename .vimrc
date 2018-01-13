execute pathogen#infect()

syntax on
filetype plugin indent on

set t_Co=256
set clipboard=unnamed
set ff=unix
set number
set expandtab
set tabstop=4
set shiftwidth=4
set cursorline
set hlsearch
set incsearch
set autoindent
set autoread
set shm+=A

if has("gui_running")
    set guioptions-=T
    set lines=80
    set columns=100
endif

colorscheme ron
highlight CursorLine cterm=bold ctermbg=brown
highlight LineNr ctermfg=darkmagenta

" ag
nmap <F3> :grep! <cword><CR>:botright cw<CR>
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ -p\ ~/.vim/agignore
endif

" fzf
nmap <F11> :Files<CR>
nmap <F2> :Tags<CR>
set rtp+=~/.fzf
let g:fzf_layout = { 'down': '~20%' }

" NERDTree
nmap <F10> :NERDTreeFind<CR>
nmap <F12> :NERDTreeToggle<CR>
let NERDTreeBookmarksFile = '/tmp/.NERDTreeBookmarks'
let NERDTreeChDirMode = 2
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeShowLineNumbers=1
let NERDTreeShowBookmarks = 1
let NERDTreeWinPos = 'right'
let NERDTreeWinSize = 40
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree

" Tagbar
nmap <F1> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 0
let g:tagbar_hide_nonpublic = 1
let g:tagbar_left = 1
let g:tagbar_show_linenumbers = 1
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
autocmd FileType * nested :call tagbar#autoopen(0)

" airline
let g:airline_section_y = ''
let g:airline#extensions#tabline#enabled = 1

" vim-qf
nmap <F4> <Plug>qf_qf_toggle
nmap <C-p> <Plug>qf_qf_previous
nmap <C-n>  <Plug>qf_qf_next

" syntastic
set statusline+=%f\ %h%w%m%r\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %=%(%l,%c%V\ %=\ %P%)
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = [ 'pylint' ]
