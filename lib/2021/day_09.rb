module AdventOfCode
  module Challenge2021
    module Day09
      def self.problem_one(values)
        x = low_points(height_map(values)).inject(0) { |r,l| r + l + 1 }
      end
      
      def self.height_map(values)
        values.collect { |v| v.split('').collect(&:to_i) }
      end
      
      def self.low_points(map)
        map.collect.with_index do |row, y|
          row.select.with_index do |height, x|
            next false unless map[y - 1][x] > height if y > 0
            next false unless map[y + 1][x] > height if y < map.size - 1
            next false unless row[x - 1] > height if x > 0
            next false unless row[x + 1] > height if x < row.size - 1
            true
          end
        end.flatten
      end
      
      def self.problem_two(values)
        basins(height_map(values))
          .map(&:size)
          .sort
          .reverse[0..2]
          .inject(1) { |r, s| r * s }
      end
      
      def self.basins(map)
        basins = []
        map.each_with_index do |row, y|
          row.each_with_index do |height, x|
            next if height == 9

            basin_configs = []
            basin_configs << [y - 1, x] if y > 0
            basin_configs << [y, x - 1] if x > 0
            if y > 0 && x + 1 < row.size && row[x + 1] < 9
              basin_configs << [y - 1, x + 1]
            end
            opt = basins.select { |b| basin_configs.any? { |c| b.dig(*c) } }
            if opt.size > 1
              basin = opt.shift
              opt.each do |o|
                deep_merge(basin, o)
                basins.delete(o)
              end
            else
              basin = opt.first
            end
            basins << (basin = {}) unless basin
            (basin[y] ||= {})[x] = true
          end
        end
        basins.collect do |basin|
          basin.collect { |y, row| row.keys.map { |x| [y, x] } }.flatten(1)
        end
      end
      
      def self.deep_merge(hash1, hash2)
        hash2.each_pair do |k,v|
          if (value = hash1[k])
            value.merge!(v) if value.is_a?(Hash)
          else
            hash1[k] = v
          end
        end
      end
      
      def self.test(values)
        [problem_one(values), problem_two(values)]
      end
    end
  end
end
