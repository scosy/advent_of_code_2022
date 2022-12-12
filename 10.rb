require 'rspec/autorun'

def parse_instructions(input)
  input.split("\n")
end

def calculate_sum_of_signals(instructions)
  interesting_signals_strengths = [20, 60, 100, 140, 180, 220]
  signals, sum_signals = [], []
  cycle = 0
  x = 1
  crt = Hash.new { |k, v| k[v] = [] }
  instructions.each do |instruction|
    v = crt.keys.size > 1 ? crt.keys.last.split("-")[0].to_i - 1 : 0
    cycle += 1
    signals << [x, cycle]
    position = cycle - v - 1
    pixel = [*position - 1..position + 1].include?(x) ? "#" : "."
    get_pixel(cycle, crt, pixel)
    unless instruction.start_with?("noop")        
      cycle += 1
      signals << [x, cycle]
      position = cycle - v - 1
      pixel = [*position - 1..position + 1].include?(x) ? "#" : "."
      get_pixel(cycle, crt, pixel)
      x += instruction.split(" ")[1].to_i
    end
  end
  interesting_signals_strengths.each do |signal|
    sum_signals << signals.find { |v| v[1] == signal }.reduce(:*)
  end
  crt.each_value { p _1.join }
  sum_signals.sum
end

def get_pixel(cycle, crt, pixel)
  case cycle
    in 1..40 then crt["1-40"] << pixel
    in 41..80 then crt["41-80"] << pixel
    in 81..120 then crt["81-120"] << pixel
    in 121..160 then crt["121-160"] << pixel
    in 161..200 then crt["161-200"] << pixel
    in 201..240 then crt["201-240"] << pixel
  end
end

input = File.read('./inputs/10.txt')

if input.empty?
  RSpec.describe do
    before(:all) do
      @input = DATA.read
    end
    it "parses the input" do
      expect(parse_instructions(@input)).to eq(["addx 15", "addx -11", "addx 6", "addx -3", "addx 5", "addx -1", "addx -8", "addx 13", "addx 4", "noop", "addx -1", "addx 5", "addx -1", "addx 5", "addx -1", "addx 5", "addx -1", "addx 5", "addx -1", "addx -35", "addx 1", "addx 24", "addx -19", "addx 1", "addx 16", "addx -11", "noop", "noop", "addx 21", "addx -15", "noop", "noop", "addx -3", "addx 9", "addx 1", "addx -3", "addx 8", "addx 1", "addx 5", "noop", "noop", "noop", "noop", "noop", "addx -36", "noop", "addx 1", "addx 7", "noop", "noop", "noop", "addx 2", "addx 6", "noop", "noop", "noop", "noop", "noop", "addx 1", "noop", "noop", "addx 7", "addx 1", "noop", "addx -13", "addx 13", "addx 7", "noop", "addx 1", "addx -33", "noop", "noop", "noop", "addx 2", "noop", "noop", "noop", "addx 8", "noop", "addx -1", "addx 2", "addx 1", "noop", "addx 17", "addx -9", "addx 1", "addx 1", "addx -3", "addx 11", "noop", "noop", "addx 1", "noop", "addx 1", "noop", "noop", "addx -13", "addx -19", "addx 1", "addx 3", "addx 26", "addx -30", "addx 12", "addx -1", "addx 3", "addx 1", "noop", "noop", "noop", "addx -9", "addx 18", "addx 1", "addx 2", "noop", "noop", "addx 9", "noop", "noop", "noop", "addx -1", "addx 2", "addx -37", "addx 1", "addx 3", "noop", "addx 15", "addx -21", "addx 22", "addx -6", "addx 1", "noop", "addx 2", "addx 1", "noop", "addx -10", "noop", "noop", "addx 20", "addx 1", "addx 2", "addx 2", "addx -6", "addx -11", "noop", "noop", "noop"])
    end

    it "calculates the sum of signals" do
      expect(calculate_sum_of_signals(parse_instructions(@input))).to eq(13140)
    end
  end
else
  puts calculate_sum_of_signals(parse_instructions(input))
end

__END__
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop