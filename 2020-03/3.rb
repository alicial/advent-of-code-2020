input = File.readlines("input.txt").map(&:chomp).freeze

def count_trees(lines, right, down)
  i, count = 0, 0
  lines.each_with_index do |line, index|
    next unless index % down == 0
    count += 1 if line[ i % line.length ] == '#'
    i += right
  end
count
end

# Part 1
puts count_trees(input, 3, 1)

# Part 2
puts count_trees(input, 1, 1) * count_trees(input, 3, 1) * count_trees(input, 5, 1) * count_trees(input, 7, 1) * count_trees(input, 1, 2) 