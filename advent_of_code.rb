require 'date'

module AdventOfCode
  class << self
    private
    
    def set_year(year)
      if year[/^\d+$/] && year.size <= Date.today.year.to_s.size
        const_set(:YEAR, year.to_i)
      else
        raise Exception.new("Invalid year `#{year}`!")
      end
    end
  end

  def self.most_recent_challenge_year
    Date.today.month == 12 ? Date.today.year : Date.today.year - 1
  end

  def self.for_year
    const_get(:"Challenge#{YEAR}")
  end

  def self.day_file(day)
    "data/%d/12-%02d#{EXAMPLE_MODE ? '-example' : ''}.txt" % [YEAR, day]
  end

  def self.for_day(day)
    require './lib/%d/day_%02d' % [YEAR, day]
    for_year.const_get(:"Day#{'%02d' % day}")
  end
  
  def self.run
    puts "Advent of Code #{YEAR}"
    puts "===============#{'=' * YEAR.to_s.size}"
    time = 0
    (1..25).each do |day|
      break if Date.new(YEAR, 12, day) > Date.today

      File.open(day_file(day)) do |f|
        puts "\nDay %02d" % day
        puts '--------'

        challenge = for_day(day)
        times = @mode == :benchmark ? 1_000 : 1
        bmtime = 0
        times.times do
          data = f.readlines(chomp: true)
          t0 = Time.now
          results = challenge.test(data)
          t1 = Time.now
          if @mode == :benchmark
            bmtime += (t1 -t0)
            f.rewind
          else
            results.each_with_index { |r,i| puts "  Problem #{i + 1}: #{r}" }
            puts "  Time: #{t1 - t0}\n"
            time += (t1 - t0)
          end
        end
        if @mode == :benchmark
          bmtime /= 1_000
          puts "  Average Time: #{bmtime}"
          time += bmtime
        end
      end
    end
    puts "\nTotal#{@mode == :benchmark ? ' Average' : ''} Time: #{time}"
  end

  def self.parse_args(args)
    @mode = :run
    i = 0
    while i < args.size
      case args[i]
      when '-y', '--year'
        set_year(args[i + 1])
        i += 1
      when /^(?:--year|-y)=?(.+)$/
        set_year($1)
      when /^\d+$/
        set_year(args[i]) if i == 0
      when '-t', '--test', '-e', '--example'
        const_set(:EXAMPLE_MODE, true)
      when '-b', '--bm', '--benchmark'
        @mode = :benchmark
      end
      i += 1
    end
    const_set(:EXAMPLE_MODE, false) unless const_defined?(:EXAMPLE_MODE)
    const_set(:YEAR, most_recent_challenge_year) unless const_defined?(:YEAR)
  end
end

AdventOfCode.parse_args(ARGV)
AdventOfCode.run
