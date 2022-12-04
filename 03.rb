def compart_rucksacks(rucksacks)
  rucksacks_comparted = []
  rucksacks.each do |rucksack|
    middle = rucksack.size / 2
    compartment1 = rucksack[0..middle - 1]
    compartment2 = rucksack[middle..rucksack.size - 1]
    rucksacks_comparted << [compartment1, compartment2]
  end
  rucksacks_comparted
end

def get_priorities_misplaced(rucksacks)
  item_types = [*'a'..'z',*'A'..'Z']
  sum = 0
  compart_rucksacks(rucksacks).each do |rucksack|
    rucksack[0].each_char do |item|
      next unless rucksack[1].include?(item)

      sum += item_types.index(item) + 1 
      break
    end
  end
  sum
end

def group_rucksacks(rucksacks)
  rucksacks_grouped = []
  rucksacks.each_slice(3)  { |c| rucksacks_grouped << c }
  rucksacks_grouped
end

def get_priorities_badges(rucksacks)
  item_types = [*'a'..'z',*'A'..'Z']
  sum = 0
  group_rucksacks(rucksacks).each do |group|
    common_item = (group[0].chars & group[1].chars & group[2].chars).join
    sum += item_types.index(common_item) + 1 
  end
  sum
end

rucksacks = []
File.foreach('./inputs/03.txt') { |line| rucksacks << line.chomp }

# Part one
priorities_sum_misplaced = get_priorities_misplaced(rucksacks)
# Part two
priorities_sum_badges = get_priorities_badges(rucksacks)

puts priorities_sum_misplaced.inspect
puts priorities_sum_badges.inspect

# divide lines to get compartments for each rucksack
# find the common item type 
# get the priority and add it to a sum variable