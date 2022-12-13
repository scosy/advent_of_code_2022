def parse_monkeys_turns(input)
  monkeys = Hash.new { |k, v| k[v] = Hash.new { |k2, v2| k2[v2] = [] } }

  (input.split("\n").join.split("Monkey ") - [""]).each do |line|
    (line[4..-1].split("  ") - [""]).each do |i|
      monkeys[line[0].to_i][i.split(": ")[0]] << i.split(": ")[1]
    end
  end

  monkeys.transform_values do |ops|
    ops.transform_values.with_index do |value, index|
      case index
      when 0 then value[0].split(',').map(&:to_i)
      when 1 then value
      when 2 then value[0][-2..-1].to_i
      when 3 then value[0][-1].to_i
      when 4 then value[0][-1].to_i
      end
    end
  end
end

def for_20_rounds(monkeys, rounds)
  round = 1
  monkeys.each { |monkey, _value| monkeys[monkey]["Inspection"] = 0 }
  while round <= rounds
    monkeys.each do |num, ops|
      ops["Starting items"].dup.each do |item|
        old = item
        new = eval(ops["Operation"][0])
        new %= monkeys.values.map { |v| v["Test"] }.reduce(:*)
        new = rounds == 20 ? (new / 3) : new
        condition = (new % ops["Test"]).zero? ? "If true" : "If false"
        monkeys[ops[condition]]["Starting items"] << new
        ops["Starting items"].shift
        ops["Inspection"] += 1
      end
    end
    round += 1
  end
  monkey_business = []
  monkeys.each_value { |v| monkey_business << v["Inspection"] }
  monkey_business.max(2).reduce(:*)
end


file = "./inputs/11.txt"

if  File.read(file).empty?
  input = DATA.read
else
  input = File.read(file)
end

puts for_20_rounds(parse_monkeys_turns(input), 20)
puts for_20_rounds(parse_monkeys_turns(input), 10000)

__END__
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1