module AdventOfCode
  module Challenge2021
    module Day01
      def self.problem_one(values)
        values.select.with_index { |v,i| i > 0 && values[i - 1] < v }.size
      end
      
      def self.problem_two(values)
        problem_one((2..(values.size - 1)).map { |i| values[(i - 2)..i].sum })
      end
      
      def self.test(values)
        values = values.collect(&:to_i)
       [problem_one(values), problem_two(values)]
      end
    end
  end
end
