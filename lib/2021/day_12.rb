module AdventOfCode
  module Challenge2021
    module Day12
      require 'set'
      def self.problem_one(values)
        find_paths(map_hash(values))
      end

      def self.map_hash(values)
        map = {}
        values.each do |path|
          start, finish = *path.split('-')
          (map[start] ||= Set.new) << finish
          (map[finish] ||= Set.new) << start
        end
        map
      end

      def self.find_paths(connections, with_dupes = false)
        paths = []
        start = connections['start']
        results = []
        start.each do |node|
          stack = [false, 'start', node]
          results.concat(find_path(connections, stack, with_dupes))
        end
        results
      end

      def self.find_path(connections, stack, with_dupes = false, results = [])
        if stack.last == 'end'
          stack.shift
          results << stack[0..]
          return results
        end

        connections[stack.last]&.each do |n|
          next if n == 'start'

          if stack.include?(n) && n != n.upcase
            next unless with_dupes
            next if stack.first

            new_stack = stack.clone
            new_stack[0] = true
          else
            new_stack = stack.clone
          end

          find_path(connections, new_stack << n, with_dupes, results)
        end
        results
      end

      def self.problem_two(values)
        find_paths(map_hash(values), true)
      end

      def self.test(values)
        [problem_one(values).size, problem_two(values).size]
      end
    end
  end
end
