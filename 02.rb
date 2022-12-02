def get_total_score(array)
  score = 0
  ultra_top_secret_strat = {
    X: {
      A: "Z",
      B: "X",
      C: "Y"
    },
    Z: {
      A: "Y",
      B: "Z",
      C: "X"
    }
  }
  array.each do |round|
    opponent = round[0]
    me = round[2]# == "Y" ? [opponent.bytes[0] + 23].pack('c*') : ultra_top_secret_strat[round[2].to_sym][opponent.to_sym] # Uncomment for part two
    score += get_match_points(opponent, me, rock_paper_scissors(opponent, me)[0])
  end
  score
end

def get_match_points(opponent, me, result)
  points = {
    "X": 1,
    "Y": 2,
    "Z": 3
  }
  if result == "D"
    return 3 + points[me.to_sym]
  elsif result == "W"
    return 6 + points[me.to_sym]
  else
    return points[me.to_sym]
  end
end

def rock_paper_scissors(opponent, me)
  me_wins = [["A", "Y"], ["B", "Z"], ["C", "X"]]
  draws = [["A", "X"], ["B", "Y"], ["C", "Z"]]
  if draws.include?([opponent, me])
    return "D"
  elsif me_wins.include?([opponent, me])
    return "W"
  else
    return "L"
  end
end

rounds = []
File.foreach('./inputs/02.txt') { |line| rounds << line }
rounds.map! { |round| round.chomp }

total_score = get_total_score(rounds)

puts total_score
