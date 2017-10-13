if exists("g:loaded_pullreview")
  finish
endif
let g:loaded_pullreview = 1

if has('ruby')
  ruby $: << File.expand_path(File.join(Vim.evaluate('g:PULLREVIEW_INSTALL_PATH'), '..', 'lib'))
  ruby require 'pull_review'

  function pullreview#get_index()
    enew
    set ft=pullreview-index
    ruby PullReview::GetIndex.call
    set noma
  endfunction
endif
