module PullReview
  module Bufferable
    private

    def buffer
      @buffer ||= begin
                    Vim.command 'enew'
                    Vim.command 'setl buftype=nofile'
                    set_buffer_filetype
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

    def set_buffer_filetype
      return unless self.class.const_defined?('BUFFER_TYPE')
      Vim.command "set filetype=#{ self.class::BUFFER_TYPE }"
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
