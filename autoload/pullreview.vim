if exists("g:loaded_pullreview")
  finish
endif
let g:loaded_pullreview = 1

sign define pullreviewcomment text=↪ texthl=Search

if has('ruby')
  ruby $: << File.expand_path(File.join(Vim.evaluate('g:PULLREVIEW_INSTALL_PATH'), '..', 'lib'))
  ruby require 'pull_review'

  function pullreview#get_index()
    ruby PullReview::GetIndex.call
  endfunction

  function pullreview#get_pull_request()
    let l:line = getline(".")
    ruby PullReview::GetPullRequest.new(Vim.evaluate("l:line")).call
  endfunction
endif
