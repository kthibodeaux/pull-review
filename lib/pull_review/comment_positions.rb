module PullReview
  class CommentPositions
    def self.mark_lines(buffer_number)
      self.lines_with_comments.each do |line_number|
        sign_name = CommentChain.sign_name_for(line_number)
        Vim.command "sign place #{ line_number } line=#{ line_number } name=#{ sign_name } buffer=#{ buffer_number }"
      end
    end

    def self.lines_with_comments
      CommentChain.loaded.map do |comment|
        line_number = DiffMap
          .loaded
          .select { |k, v| v.fetch(:file) == comment.fetch('path') }
          .detect { |k, v| v.fetch(:relative_line) == comment.fetch('position') }
          .first
      end.uniq.sort
    end
  end
end
