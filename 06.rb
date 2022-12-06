def process_packet(string)
  string.each_char.with_index do |char, index|
    next unless index >= 3

    return index + 1 if string[index - 3..index].chars.uniq == string[index - 3..index].chars
  end
end

def process_message(string)
  string.each_char.with_index do |char, index|
    next unless index >= 13

    return index + 1 if string[index - 13..index].chars.uniq == string[index - 13..index].chars
  end
end
string = File.read('./inputs/06.txt')

marker_packet = process_packet(string)
marker_message = process_message(string)

puts marker_packet, marker_message