module AdventOfCode
  module Challenge2021
    module Day02
      def self.problem_one(values)
        values.inject({ depth: 0, horizontal: 0 }) do |position, change|
          case change
          when /forward (\d+)/
            position[:horizontal] += $1.to_i
          when /down (\d+)/
            position[:depth] += $1.to_i
          when /up (\d+)/
            position[:depth] -= $1.to_i
          end
          position
        end
      end
      
      def self.problem_two(values)
        values.inject({ depth: 0, horizontal: 0, aim: 0 }) do |position, change|
          case change
          when /forward (\d+)/
            position[:horizontal] += $1.to_i
            position[:depth] += position[:aim] * $1.to_i
          when /down (\d+)/
            position[:aim] += $1.to_i
          when /up (\d+)/
            position[:aim] -= $1.to_i
          end
          position
        end
      end
      
      def self.test(values)
        one = problem_one(values)
        puts "Day Two Problem One: #{one[:horizontal] * one[:depth]}"
        two = problem_two(values)
        puts "Day Two Problem Two: #{two[:horizontal] * two[:depth]}"
      end
    end
  end
end
