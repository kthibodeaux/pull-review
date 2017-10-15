module PullReview
  class GoToCommentLine
    def initialize(current_line_number)
      @current_line_number = current_line_number
    end

    def previous
      if index.zero?
        Vim.command "#{ lines_to_cycle.last }"
      else
        next_comment_line = lines_to_cycle[index - 1]
        Vim.command "#{ next_comment_line }"
      end
    end

    def next
      if index == lines_to_cycle.size - 1
        Vim.command "#{ lines_to_cycle.first }"
      else
        next_comment_line = lines_to_cycle[index + 1]
        Vim.command "#{ next_comment_line }"
      end
    end

    private
    attr_reader :current_line_number

    def lines_to_cycle
      [ CommentPositions.lines_with_comments, current_line_number ].flatten.uniq.sort
    end

    def index
      lines_to_cycle.index(current_line_number)
    end
  end
end
