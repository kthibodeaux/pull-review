module PullReview
  class GetAllLabels
    def self.call
      JSON
        .parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "https://api.github.com/repos/#{ PullReview::REPO }/labels"`)
        .map { |e| e.fetch('name') }
        .sort
    end
  end
end
