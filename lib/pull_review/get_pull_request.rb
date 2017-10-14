module PullReview
  class GetPullRequest
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

    def line_maps
      @line_maps = Diff.parse(diff)
    end

    def write_diff_content_to_buffer
      modify do
        diff.split("\n").each do |line|
          buffer_print_line line
        end
      end
    end

    def mark_lines_that_have_comments
      CommentPositions.mark_lines(number, line_maps, Vim::Buffer.current.number)
    end

    def diff
      @diff ||= Diff.find(number)
    end

    def number
      line.split(':').first
    end
  end
end
