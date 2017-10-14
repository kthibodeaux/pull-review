module PullReview
  class GetIndex
    include Bufferable

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

      create_maps
    end

    private

    def create_maps
      Vim.command 'nnoremap <buffer> <CR> :call pullreview#get_pull_request()<CR>'
    end

    def pull_requests
      PullRequest.all
    end
  end
end
