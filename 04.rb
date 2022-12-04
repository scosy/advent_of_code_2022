def get_overlapping_sections(pairs)
  result_part_one = 0
  result_part_two = 0
  pairs.each do |pair|
    first_sections = to_range(pair[0])
    second_sections = to_range(pair[1])

    result_part_one += 1 if (first_sections - second_sections).empty? || (second_sections - first_sections).empty?
    result_part_two += 1 if (first_sections - second_sections) != first_sections || (second_sections - first_sections) != second_sections
  end
  [result_part_one, result_part_two]
end

def to_range(string)
  num1 = string.split("-")[0]
  num2 = string.split("-")[1]
  [*num1..num2]
end

pairs = []
File.foreach('./inputs/04.txt') { |line| pairs << line.chomp.split(',') }

overlaping_sections = get_overlapping_sections(pairs)

puts overlaping_sections