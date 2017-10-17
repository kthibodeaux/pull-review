module PullReview
  class View::PullRequestList
    include Bufferable

    def self.call
      new.call
    end

    def call
      Vim.command 'tab new'
      modify do
        pull_requests.each do |pr|
          buffer_print_line("#{ pr.fetch('number') }: #{ pr.fetch('title') }")
          buffer_print_line("#{ pr.fetch('user').fetch('login') } #{ format_labels(pr.fetch('labels')) }")
          buffer_print_line
        end
      end

      create_maps
    end

    private

    def create_maps
      Vim.command 'nnoremap <buffer> <silent> <CR> :call pullreview#show_pull_request()<CR>'
      Vim.command 'nnoremap <buffer> <silent> r :bd!<CR>:call pullreview#show_pull_request_list()<CR>'
    end

    def pull_requests
      JSON
        .parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "https://api.github.com/repos/#{ PullReview::REPO }/issues"`)
        .select { |e| e.has_key?('pull_request') }
    end

    def format_labels(labels)
      labels
        .map { |e| "[ #{ e.fetch('name') } ]" }
        .join(' ')
    end
  end
end
