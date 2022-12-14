def parse_signal_part_one(signal)
  signal.map(&method(:eval)).compact.each_slice(2).to_a
end

def parse_signal_part_two(signal)
  signal.map(&method(:eval)).compact << [[2]] << [[6]]
end

def compare_pairs(pairs)
  indexes = []
  pairs.each_with_index do |(left, right), index|
    indexes << index + 1 if valid(left, right)
  end
  indexes.sum
end

def sort_packets(packets)
  packets.sort! { |a, b| valid(a, b) ? -1 : 1 }
         .each_index.select { |ind| packets[ind] == [[2]] || packets[ind] == [[6]] }
         .map { |el| el + 1 }.reduce(:*)
end

def valid(left, right)
  return nil if left.empty? && right.empty?
  return true if left.empty?
  return false if right.empty?

  l_head, *l_tail = left
  r_head, *r_tail = right
  case [l_head, r_head]
  in [Integer, Integer]
    return true if l_head < r_head
    return false if l_head > r_head
  in [Array, Array]
    result = valid(l_head, r_head)
  in [Array, Integer]
    result = valid(l_head, [r_head])
  in [Integer, Array]
    result = valid([l_head], r_head)
  end

  result.nil? ? valid(l_tail, r_tail) : result
end
file = './inputs/13.txt'
unless File.read(file).empty?
  input = []
  File.foreach(file) { |line| input << line.chomp }
else
  input = DATA.readlines(chomp: true)
end

puts compare_pairs(parse_signal_part_one(input))
puts sort_packets(parse_signal_part_two(input))
__END__
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]