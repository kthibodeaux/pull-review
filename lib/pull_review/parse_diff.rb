module PullReview
  class ParseDiff
    def initialize(diff)
      @diff = diff
    end

    def mappings
      @mappings ||= parse_diff
    end

    private
    attr_reader :diff

    def parse_diff
      relative_line = 0
      filename = nil
      new_file = false

      {}.tap do |maps|
        diff.split("\n").each.with_index(1) do |line, index|
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
