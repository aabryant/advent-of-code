module AdventOfCode
  module Challenge2021
    module Day06
      class School
        def initialize(ages)
          @fish = ages.to_a.sort_by { |f| f[0] }
        end
        
        def age(days)
          days.times do
            babies = 0
            @fish.each do |fishy|
              fishy[0] -= 1
              if fishy[0] < 0
                babies += fishy[1]
                fishy[0] = 6
              end
            end
            consolidate
            @fish << [8, babies] if babies > 0
          end
        end

        def consolidate
          @fish = @fish.group_by { |f| f[0] }.each_pair.map do |age, fishies|
            [age, fishies.sum { |f| f[1] }]
          end
        end

        def count
          @fish.sum { |fishy| fishy[1] }
        end
      end

      def self.problem(values, days)
        school = School.new(values)
        school.age(days)
        school.count
      end

      def self.test(values)
        base = Hash.new { |h, k| h[k] = 0 }
        values.first.split(',').each { |v| base[v.to_i] += 1 }
        puts "  Problem One: #{problem(base, 80)}"
        puts "  Problem Two: #{problem(base, 256)}"
      end
    end
  end
end
