module PullReview
  class Diff
    def self.load(line)
      number = line.split(':').first
      @loaded = `curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Accept: application/vnd.github.v3.diff" "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ number }.diff"`
    end

    def self.loaded
      @loaded
    end
  end
end
