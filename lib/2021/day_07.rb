module AdventOfCode
  module Challenge2021
    module Day07
      def self.problem_one(values)
        fuel = (0..values.last).collect do |p|
          values.collect { |v| v > p ? v - p : p - v }.sum
        end
        [fuel.index(fuel.min), fuel.min]
      end

      def self.problem_two(values)
        fuel = (0..values.last).collect do |p|
          values.collect do |v|
            shift = v > p ? v - p : p - v
            ((0.5 * (shift ** 2)) + (0.5 * shift)).to_i
          end.sum
        end
        [fuel.index(fuel.min), fuel.min]
      end

      def self.test(values)
        values = values.first.split(',').collect(&:to_i).sort
        puts "  Problem One: #{problem_one(values)}"
        puts "  Problem Two: #{problem_two(values)}"
      end
    end
  end
end
