pull-review
===========

This is my first Vim plugin so expect a non-idiomatic structure.

This plugin was inspired by [AGhost-7/critiq.vim][] and [codegram/vim-codereview][].

The reason for creating my own is to match my workflow and be able to add features on the fly as needed.  If you are looking for a more general purpose tool I recommend trying [AGhost-7/critiq.vim][]

Setup
-----

Save your github access token as the only line in `~/.pullreview`.

Usage
-----

In a git project, run `:PullReviewList`.

In the PullRequest (diff) view lines that have comments will have a symbol in the line gutter.  Comment chains that you are not the last to have commented on will have their line gutter symbol highlighted.  If you were the last person to comment on the comment chain then the line gutter symbol will not be highlighted.

Mappings
--------

All mappings are in normal mode.

### PullReviewList

| Map | Action |
|-----|--------|
| `r` | Close and reopen the *PullRequestList* |
| `<CR>` | Open the *PullRequest* in a new tab<sup>1</sup> |

### PullRequest

| Map | Action |
|-----|--------|
| `<CR>` | Open the *CommentChain* for the current line |
| `c` | Open a split to write a *NewComment* for the current line |
| `o` | Open the file for the current line<sup>2</sup> |
| `<C-p>` | Go to previous line with a comment |
| `<C-n>` | Go to next line with a comment |

### NewComment

| Map | Action |
|-----|--------|
| `<CR>` | Post comment |


<sup>1</sup> Must be on a line containing a pull request title.
<sup>2</sup> This is going to show you your local version of the file.

[AGhost-7/critiq.vim]: https://github.com/AGhost-7/critiq.vim
[codegram/vim-codereview]: https://github.com/codegram/vim-codereview
