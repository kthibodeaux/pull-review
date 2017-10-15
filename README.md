pull-review
===========

This is my first Vim plugin so expect a non-idiomatic structure.

This plugin was inspired by [AGhost-7/critiq.vim][] and [codegram/vim-codereview][].

The reason for creating my own is to match my workflow and be able to add features on the fly as needed.  If you are looking for a more general purpose tool I recomment trying [AGhost-7/critiq.vim][]

Setup
-----

Save your github access token as the only line in `~/.pullreview`.

Usage
-----

In a git project, run `:PullReviewList`

This will list all open pull requests for your project.  With your cursor over the line that contains the pull request number, press `<CR>` to open the diff.

In the diff view lines that have comments will have a symbol in the line gutter.  To view the comment thread for that line, put your cursor on the line and press `<CR>`.

Comments can be added in the diff view by pressing `c`.  A split will open and be in insert mode.  Type your comment there and when you are ready to post the comment leave insert mode and press `<CR>`.

[AGhost-7/critiq.vim]: https://github.com/AGhost-7/critiq.vim
[codegram/vim-codereview]: https://github.com/codegram/vim-codereview
