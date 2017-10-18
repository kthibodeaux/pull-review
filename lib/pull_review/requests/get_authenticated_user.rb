module PullReview
  class Request::GetAuthenticatedUser < PullReview::GetRequest

    private

    def url
      'https://api.github.com/user'
    end
  end
end
