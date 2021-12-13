module AdventOfCode
  module Challenge2021
    module Day05
      def self.problem_one(values)
        coords = get_coordinates(values)
        map = make_map(coords)
        coords.select! { |pos| pos[:x1] == pos[:x2] || pos[:y1] == pos[:y2] }
        coords.each { |pos| each_coordinate(pos) { |x, y| map[y][x] += 1 } }
        map.inject(0) { |c, r| c + r.count { |s| s > 1 } }
      end
      
      def self.get_coordinates(values)
        values.collect do |line|
          line[/^(\d+),(\d+) -> (\d+),(\d+)$/]
          { x1: $1.to_i, y1: $2.to_i, x2: $3.to_i, y2: $4.to_i }
        end
      end
      
      def self.each_coordinate(pos)
        if pos[:x1] == pos[:x2] || pos[:y1] == pos[:y2]
          lx, ly = [pos[:x1], pos[:x2]].sort, [pos[:y1], pos[:y2]].sort
          (lx[0]..lx[1]).each { |x| (ly[0]..ly[1]).each { |y| yield x, y } }
        else
          x, y = pos[:x1], pos[:y1]
          loop do
            yield x, y
            if pos[:x1] < pos[:x2] then break if (x += 1) > pos[:x2]
            else break if (x -= 1) < pos[:x2] end
            if pos[:y1] < pos[:y2] then break if (y += 1) > pos[:y2]
            else break if (y -= 1) < pos[:y2] end
          end
        end
      end
      
      def self.make_map(coords)
        sz = coords.max_by { |c| c.values.max }.values.max + 1
        map = Array.new(sz) { [0] * sz }
      end

      def self.problem_two(values)
        coords = get_coordinates(values)
        map = make_map(coords)
        coords.each { |pos| each_coordinate(pos) { |x, y| map[y][x] += 1 } }
        map.inject(0) { |c, r| c + r.count { |s| s > 1 } }
      end

      def self.test(values)
        [problem_one(values.clone), problem_two(values)]
      end
    end
  end
end
