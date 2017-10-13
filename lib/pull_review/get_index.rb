module PullReview
  class GetIndex
    BUFFER_TYPE = 'pullreview-index'

    def self.call
      new.call
    end

    def call
      pull_requests.each do |pr|
        buffer_print_line("#{ pr.number }: #{ pr.title }")
        buffer_print_line("#{ pr.user_login } #{ pr.labels }")
        buffer_print_line
      end

      disable_modification
    end

    private

    def buffer
      @buffer ||= begin
                    Vim.command 'enew'
                    Vim.command 'setl buftype=nofile'
                    Vim.command "set filetype=#{ BUFFER_TYPE }"
                    Vim::Buffer.current
                  end
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

    def disable_modification
      Vim.command 'set noma'
    end
  end
end
