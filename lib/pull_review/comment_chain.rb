module PullReview
  class CommentChain
    def self.load(line)
      number = line.split(':').first
      @loaded = JSON
        .parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ number }/comments"`)
        .reject { |e| e.fetch('position').nil? }
    end

    def self.loaded
      @loaded
    end
  end
end
