module PullReview
  class Request::PostComment
    def initialize(number:, comment:)
      @number = number
      @comment = comment
    end

    def response
      url = "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ number }/comments"

      uri = URI.parse(url)

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.path)
      request['Authorization'] = "token #{ PullReview::TOKEN }"
      request['Content-Type'] = 'application/json'

      request.body = comment.to_json

      response = https.request(request)
      response.body
    end

    private
    attr_reader :number, :comment
  end
end
