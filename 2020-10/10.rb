input = File.readlines('input.txt').map(&:to_i).sort!
prev = 0
ones = 0
threes = 0
input.each do |x|
  case x - prev
  when 1
    ones += 1
  when 3
    threes += 1
  end
  prev = x
end

# Part 1
puts ones * (threes + 1)

input.unshift(0)
counts = [1] * input.length

input.each_with_index do |x, i|
  next unless i > 0

  sum = counts[i - 1]
  sum += counts[i - 2] if i > 1 && x - input[i - 2] <= 3
  sum += counts[i - 3] if i > 2 && x - input[i - 3] <= 3
  counts[i] = sum
end

# Part 2
puts counts.last
