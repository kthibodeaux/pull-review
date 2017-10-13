module PullReview
  class GetPullRequest
    include Bufferable
    BUFFER_TYPE = 'pullreview-pull-request'

    def self.call
      new.call
    end

    def call
      if line_contains_pr_number?
        modify do
          changes.each do |change|
            buffer_print_line change.fetch('filename')
            change.fetch('patch').split("\n").each do |patch_line|
              buffer_print_line patch_line
            end
            buffer_print_line

          end
        end
      else
        Vim.command "echo 'No pull request found in #{ line }'"
      end
    end

    private
    attr_reader :line

    def changes
      PullReview::ModifiedFiles.new(number).changes
    end

    def line
      @line ||= Vim::Buffer.current.line
    end

    def line_contains_pr_number?
      line.include?(':')
    end

    def number
      line.split(':').first
    end
  end
end
