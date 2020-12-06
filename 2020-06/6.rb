file = File.read("input.txt")

groups = file.split("\n\n").freeze

# Part 1
puts groups.sum{|g| g.gsub(/\W/, '').chars.uniq.count}

# Part 2
puts groups.sum{|g| g.split("\n").map(&:chars).reduce(:&).count}
