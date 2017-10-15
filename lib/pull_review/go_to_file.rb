module PullReview
  class GoToFile
    def self.call(current_line_number)
      @current_line_number = current_line_number

      diff_map_location = DiffMap.loaded[current_line_number]

      unless diff_map_location
        Vim.command "echo 'Not on a diff line'"
        return
      end

      Vim.command "vsplit #{ diff_map_location.fetch(:file) }"
    end
  end
end
