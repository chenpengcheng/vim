" FUNCTION: s:addBookmark(bookmark) {{{1
" Add a bookmark.
function! NERDTreeAddBookmark(node)
    call nerdtree#ui_glue#bookmarkNode('')
endfunction

call NERDTreeAddKeyMap({ 'key': 'b', 'scope': "Node", 'callback': 'NERDTreeAddBookmark' })
