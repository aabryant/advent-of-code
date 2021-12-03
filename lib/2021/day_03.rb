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
        mcb = Array.new(values.first.size) { [0, 0] }
        keep = type == :most ? 1 : 0
        values.each { |v| v.each_char.with_index { |b,i| mcb[i][b.to_i] += 1 } }
        mcb.collect! { |b| b[0] == b[1] ? keep : b.index(b.max) ^ 1 }
        type == :most ? mcb : mcb.collect { |b| b ^ 1 }
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
