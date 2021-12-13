module AdventOfCode
  module Challenge2021
    module Day08
      def self.problem_one(values)
        values.inject(0) do |count, inputs|
          count + inputs[1].count { |i| [2, 3, 4, 7].include?(i.size) }
        end
      end
      
      def self.find_connections(values)
        connections = {}
        data = values.collect { |v| v.each_char.to_a }.group_by { |v| v.size }
        connections[:a] = (data[3].first - data[2].first).first
        six = data[6].find { |d| (d - data[2].first).size == 5 }
        gfinder = [*data[4].first, connections[:a]]
        nine = data[6].find { |d| (d - gfinder).size == 1 }
        two = nil
        if nine
          two = data[5].find { |d| (d - nine).size == 1 }
          connections[:e] = (six - nine).first
          connections[:g] = (nine - gfinder).first
        else
          fiveorthree = data[5].find { |d| (d - gfinder).size == 1 }
          connections[:g] = (fiveorthree - gfinder).first
          nine = gfinder + [connections[:g]]
          two = data[5].find { |d| (d - nine).size == 1 }
          connections[:e] = (six - nine).first
        end
        connections[:c] = (data[2].first - six).first
        connections[:f] = (data[2].first - [connections[:c]]).first
        dfinder = [
          connections[:a],
          connections[:c],
          connections[:e],
          connections[:g]
        ]
        connections[:d] = (two - dfinder).first
        connections[:b] = (data[7].first - connections.values).first
        connections.invert
      end

      def self.problem_two(values)
        digits = {
          [:a, :b, :c, :e, :f, :g] => 0,
          [:c, :f] => 1,
          [:a, :c, :d, :e, :g] => 2,
          [:a, :c, :d, :f, :g] => 3,
          [:b, :c, :d, :f] => 4,
          [:a, :b, :d, :f, :g] => 5,
          [:a, :b, :d, :e, :f, :g] => 6,
          [:a, :c, :f] => 7,
          [:a, :b, :c, :d, :e, :f, :g] => 8,
          [:a, :b, :c, :d, :f, :g] => 9
        }
        values.collect do |inputs|
          connections = find_connections(inputs.flatten)
          inputs[1].collect do |i|
            digits[i.each_char.collect { |c| connections[c] }.sort]
          end.join.to_i
        end.sum
      end

      def self.test(values)
        values.collect!(&:split).collect! do |value|
          split = value.index('|')
          [value[0...split], value[(split + 1)..]]
        end
        [problem_one(values), problem_two(values)]
      end
    end
  end
end
