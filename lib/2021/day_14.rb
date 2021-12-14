module AdventOfCode
  module Challenge2021
    module Day14
      def self.problem_one(template, rules)
        counts = apply_pair_insertions(template, rules, 10)
        counts.values.max - counts.values.min
      end
      
      def self.apply_pair_insertions(template, rules, count)
        counts = {
          pairs: Hash.new(0),
          elements: Hash.new(0)
        }
        template.each { |e| counts[:elements][e] += 1 }
        template.each_cons(2) { |p| counts[:pairs][p.join] += 1 }
        count.times do
          counts[:pairs].clone.each_pair do |pair, count|
            next unless element = rules[pair]

            counts[:elements][element] += count
            counts[:pairs][pair] -= count
            counts[:pairs]["#{pair[0]}#{element}"] += count
            counts[:pairs]["#{element}#{pair[1]}"] += count
          end
        end
        counts[:elements]
      end

      def self.problem_two(template, rules)
        counts = apply_pair_insertions(template, rules, 40)
        counts.values.max - counts.values.min
      end

      def self.test(values)
        template = values.shift.chars
        rules = {}
        values.collect { |v| v.split(' -> ') }.each do |rule|
          next if rule.empty?

          rules[rule.first] = rule.last
        end
        [problem_one(template.clone, rules), problem_two(template, rules)]
      end
    end
  end
end
