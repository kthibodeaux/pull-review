module PullReview
  class View::Labels
    include Bufferable

    def call
      Vim.command 'tab new'
      write_labels_to_buffer
      highlight_active_labels
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

    def current_labels
      url = "#{PullReview::PullRequest.loaded.fetch('issue_url')}/labels"

      JSON
        .parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "#{url}"`)
        .map { |e| e.fetch('name') }
    end

    def highlight_active_labels
      current = current_labels

      (1...Vim::Buffer.current.count).each do |line_number|
        label = Vim::Buffer.current[line_number]
        if current.include?(label)
          mark_label_active(line_number)
        else
          mark_label_inactive(line_number)
        end
      end
    end

    def mark_label_active(line_number)
      Vim.command "sign place #{line_number} line=#{line_number} name=pullreviewlabelactive buffer=#{ Vim::Buffer.current.number }"
    end

    def mark_label_inactive(line_number)
      Vim.command "sign unplace #{line_number} buffer=#{ Vim::Buffer.current.number }"
    end

    def create_maps
      # Vim.command 'nnoremap <buffer> <silent> <CR> :call pullreview#toggle_label()<CR>'
    end
  end
end
