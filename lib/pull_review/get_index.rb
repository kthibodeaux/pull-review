module PullReview
  class GetIndex
    include Bufferable
    BUFFER_TYPE = 'pullreview-index'

    def self.call
      new.call
    end

    def call
      modify do
        pull_requests.each do |pr|
          buffer_print_line("#{ pr.number }: #{ pr.title }")
          buffer_print_line("#{ pr.user_login } #{ pr.labels }")
          buffer_print_line
        end
      end
    end

    private

    def pull_requests
      PullRequest.all
    end
  end
end
