module PullReview
  class CommentPositions
    def self.find(number)
      JSON
        .parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ number }/comments"`)
        .reject { |e| e.fetch('position').nil? }
    end

    def self.mark_lines(number, line_maps, buffer_number)
      self.find(number).each do |comment|
        line_number = line_maps
          .select { |k, v| v.fetch(:file) == comment.fetch('path') }
          .detect { |k, v| v.fetch(:relative_line) == comment.fetch('position') }
          .first

        Vim.command "sign place #{ line_number } line=#{ line_number } name=pullreviewcomment buffer=#{ buffer_number }"
      end
    end
  end
end
