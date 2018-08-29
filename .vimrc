execute pathogen#infect()
execute pathogen#helptags()

syntax on
filetype plugin indent on

set t_Co=256
set clipboard=unnamedplus
set ff=unix
set number
set relativenumber
set conceallevel=1
set completeopt-=preview
set backspace=indent,eol,start
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set cursorline
set hlsearch
set incsearch
set autoindent
set autoread
set shm+=A
set updatetime=10
set ttimeoutlen=10
set fillchars+=vert:\ 
set directory^=/tmp//
set mouse=a

colorscheme ron
highlight Conceal cterm=bold ctermfg=yellow ctermbg=black
highlight CursorLine cterm=bold ctermbg=brown
highlight EndOfBuffer ctermfg=black
highlight LineNr ctermfg=darkmagenta
highlight MatchParen cterm=bold ctermfg=black ctermbg=yellow
highlight MatchWord cterm=bold ctermfg=blue ctermbg=black
highlight MatchWordCur cterm=bold ctermfg=yellow ctermbg=brown
highlight Pmenu ctermfg=cyan ctermbg=black
highlight PmenuSel cterm=bold ctermfg=blue
highlight! link Sneak Search
highlight! link TagbarHighlight Normal
highlight TagbarSignature ctermfg=gray
highlight VertSplit ctermfg=darkgray

" leader
let mapleader = ';'
nmap <silent> <leader><leader> :call HighlightOff()<CR>
nmap <silent> <leader>b :edit #<CR>
nmap <silent> <leader>j :call LocationNext()<CR>
nmap <silent> <leader>k :call LocationPrev()<CR>
nmap <silent> <leader>r :call RulerToggle()<CR>
nmap <silent> <leader>x :call BufferClose()<CR>
nmap <silent> <leader>X :qall<CR>
nmap <silent> <leader>hj <Plug>GitGutterNextHunk
nmap <silent> <leader>hk <Plug>GitGutterPrevHunk

" mouse
nmap <silent> <RightMouse> :call BufferExecute(':call BufferDelete()')<CR>
nmap <silent> <2-LeftMouse> gd

" highlight
function! HighlightOff()
  call g:sneak#cancel()
  let @/ = ''
endfunction

" ruler
function! RulerToggle()
  if &colorcolumn > 0
    set colorcolumn=0
  else
    set colorcolumn=80
  endif
endfunction

" command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

" ag
nmap <silent> <F4> :grep! <cword><CR>:botright cw<CR>
if executable('ag')
  let &grepprg='ag --nogroup --nocolor --width=80 -p ~/.vim/agignore'
endif

" sneak
nmap , <Plug>Sneak_;
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
let g:sneak#prompt = 'Sneak> '
let g:sneak#s_next = 1

" vim-matchup
let g:matchup_transmute_enabled = 1

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']

" UltiSnips
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1

" fzf
nmap <silent> <F10> :call BufferExecute(':Files')<CR>
nmap <silent> <F3> :call BufferExecute(':Tags')<CR>
set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND='ag --no-color --hidden -p ~/.vim/agignore -g ""'
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_tags_command = 'ctags -R --excmd=number --exclude=.git --exclude=node_modules'

" NERDTree
nmap <silent> <F11> :call BufferExecute(':NERDTreeFind')<CR>
nmap <silent> <F12> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode = 2
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeWinSize = 40
let g:NERDTreeMapHelp = '<Nul>'
let g:NERDTreeMapOpenVSplit = '<Nul>'
autocmd StdinReadPre * let s:std_in=1

" Tagbar
nmap <silent> <F1> :TagbarToggle<CR>
nmap <silent> <F2> :call TagbarFind()<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_compact = 1
let g:tagbar_expand = 1
let g:tagbar_foldlevel = 1
let g:tagbar_hide_nonpublic = 0
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
let g:tagbar_type_graphql = {
    \ 'ctagstype' : 'graphql',
    \ 'kinds'     : [
        \ 'e:enumerations',
        \ 'f:functions',
        \ 'i:variables',
        \ 'm:methods',
        \ 'q:variables',
        \ 't:types'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'type' : 't'
    \ },
\ }
let g:tagbar_type_make = {
    \ 'kinds':[
        \ 'm:macros',
        \ 't:targets'
    \ ]
\}
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

function! TagbarFind()
    if &filetype !~ 'tagbar'
        call BufferExecute( ':TagbarShowTag' )
        execute 'wincmd h'
    endif
endfunction

" vim-qf
nmap <silent> <C-p> <Plug>(qf_qf_previous)
nmap <silent> <C-n>  <Plug>(qf_qf_next)
autocmd FileType qf wincmd K

" airline
nmap <Esc>[Z <Plug>AirlineSelectPrevTab
nmap <Tab> <Plug>AirlineSelectNextTab
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline_powerline_fonts = 1
let g:airline_section_x = '%{airline#extensions#tagbar#currenttag()}'
let g:airline_section_y = ''
let g:airline_section_z = '%3p%% %#__accent_bold#%#__restore__#%#__accent_bold#%#__restore__#'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#default#layout = [[ 'a', 'c', 'x' ], [ 'error', 'warning', 'b', 'z' ]]
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['tagbar', 'nerdtree', 'qf']
let g:airline#extensions#tabline#show_tab_type = 0
autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()

" ale
" let g:ale_echo_msg_format = '[%linter%] %s'
" let g:ale_linters = { 'go': ['go vet'], }
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_sign_warning = '>>'

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': [ 'java' ] }
let g:syntastic_go_checkers = [ 'govet' ]
let g:syntastic_java_checkers = []
let g:syntastic_python_checkers = [ 'flake8' ]

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_list_type = 'locationlist'
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_list_height = 10
let g:go_snippet_engine = ''
let g:go_updatetime = 10

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:javascript_conceal_function = "⨍"
let g:javascript_conceal_return = "←"
let g:javascript_conceal_this = "@"

" python-mode
let g:pymode_breakpoint_bind = '<leader>p'
let g:pymode_options_colorcolumn = 0
let g:pymode_lint_sort = ['E', 'C', 'I']
let g:pymode_lint_cwindow = 0

" jedi-vim
let g:jedi#documentation_command = "K"
let g:jedi#goto_command = "gd"
let g:jedi#completions_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#usages_command = ""
let g:jedi#rename_command = ""

" tern_for_vim
autocmd FileType javascript nmap <silent> <buffer> gd :TernDef<CR>
autocmd FileType javascript nmap <silent> <buffer> K :TernDoc<CR>

" buffer
function! BufferClose()
    if BufferIsSpecial() == 1
        execute 'quit'
    else
        call BufferDelete()
    endif
endfunction

function! BufferExecute(command)
    if &filetype == 'tagbar'
        execute 'wincmd l'
    elseif &filetype == 'nerdtree'
        execute 'wincmd h'
    endif
    if BufferIsSpecial() == 0
        execute a:command
    endif
endfunction

function! BufferDelete()
    let l:num_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    if l:num_buffers > 1
        execute 'bNext'
        execute 'bdelete#'
    elseif l:num_buffers == 1
        execute 'bdelete'
    endif
endfunction

function! BufferIsSpecial()
    if &filetype == 'qf' || &filetype == 'tagbar' || &filetype == 'nerdtree'
        return 1
    else
        return 0
    endif
endfunction

" location list
function! LocationPrev()
    try
        lprev
    catch /^Vim\%((\a\+)\)\=:E42/
    catch /^Vim\%((\a\+)\)\=:E553/
        llast
    endtry
endfunction

function! LocationNext()
    try
        lnext
    catch /^Vim\%((\a\+)\)\=:E42/
    catch /^Vim\%((\a\+)\)\=:E553/
        lfirst
    endtry
endfunction

" start
if  &diff != 1
    if &columns > 160
        if &columns <= 180
            let g:NERDTreeWinSize = 35
            let g:tagbar_width = 35
        endif
        autocmd VimEnter * NERDTree
        if argc() != 0
            autocmd VimEnter * execute 'wincmd h'
        endif
        autocmd BufRead * nested :call tagbar#autoopen(0)
    endif
endif

" workarounds
" DeprecationWarning: the imp module is deprecated in favour of importlib
if has('python3')
  silent! python3 1
endif
