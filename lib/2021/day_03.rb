module AdventOfCode
  module Challenge2021
    module Day03
      def self.problem_one(values)
        mcb = common_bits(values)
        {
          gamma: mcb.join.to_i(2),
          epsilon: mcb.collect { |b| b.to_i ^ 1 }.join.to_i(2)
        }
      end
      
      def self.common_bits(values, type = :most)
        bits = Array.new(values.first.size) { [0, 0] }
        values.each do |v|
          v.chars.each_with_index { |b,i| bits[i][b.to_i ^ 1] += 1 }
        end
        bits.collect! do |b|
          if b[1] > b[0]
            1
          elsif b[1] == b[0]
            1
          else
            0
          end
        end
        type == :most ? bits : bits.collect { |b| b ^ 1 }
      end
      
      def self.problem_two(values)
        oxygen = values.clone
        i = 0
        until oxygen.size == 1
          bits = common_bits(oxygen)
          oxygen = oxygen.select { |r| r[i].to_i == bits[i] }
          i += 1
        end
        co2 = values.clone
        i = 0
        until co2.size == 1
          bits = common_bits(co2, :least)
          co2 = co2.select { |r| r[i].to_i == bits[i] }
          i += 1
        end
        {
          oxygen: oxygen.first.to_i(2),
          co2: co2.first.to_i(2)
        }
      end
      
      def self.test(values)
        values = values.collect(&:strip)
        one = problem_one(values)
        puts "  Problem One: #{one[:gamma] * one[:epsilon]}"
        two = problem_two(values)
        puts "  Problem Two: #{two[:oxygen] * two[:co2]}"
      end
    end
  end
end
