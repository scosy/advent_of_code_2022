def get_number_of_visible_trees(array)
  visible_trees = get_visible_trees(array)
  visible_trees.flatten.count { |n| n == 1 }
end

def get_highest_scenic_score(array)
  all_scores = []
  array.each_with_index do |row, i|
    row.each_with_index do |tree, j|
      scores = []
      column = array.transpose[j]
      score = 0
      row[0...j].reverse.each { |n| score += 1; break if n >= tree } 
      scores << score

      score = 0
      row[j+1..row.size].each { |n| score += 1; break if n >= tree }
      scores << score
      
      score = 0
      column[0...i].reverse.each { |n| score += 1; break if n >= tree }
      scores << score
      
      score = 0
      column[i+1..column.size].each { |n| score += 1; break if n >= tree }
      
      scores << score
      all_scores << scores
    end
  end
  all_scores.map{ |s| s.reduce(:*) }.max
end

def get_visible_trees(array)
  array.map.with_index do |row, i|
    row.map.with_index do |tree, j|
      column = array.transpose[j]
      i.zero? ||
      j.zero? ||
      i == array.size - 1 ||
      j == row.size - 1 ||
      row[0...j].max < tree ||
      row[j+1..-1].max < tree ||
      column[0...i].max < tree ||
      column[i+1..-1].max < tree ?
        1 : 0
    end
  end
end

grid = []
File.foreach("./inputs/08.txt") { |line| grid << line.chomp.chars.map(&:to_i) }

# p get_number_of_visible_trees(grid)

p get_highest_scenic_score(grid)