module PullReview
  class GetPullRequest
    include Bufferable
    BUFFER_TYPE = 'diff'

    def initialize(line)
      @line ||= line
    end

    def call
      if line_contains_pr_number?
        Vim.command 'tab new'
        maps = ParseDiff.new(diff).mappings

        modify do
          diff.split("\n").each do |line|
            buffer_print_line line
          end
        end

        comment_positions.each do |comment_position|
          line_number = maps
            .select { |k, v| v.fetch(:file) == comment_position.fetch('path') }
            .detect { |k, v| v.fetch(:relative_line) == comment_position.fetch('position') }
            .first
          Vim.command "sign place #{ line_number } line=#{ line_number } name=pullreviewcomment buffer=#{ Vim::Buffer.current.number }"
        end
      else
        Vim.command "echo 'No pull request found in #{ line }'"
      end
    end

    private
    attr_reader :line

    def comment_positions
      @comment_positions ||= JSON
        .parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ number }/comments"`)
        .reject { |e| e.fetch('position').nil? }
    end

    def diff
      @diff ||= `curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Accept: application/vnd.github.v3.diff" "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ pull_request_number }.diff"`
    end

    def line_contains_pr_number?
      line.include?(':')
    end

    def number
      line.split(':').first
    end
  end
end
