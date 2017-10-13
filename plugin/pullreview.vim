if exists("g:loaded_pullreview_plugin")
  finish
endif
let g:loaded_pullreview_plugin = 1

if !exists('g:PULLREVIEW_INSTALL_PATH')
  let g:PULLREVIEW_INSTALL_PATH = fnamemodify(expand("<sfile>"), ":p:h")
end

command! PullReviewList call pullreview#get_index()
