module PullReview
  class GetCommentChain
    def initialize(line_number)
      @line_number = line_number
    end

    def call
      Vim.command 'vsplit'
      Vim.command 'enew'
      write_comment_chain_to_buffer
    end

    private
    attr_reader :line_number

    def write_comment_chain_to_buffer
      Vim.command "echo '#{ line_number }'"
    end

    def comment_chain
      modify do
        diff.split("\n").each do |line|
          buffer_print_line line
        end
      end
    end

    def comment_chain
      @line_maps = CommentChain.loaded
    end
  end
end
