module PullReview
  class Request::PostComment < PullReview::PostRequest
    def initialize(number:, comment:)
      @number = number
      @comment = comment
    end

    private
    attr_reader :number, :comment

    def url
      "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ number }/comments"
    end

    def request_body
      comment.to_json
    end
  end
end
