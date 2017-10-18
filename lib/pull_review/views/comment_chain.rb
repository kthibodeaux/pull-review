module PullReview
  class View::CommentChain
    include Bufferable

    def initialize(diff_line_number)
      @diff_line_number = diff_line_number
    end

    def call
      if has_comments?
        Vim.command 'vsplit'
        Vim.command 'enew'
        Vim.command 'setlocal wrap'
        Vim.command 'setlocal linebreak'
        write_comments_to_buffer
      else
        Vim.command "echo 'No comment chain present for this line'"
      end
    end

    private
    attr_reader :diff_line_number

    def has_comments?
      !diff_map_location.nil? && comments.any?
    end

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
  end
end
