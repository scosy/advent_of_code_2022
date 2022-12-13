def parse_grid(grid)
  last_cell = nil
  neighbors = []
  distances = {}
  grid.map!.with_index do |row, i|
    row.chars.map!.with_index do |cell, j|
      if cell == "S" || cell == "a"
        distances[[i, j]] = 0
        neighbors << [i, j]
        1 
      elsif cell == "E"
        last_cell = [i, j]
        26
      else
        cell.ord - "a".ord + 1
      end
    end
  end
  [grid, last_cell, neighbors, distances]
end

def shortest_path(input)
  grid, last, neighbors, distances = parse_grid(input)
  until neighbors.empty?
    x, y = neighbors.shift
    distance = distances[[x, y]]

    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dx, dy|
      nx, ny = x + dx, y + dy
      if nx.between?(0, grid.size - 1) && ny.between?(0, grid.first.size - 1) && grid[nx][ny] <= grid[x][y] + 1
        if distances[[nx, ny]].nil? || distances[[nx, ny]] > distance + 1
          neighbors << [nx, ny]
          distances[[nx, ny]] = distance + 1
        end
      end
    end
  end
  distances[last]
end

def neighbors(grid, cell)
  current = grid[cell[0]][cell[1]]
  r = [cell[0], cell[1] + 1]
  d = [cell[0] + 1, cell[1]]
  l = [cell[0], cell[1] - 1]
  u = [cell[0] - 1, cell[1]]
  if cell[0].zero? && cell[1].zero?
    if grid[d[0]][d[1]] == current || grid[d[0]][d[1]] == current + 1
    end
    [d, r]
  elsif cell[0].zero?
    [d, l, r]
  elsif cell[1].zero?
    [u, d, r]
  else
    [u, d, l, r]
  end
end

file = './inputs/12.txt'
unless File.read(file).empty?
  input = []
  File.foreach(file) { |line| input << line.chomp }
else
  input = DATA.readlines(chomp: true)
end

puts shortest_path(input)

# parse grid to display heights instead of letters and mark first cell and the one to go to X
# create a method to visit cell if height allows to
# when we have a choice between multiple cells, we mark it's coordinates
# if we cannot visit adjacent cells no more, we start again from the first cell and avoid cells already visited
# keep track of number of steps
# 
__END__
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi