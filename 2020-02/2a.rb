input = File.readlines("input.txt")

valid = input.count do |line|
  parsed = line.scan(/(\d+)\-(\d+) (\w): (\w+)/)
  min, max, letter, password = parsed[0]
  n = password.count(letter)
  n >= min.to_i && n <= max.to_i
end

puts valid

