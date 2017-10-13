module PullReview
  module Bufferable
    private

    def buffer
      @buffer ||= begin
                    Vim.command 'enew'
                    Vim.command 'setl buftype=nofile'
                    Vim.command "set filetype=#{ self.class::BUFFER_TYPE }"
                    Vim.command 'set noma'
                    Vim::Buffer.current
                  end
    end

    def modify(&block)
      preload_buffer

      Vim.command 'set ma'
      yield
      Vim.command 'set noma'
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

    def preload_buffer
      buffer
    end
  end
end
