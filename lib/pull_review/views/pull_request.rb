module PullReview
  class View::PullRequest
    include Bufferable
    BUFFER_TYPE = 'diff'

    def initialize(line)
      @line ||= line
    end

    def call
      Vim.command 'tab new'
      write_diff_content_to_buffer
      mark_lines_that_have_comments
      create_maps
    end

    private
    attr_reader :line

    def write_diff_content_to_buffer
      modify do
        diff.split("\n").each do |line|
          buffer_print_line line
        end
      end
    end

    def mark_lines_that_have_comments
      CommentPositions.mark_lines(buffer.number)
    end

    def diff
      Diff.loaded
    end

    def create_maps
      Vim.command 'nnoremap <buffer> <silent> <CR> :call pullreview#show_comment_chain()<CR>'
      Vim.command 'nnoremap <buffer> <silent> c :call pullreview#new_comment()<CR>'
      Vim.command 'nnoremap <buffer> <silent> <C-p> :call pullreview#go_to_previous_commented_line()<CR>'
      Vim.command 'nnoremap <buffer> <silent> <C-n> :call pullreview#go_to_next_commented_line()<CR>'
      Vim.command 'nnoremap <buffer> <silent> q :bd<CR>'
    end
  end
end
