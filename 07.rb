def get_directories_size(array)
  cwd = []
  dir_sizes = Hash.new { |h, k| h[k] = 0 }

  array
    .map { |line| line.split(' ') }
    .each do |command|
      case command
        in ["$", "cd", ".."]
          cwd.pop
        in ["$", "cd", dir]
          cwd << dir
        in ["$", "ls"]
        in ["dir", _dirname]
        in [size, _filename]
          cwd.size.times do |i|
            dir_sizes[cwd[0..i]] += size.to_i
          end
      end
    end
    dir_sizes
end

def get_under_100000(array)
  get_directories_size(array).reduce(0) { |sum, (_dir, size)| size <= 100000 ? sum += size : sum }
end

def get_to_delete_directories_size(array)
  dir_sizes = get_directories_size(array)
  outermost_file_size = dir_sizes[["/"]]
  p needed = 70_000_000 - outermost_file_size
  dir_sizes.values.sort.find { |size| size >= 30_000_000 - needed }
end

output = []

File.foreach("./inputs/07.txt") { |line| output << line.chomp }

puts get_under_100000(output)
p get_to_delete_directories_size(output)
