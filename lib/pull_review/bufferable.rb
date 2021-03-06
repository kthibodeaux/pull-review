module PullReview
  module Bufferable
    private

    def buffer
      @buffer ||= begin
                    Vim.command 'enew'
                    Vim.command 'setlocal buftype=nofile'
                    set_buffer_filetype
                    Vim.command 'setlocal noma'
                    Vim::Buffer.current
                  end
    end

    def modify(&block)
      preload_buffer

      Vim.command 'setlocal ma'
      yield
      Vim.command 'setlocal noma'
    end

    def set_buffer_filetype
      return unless self.class.const_defined?('BUFFER_TYPE')
      Vim.command "setlocal filetype=#{ self.class::BUFFER_TYPE }"
    end

    def buffer_print_line(string = '')
      buffer.append(last_line, string)
    end

    def last_line
      buffer.length - 1
    end

    def preload_buffer
      buffer
    end
  end
end
