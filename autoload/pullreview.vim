if exists("g:loaded_pullreview")
  finish
endif
let g:loaded_pullreview = 1

sign define pullreviewcomment text=↪ texthl=Search

if has('ruby')
  ruby $: << File.expand_path(File.join(Vim.evaluate('g:PULLREVIEW_INSTALL_PATH'), '..', 'lib'))
  ruby require 'pull_review'

  function pullreview#show_pull_request()
    let l:line = getline(".")
    ruby PullReview::CommentChain.load(Vim.evaluate("l:line"))
    ruby PullReview::Diff.load(Vim.evaluate("l:line"))
    ruby PullReview::DiffMap.load_from_loaded_diff()
    ruby PullReview::ShowPullRequest.new(Vim.evaluate("l:line")).call()
  endfunction

  function pullreview#show_pull_request_list()
    ruby PullReview::ShowPullRequestList.call()
  endfunction
endif
