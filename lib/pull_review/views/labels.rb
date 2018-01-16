module PullReview
  class View::Labels
    include Bufferable

    def call
      Vim.command 'tab new'
      write_labels_to_buffer
      PullReview::CurrentLabels.highlight_active_labels
      create_maps
    end

    private

    def pull_request
      PullReview::PullRequest.loaded
    end

    def write_labels_to_buffer
      modify do
        all_labels.each do |label|
          buffer_print_line label
        end
      end
    end

    def all_labels
      PullReview::GetAllLabels.call
    end

    def create_maps
      Vim.command 'nnoremap <buffer> <silent> <CR> :call pullreview#toggle_label()<CR>'
    end
  end
end
