module PullReview
  class GetIndex
    def self.call
      new.call
    end

    def call
      pull_requests.each do |pr|
        buffer_print_line("#{ pr.number }: #{ pr.title }")
        buffer_print_line("#{ pr.user_login } #{ pr.labels }")
        buffer_print_line
      end
    end

    private

    def buffer
      @buffer ||= Vim::Buffer.current
    end

    def buffer_print_line(string = '')
      buffer.append(last_line, string)
    end

    def pull_requests
      PullRequest.all
    end

    def last_line
      buffer.length - 1
    end
  end
end
