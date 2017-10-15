module PullReview
  class SaveComment
    def initialize(args_dict)
      @args_dict = args_dict
    end

    def call
      post_comment
      add_comment_to_loaded
      Vim.command 'bd!'
      CommentPositions.mark_lines(DiffMap.loaded, Vim::Buffer.current.number)
    end

    private
    attr_reader :args_dict

    def post_comment
      @post_comment ||= `curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" -d '#{ comment.to_json }' "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ number }/comments"`
    end

    def add_comment_to_loaded
      CommentChain.loaded << JSON.parse(post_comment)
    end

    def comment
      args_dict.merge({ 'body' => body })
    end

    def body
      [].tap do |lines|
        (1..lines_in_buffer).each do |line_number|
          lines << Vim::Buffer.current[line_number]
        end
      end.join("\n")
    end

    def lines_in_buffer
      Vim::Buffer.current.count
    end

    def number
      PullRequest.loaded.fetch('number')
    end
  end
end
