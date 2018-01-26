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
set updatetime=200
set fillchars+=vert:\ 

if has("gui_running")
    set guioptions-=T
    set lines=80
    set columns=100
endif

colorscheme ron
highlight CursorLine cterm=bold ctermbg=brown
highlight LineNr ctermfg=darkmagenta

" custom
function! SafeExecute(command)
    let l:buffer_name = expand('%')
    let l:num_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    let l:num_windows = winnr('$')

    if l:num_windows > 1
        if l:buffer_name =~ '__Tagbar__'
            execute 'wincmd l'
        elseif l:buffer_name =~ 'NERD'
            execute 'wincmd h'
        endif
        execute 'normal! ' . a:command . "\<CR>"
    endif
endfunction

function! BufferPrev()
    let l:buffer_name = expand( '%' )
    let l:num_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

    if empty(l:buffer_name) || l:buffer_name =~ '__Tagbar__' || l:buffer_name =~ 'NERD'
        execute 'wincmd W'
    elseif l:num_buffers <= 1
        execute 'NERDTreeFind'
    else
        execute 'bNext'
    endif
endfunction

function! BufferNext()
    let l:buffer_name = expand( '%' )
    let l:num_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

    if empty(l:buffer_name) || l:buffer_name =~ '__Tagbar__' || l:buffer_name =~ 'NERD'
        execute 'wincmd w'
    elseif l:num_buffers <= 1
        execute 'NERDTreeFind'
    else
        execute 'bnext'
    endif
endfunction

" buffer
nmap <silent> <Tab> :call BufferNext()<CR>
nmap <silent> <Esc>[Z :call BufferPrev()<CR>

" ag
nmap <silent> <F4> :grep! <cword><CR>:botright cw<CR>
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ -p\ ~/.vim/agignore
endif

" fzf
nmap <silent> <F10> :call SafeExecute(':Files')<CR>
nmap <silent> <F3> :call SafeExecute(':Tags')<CR>
set rtp+=~/.fzf
let g:fzf_layout = { 'down': '~20%' }

" NERDTree
nmap <silent> <F11> :call SafeExecute(':NERDTreeFind')<CR>
nmap <silent> <F12> :NERDTreeToggle<CR>
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
nmap <silent> <F1> :TagbarToggle<CR>
nmap <silent> <F2> :call TagbarFind()<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 0
let g:tagbar_hide_nonpublic = 1
let g:tagbar_left = 1
let g:tagbar_map_help = '?'
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
function! TagbarFind()
    let l:buffer_name = expand('%')
    if l:buffer_name !~ '__Tagbar__'
        call SafeExecute( ':TagbarShowTag' )
        execute 'wincmd h'
    endif
endfunction

" airline
let g:airline_powerline_fonts = 1
let g:airline_section_y = ''
let g:airline#extensions#tabline#enabled = 1

" vim-qf
nmap <silent> <F5> <Plug>qf_qf_toggle
nmap <silent> <C-p> <Plug>qf_qf_previous
nmap <silent> <C-n>  <Plug>qf_qf_next

" syntastic
set statusline+=%f\ %h%w%m%r\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %=%(%l,%c%V\ %=\ %P%)
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': [ 'java' ] }
let g:syntastic_python_checkers = [ 'pylint' ]
