module PullReview
  class ShowPullRequest
    include Bufferable
    BUFFER_TYPE = 'diff'

    def initialize(line)
      @line ||= line
    end

    def call
      Vim.command 'tab new'
      write_diff_content_to_buffer
      mark_lines_that_have_comments
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
      CommentPositions.mark_lines(diff_map, Vim::Buffer.current.number)
    end

    def diff_map
      DiffMap.loaded
    end

    def diff
      Diff.loaded
    end
  end
end
