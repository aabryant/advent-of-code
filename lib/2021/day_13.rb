module AdventOfCode
  module Challenge2021
    module Day13
      def self.problem_one(dots, folds)
        map = create_map(dots)
        fold(map, *folds.first).flatten.count(&:itself)
      end
      
      def self.create_map(dots)
        height = dots.max_by { |d| d[1] }[1] + 1
        width = dots.max_by { |d| d[0] }[0] + 1
        map = Array.new(height) { Array.new(width) { false } }
        dots.each { |dot| map[dot[1]][dot[0]] = true }
        map
      end

      def self.fold(map, direction, point)
        if direction == :y
          map.pop(point + 1).each_with_index do |row, y|
            next if y == 0

            row.each_with_index { |dot, x| map[map.size - y][x] ||= dot }
          end
        elsif direction == :x
          map.each do |row|
            row.pop(point + 1).each_with_index do |dot, x|
              next if x == 0

              row[row.size - x] ||= dot
            end
          end
        end
        map
      end

      def self.problem_two(dots, folds)
        map = create_map(dots)
        folds.each do |fold|
          fold(map, *fold)
        end
        map.each { |r| puts r.collect { |d| d ? '#' : '.' }.join }
        nil
      end

      def self.test(values)
        dots = values.take_while { |v| !v.empty? }
        dots.collect! { |d| d.split(',').collect(&:to_i) }
        folds = values[dots.size..].collect do |v|
          next nil if v.empty?

          v[/(x|y)=(\d+)/i]
          [$1.to_sym, $2.to_i]
        end.compact
        [problem_one(dots, folds), problem_two(dots, folds)]
      end
    end
  end
end
