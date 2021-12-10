module AdventOfCode
  module Challenge2021
    module Day10
      def self.problem_one(values)
        values.collect { |v| score_line(v) }.sum
      end
      
      OPENINGS = {
        ')' => '(',
        ']' => '[',
        '}' => '{',
        '>' => '<'
      }
      CLOSINGS = OPENINGS.invert
      
      FAILURE_SCORES = {
        ')' => 3,
        ']' => 57,
        '}' => 1197,
        '>' => 25137
      }
      
      COMPLETION_SCORES = {
        ')' => 1,
        ']' => 2,
        '}' => 3,
        '>' => 4
      }
      
      def self.score_line(line)
        chars = line.chars
        stack = []
        until chars.empty?
          char = chars.shift
          if (open = OPENINGS[char])
            return FAILURE_SCORES[char] if open != stack.pop
          else
            stack << char
          end
        end
        0
      end

      def self.problem_two(values)
        results = values.collect do |v|
          score_line(v) == 0 ? repair_line(v) : nil
        end.compact.sort
        results[results.size / 2]
      end
      
      def self.repair_line(line)
        chars = line.chars
        stack = []
        until chars.empty?
          char = chars.shift
          if (open = OPENINGS[char])
            return FAILURE_SCORES[char] if open != stack.pop
          else
            stack << char
          end
        end
        score = 0
        until stack.empty?
          score *= 5
          score += COMPLETION_SCORES[CLOSINGS[stack.pop]]
        end
        score
      end

      def self.test(values)
        puts "  Problem One: #{problem_one(values)}"
        puts "  Problem Two: #{problem_two(values)}"
      end
    end
  end
end
