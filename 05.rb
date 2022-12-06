def sort_drawing_stacks(array)
  stacks = {}
  number_stacks = array[-1].split(' ')
  crates = array[0..-2]
  number_stacks.each { |stackn| stacks[stackn] = "" }
  # return hash with stack number as key and array of crates as value
  ind_crate = 0
  stacks.each_key do |key|
    crates.each_with_index do |crate, index|
      stacks[key] << crate[ind_crate..ind_crate + 2]
    end
    ind_crate += 4
  end
  stacks.transform_values { |string| string.strip }
end

def move_crates(hash, instructions)
  instructions.each do |instruction|
    quantity = instruction.split(' ')[1].to_i
    from = instruction.split(' ')[3]
    to = instruction.split(' ')[5]

    # Part one
    quantity.times do
      hash[to].prepend(hash[from].slice!(0..2))
    end
    # Part two
    # hash[to].prepend(hash[from].slice!(0..quantity * 3 - 1))
  end
  message = ""
  hash.each_value { |value| message << value[1] }
  message
end

drawing = []
instructions = []
File.foreach('./inputs/05.txt').with_index { |line, index| index <= 8 ? drawing << line.chomp : instructions << line.chomp }
instructions.shift

sorted_stacks = move_crates(sort_drawing_stacks(drawing), instructions)

puts sorted_stacks
