module PullReview
  class ModifiedFiles
    def initialize(pull_request_number)
      @pull_request_number = pull_request_number
    end

    def changes
      JSON.parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ pull_request_number }/files"`)
    end

    private
    attr_reader :pull_request_number
  end
end
