module PullReview
  class CurrentLabels
    def self.load
      @loaded = JSON
        .parse(`curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "#{labels_url}"`)
        .map { |e| e.fetch('name') }
    end

    def self.loaded
      @loaded
    end

    def self.toggle(label)
      if loaded.include?(label)
        command = %Q{curl -X DELETE -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" "#{labels_url}/#{label.gsub(' ', '%20')}"}
        @loaded.delete(label)
      else
        command = %Q{curl -H "Authorization: token #{ PullReview::TOKEN }" -H "Content-Type: application/json" -d '#{ [ label ] }' "#{labels_url}"}
        @loaded << label
      end

      `#{command}`
      highlight_active_labels
    end

    def self.highlight_active_labels
      (1...Vim::Buffer.current.count).each do |line_number|
        label = Vim::Buffer.current[line_number]
        if loaded.include?(label)
          mark_label_active(line_number)
        else
          mark_label_inactive(line_number)
        end
      end
    end

    def self.mark_label_active(line_number)
      Vim.command "sign place #{line_number} line=#{line_number} name=pullreviewlabelactive buffer=#{ Vim::Buffer.current.number }"
    end

    def self.mark_label_inactive(line_number)
      Vim.command "sign unplace #{line_number} buffer=#{ Vim::Buffer.current.number }"
    end

    def self.labels_url
      "#{PullReview::PullRequest.loaded.fetch('issue_url')}/labels"
    end
  end
end
