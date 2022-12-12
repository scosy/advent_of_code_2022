require 'rspec'

def parse_moves(input)
  input
    .split("\n")
    .map { [_1.split(' ')[0], _1.split(' ')[1].to_i] }
end

def move(visited, rope, direction, distance)
  head, _tail = rope
  distance.times do
    case direction
      in "U" then head[0] += 1
      in "D" then head[0] -= 1
      in "L" then head[1] -= 1
      in "R" then head[1] += 1
    end
    rope.each_cons(2) do |h, t|
      follow(h, t)
    end
    visited << rope.last.dup
  end
  rope
end

def follow(head, tail)
  if head[0] != tail[0] &&
      head[1] != tail[1] &&
      ((head[0] - tail[0]).abs > 1 || 
       (head[1] - tail[1]).abs > 1)
    tail[0] += head[0] <=> tail[0]
    tail[1] += head[1] <=> tail[1]
  elsif (head[0] - tail[0]).abs > 1
    tail[0] += head[0] <=> tail[0]
  elsif (head[1] - tail[1]).abs > 1
    tail[1] += head[1] <=> tail[1]
  end
end

input = File.read("./inputs/09.txt")

RSpec.describe do 
  it 'parses the input' do
    expect(parse_moves(input)).to eq([
                                      ["R", 4],
                                      ["U", 4],
                                      ["L", 3],
                                      ["D", 1],
                                      ["R", 4],
                                      ["D", 1],
                                      ["L", 5],
                                      ["R", 2]
                                      ])
  end

  it "moves the head and the tail" do
    visited = []
    expect(move(visited, [[0,0], [0,0]], "U", 3)).to eq([[3,0], [2,0]])
    expect(move(visited, [[0,0], [0,0]], "D", 3)).to eq([[-3,0], [-2,0]])
    expect(move(visited, [[0,0], [0,0]], "L", 10)).to eq([[0, -10], [0, -9]])
    expect(move(visited, [[0,0], [0,0]], "R", 12)).to eq([[0, 12], [0, 11]])
  end

  it "moves the head, and the tail diagonally" do
    visited = []
    expect(move(visited, [[1,1], [0,0]], "U", 1)).to eq([[2, 1], [1, 1]])
    expect(move(visited, [[-1,-1], [0,0]], "D", 1)).to eq([[-2, -1], [-1, -1]])
    expect(move(visited, [[1,-1], [0,0]], "L", 1)).to eq([[1, -2], [1, -1]])
    expect(move(visited, [[1,1], [0,0]], "R", 1)).to eq([[1, 2], [1, 1]])
  end
end

visited = []
# rope = Array.new(2) { Array.new(2) { 0 } }
rope = Array.new(10) { Array.new(10) { 0 } }
parse_moves(input).each do |(direction, distance)|
  rope = move(visited, rope, direction, distance)
end
p visited.uniq.length