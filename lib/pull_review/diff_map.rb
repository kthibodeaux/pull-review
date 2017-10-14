module PullReview
  class DiffMap
    def self.load_from_loaded_diff
      @loaded = self.parse(Diff.loaded)
    end

    def self.loaded
      @loaded
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
            next if line == '--- /dev/null'
            next if line == '+++ /dev/null'

            if line.start_with? '--- '
              filename = line.partition('/').last
            end

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
