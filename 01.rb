def get_calories(array)
  newlines = array.each_index.select{|i| array[i] == "\n"}
  
  calories = []
  
  newlines.each_with_index do |newline, index|
    if index.zero?
      calories << array[0..newline - 1].map(&:to_i).sum
    else
      calories << array[newlines[index - 1] + 1..newline - 1].map(&:to_i).sum
    end
  end

  calories
end

elves_carrying = []
File.foreach('./inputs/01.txt') { |line| elves_carrying << line }

elves_total_calories = get_calories(elves_carrying)

p elves_total_calories.max
p elves_total_calories.max(3).sum