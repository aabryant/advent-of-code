require 'date'

module AdventOfCode2021
  module Day01
    def self.problem_one(values)
      values.select.with_index { |v,i| i > 0 && values[i - 1] < v }.size
    end
    
    def self.problem_two(values)
      problem_one(
        (2..(values.size - 1)).collect { |i| values[(i - 2)..i].sum }
      )
    end
    
    def self.test(values)
      values = values.collect(&:to_i)
      puts "Day One Problem One: #{problem_one(values)}"
      puts "Day One Problem Two: #{problem_two(values)}"
    end
  end
  
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

def day_file(day)
  "2021/12-%02d#{ARGV[0] == '--test' ? '-example' : ''}.txt" % day
end

def day_module(day)
  AdventOfCode2021.const_get(:"Day#{'%02d' % day}")
end

(1..25).each do |day|
  break if Date.new(2021, 12, day) > Date.today

  File.open(day_file(day)) do |f|
    day_module(day).test(f.readlines)
  end
end
