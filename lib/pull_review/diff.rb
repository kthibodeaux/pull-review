module PullReview
  class Diff
    def self.find(number)
      `curl --silent -H "Authorization: token #{ PullReview::TOKEN }" -H "Accept: application/vnd.github.v3.diff" "https://api.github.com/repos/#{ PullReview::REPO }/pulls/#{ number }.diff"`
    end

    def self.parse(diff_contents)
      relative_line = 0
      filename = nil
      new_file = false

      {}.tap do |maps|
        diff_contents.split("\n").each.with_index(1) do |line, index|
          if line.start_with? 'diff --git '
            new_file = true
            next
          end

          if new_file
            if line.start_with? '+++ '
              filename = line.partition('/').last
            end

            if line.start_with? '@@ '
              new_file = false
              relative_line = 0
            end

            next
          end

          relative_line += 1

          maps[index] = {
            line_number: index,
            line: line,
            file: filename,
            relative_line: relative_line
          }
        end
      end
    end
  end
end
