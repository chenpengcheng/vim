execute pathogen#infect()

syntax on
filetype plugin indent on

set t_Co=256
set clipboard=unnamed
set ff=unix
set number
set backspace=indent,eol,start
set expandtab
set tabstop=4
set shiftwidth=4
set cursorline
set hlsearch
set incsearch
set autoindent
set autoread
set shm+=A
set updatetime=100
set fillchars+=vert:\ 

colorscheme ron
highlight CursorLine cterm=bold ctermbg=brown
highlight EndOfBuffer ctermfg=black
highlight LineNr ctermfg=darkmagenta
highlight Pmenu ctermfg=cyan ctermbg=black
highlight PmenuSel cterm=bold ctermfg=blue
highlight TagbarSignature ctermfg=gray
highlight! link TagbarHighlight Normal
highlight! link Sneak Normal

"leader
let mapleader = ';'

" buffer
nmap <silent> <Tab> :call BufferNext()<CR>
nmap <silent> <Esc>[Z :call BufferPrev()<CR>
nmap <silent> <leader>x :call BufferClose()<CR>
function! BufferPrev()
    let l:buffer_name = expand( '%' )
    let l:num_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

    if empty(l:buffer_name) || &filetype =~ 'tagbar' || &filetype =~ 'nerdtree'
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

    if empty(l:buffer_name) || &filetype =~ 'tagbar' || &filetype =~ 'nerdtree'
        execute 'wincmd w'
    elseif l:num_buffers <= 1
        execute 'NERDTreeFind'
    else
        execute 'bnext'
    endif
endfunction

function! BufferClose()
    let l:num_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

    if &filetype == 'qf' || &filetype =~ 'tagbar' || &filetype =~ 'nerdtree'
        execute 'quit'
    elseif l:num_buffers > 1
        execute 'bNext'
        execute 'bdelete#'
    endif
endfunction

" ag
nmap <silent> <F4> :grep! <cword><CR>:botright cw<CR>
if executable('ag')
  let &grepprg='ag --nogroup --nocolor --width=80 -p ~/.vim/agignore'
endif

" fzf
nmap <silent> <F10> :call SafeExecute(':Files')<CR>
nmap <silent> <F3> :call SafeExecute(':Tags')<CR>
set rtp+=~/.fzf
let g:fzf_layout = { 'down': '~20%' }

" sneak
let g:sneak#s_next = 1
map , <Plug>Sneak_;

" rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1

" NERDTree
nmap <silent> <F11> :call SafeExecute(':NERDTreeFind')<CR>
nmap <silent> <F12> :NERDTreeToggle<CR>
let NERDTreeBookmarksFile = expand('$HOME/.NERDTreeBookmarks')
let NERDTreeChDirMode = 2
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeShowLineNumbers=1
let NERDTreeShowBookmarks = 1
let NERDTreeWinPos = 'right'
let NERDTreeWinSize = 40
autocmd StdinReadPre * let s:std_in=1

" Tagbar
nmap <silent> <F1> :TagbarToggle<CR>
nmap <silent> <F2> :call TagbarFind()<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_compact = 1
let g:tagbar_expand = 1
let g:tagbar_foldlevel = 1
let g:tagbar_hide_nonpublic = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_left = 1
let g:tagbar_map_help = '?'
let g:tagbar_show_linenumbers = 1
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'n:interfaces',
        \ 't:types',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'r:constructor',
        \ 'm:methods',
        \ 'f:functions',
        \ 'v:variables',
        \ 'c:constants'
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
autocmd BufRead * nested :call tagbar#autoopen(0)
function! TagbarFind()
    if &filetype !~ 'tagbar'
        call SafeExecute( ':TagbarShowTag' )
        execute 'wincmd h'
    endif
endfunction

" airline
let g:airline_powerline_fonts = 1
let g:airline_section_y = ''
let g:airline_section_z = '%3p%% %#__accent_bold#%#__restore__#%#__accent_bold#%#__restore__#'
let g:airline#extensions#tabline#enabled = 1

" vim-qf
nmap <silent> <C-p> <Plug>qf_qf_previous
nmap <silent> <C-n>  <Plug>qf_qf_next

" ale
let g:ale_echo_msg_format = '[%linter%] %s'

" syntastic
set statusline +='%f\ %h%w%m%r\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %=%(%l,%c%V\ %=\ %P%)'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': [ 'java' ] }
let g:syntastic_python_checkers = [ 'pylint' ]
let g:syntastic_go_checkers = [ 'govet' ]

" vim-go
let g:go_fmt_command = 'goimports'

" custom
function! SafeExecute(command)
    let l:num_windows = winnr('$')

    if l:num_windows > 1
        if &filetype =~ 'tagbar'
            execute 'wincmd l'
        elseif &filetype =~ 'nerdtree'
            execute 'wincmd h'
        endif
        execute a:command
    endif
endfunction

" start
if  &diff != 1
    if argc() == 0
        autocmd VimEnter * Tagbar
    endif
    autocmd VimEnter * NERDTree
    autocmd VimEnter * execute 'wincmd h'
endif
