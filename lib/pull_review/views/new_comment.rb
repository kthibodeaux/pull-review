module PullReview
  class View::NewComment
    def initialize(diff_line_number)
      @diff_line_number = diff_line_number
    end

    def call
      return if diff_map_location.nil?
      buffer
      create_maps
    end

    private
    attr_reader :diff_line_number

    def diff_map_location
      DiffMap.loaded[diff_line_number]
    end

    def create_maps
      Vim.command "nnoremap <buffer> <silent> <CR> :call pullreview#save_comment(#{ args })<CR>"
    end

    def args
      if comments.any?
        "{ 'in_reply_to': #{ comments.first.fetch('id')} }"
      else
        "{ 'path': '#{ diff_map_location.fetch(:file) }', 'position': #{ diff_map_location.fetch(:relative_line) }, 'commit_id': '#{ PullRequest.loaded.fetch('head').fetch('sha') }' }"
      end
    end

    def comments
      @comments ||= CommentChain
        .loaded
        .select { |comment| comment.fetch('path') == diff_map_location.fetch(:file) }
        .select { |comment| comment.fetch('position') == diff_map_location.fetch(:relative_line) }
    end

    def buffer
      @buffer ||= begin
                    Vim.command 'split'
                    Vim.command 'enew'
                    Vim.command 'set ma'
                    Vim.command 'setl buftype=nofile'
                    Vim.command 'set ft=markdown'
                    Vim::Buffer.current
                  end
    end
  end
end
