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

    def self.sign_name_for(line_number)
      path = DiffMap.loaded[line_number].fetch(:file)
      position = DiffMap.loaded[line_number].fetch(:relative_line)

      username = self.loaded
        .select { |comment| comment.fetch('path') == path }
        .select { |comment| comment.fetch('position') == position }
        .sort { |a, b| a.fetch('created_at') <=> b.fetch('created_at') }
        .to_a
        .last
        .fetch('user')
        .fetch('login')

      if username == PullReview::User.current.name
        'pullreviewcommentgreen'
      else
        'pullreviewcomment'
      end
    end
  end
end
