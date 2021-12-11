module AdventOfCode
  module Challenge2021
    module Day11
      class Octopus
        attr_reader :energy
        attr_reader :step

        def initialize(energy = 0)
          @energy = energy
          @step = -1
        end

        #def increment
        #  @energy += 1
        #end

        def flashed?(step)
         step == @step
        end

        def flash?(step)
          return 0 if step == @step

          @energy += 1

          if @energy > 9
            @energy = 0
            @step = step
          end

          @energy == 0 ? 1 : nil
        end
      end

      def self.problem_one(values)
        octopuses = values.collect do |v|
          v.split('').collect { |e| Octopus.new(e.to_i) }
        end
        flashes = 0
        100.times do |step|
          octopuses.each_with_index do |row, y|
            row.each_with_index do |octopus, x|
              flashes += flash(octopuses, y, x, step)
            end
          end
        end
        flashes
      end
      
      def self.flash(octopuses, y, x, step)
        return 0 if octopuses[y][x].flashed?(step)

        flashes = 0
        if octopuses[y][x].flash?(step)
          flashes += 1
          ygz = y > 0
          xgz = x > 0
          yls = y < octopuses.size - 1
          xls = x < octopuses[0].size - 1
          [
            ygz ? [y - 1, x] : nil,
            yls ? [y + 1, x] : nil,
            xgz ? [y, x - 1] : nil,
            xls ? [y, x + 1] : nil,
            ygz && xgz ? [y - 1, x - 1] : nil,
            ygz && xls ? [y - 1, x + 1] : nil,
            yls && xgz ? [y + 1, x - 1] : nil,
            yls && xls ? [y + 1, x + 1] : nil
          ].compact.each do |coords|
            unless octopuses[coords[0]][coords[1]].flashed?(step)
              flashes += flash(octopuses, *coords, step)
            end
          end
        end
        flashes
      end

      def self.problem_two(values)
        octopuses = values.collect do |v|
          v.split('').collect { |e| Octopus.new(e.to_i) }
        end
        count = octopuses.flatten.size
        step = 0
        loop do
          flashes = 0
          octopuses.each_with_index do |row, y|
            row.each_with_index do |octopus, x|
              flashes += flash(octopuses, y, x, step)
            end
          end
          return step + 1 if flashes == count
          step += 1
        end
      end

      def self.test(values)
        puts "  Problem One: #{problem_one(values)}"
        puts "  Problem Two: #{problem_two(values)}"
      end
    end
  end
end
