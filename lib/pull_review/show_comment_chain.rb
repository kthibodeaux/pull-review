module PullReview
  class ShowCommentChain
    include Bufferable

    def initialize(diff_line_number)
      @diff_line_number = diff_line_number
    end

    def call
      Vim.command 'vsplit'
      Vim.command 'enew'
      write_comments_to_buffer
      create_maps
    end

    private
    attr_reader :diff_line_number

    def write_comments_to_buffer
      modify do
        comments.flatten.each do |line|
          buffer_print_line line
        end
      end
    end

    def comments
      @comments = CommentChain
        .loaded
        .select { |comment| comment.fetch('path') == diff_map_location.fetch(:file) }
        .select { |comment| comment.fetch('position') == diff_map_location.fetch(:relative_line) }
        .map { |comment| CommentPresenter.new(comment).to_a }
    end

    def diff_map_location
      DiffMap.loaded[diff_line_number]
    end

    def create_maps
      Vim.command 'nnoremap <buffer> q :bd<CR>'
    end
  end
end
