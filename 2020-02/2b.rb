input = File.readlines("input.txt")

valid = input.count do |line|
  parsed = line.scan(/(\d+)\-(\d+) (\w): (\w+)/)
  pos1, pos2, letter, password = parsed[0]
  (password[pos1.to_i - 1] == letter) ^ (password[pos2.to_i - 1] == letter)
end

puts valid

