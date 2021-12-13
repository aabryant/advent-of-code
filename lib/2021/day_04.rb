module AdventOfCode
  module Challenge2021
    module Day04
      class BingoBoard
        def initialize(values)
          @rows = values
          @cols = (0...@rows[0].size).collect do |c|
            (0...@rows.size).collect do |r|
              @rows[r][c]
            end
          end
        end

        def has_bingo?(values)
          @rows.any? { |r| (r - values).empty? } ||
          @cols.any? { |c| (c - values).empty? }
        end
        
        def score(values)
          score_rows = @rows.collect { |r| r - values }
          score_rows.flatten.sum * values.last
        end
        
        def to_s
          @rows.map { |r| r.map { |s| '% 2d' % s }.join(' ') }.join("\n")
        end
      end
      
      def self.read_bingo(values)
        calls = values.shift.split(',').collect(&:to_i)
        values.shift
        boards = []
        until values.empty?
          boards << BingoBoard.new(
            5.times.collect { values.shift.split.collect(&:to_i) }
          )
          values.shift
        end
        [calls, boards]
      end

      def self.problem_one(values)
        calls, boards = *read_bingo(values)
        called = []
        until calls.empty?
          called << calls.shift
          if (winner = boards.find { |b| b.has_bingo?(called) })
            return winner.score(called)
          end
        end
      end

      def self.problem_two(values)
        calls, boards = *read_bingo(values)
        called = []
        winners = []
        last_with_winner = 0
        until calls.empty?
          called << calls.shift
          unless (won = boards.select { |b| b.has_bingo?(called) }).empty?
            boards -= won
            winners.concat(won)
            last_with_winner = called.size
          end
        end
        called.pop(called.size - last_with_winner)
        winners.last&.score(called)
      end

      def self.test(values)
        [problem_one(values.clone), problem_two(values)]
      end
    end
  end
end
