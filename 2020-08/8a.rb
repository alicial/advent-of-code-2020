instructions = File.readlines('input.txt').map(&:chomp).freeze

visited = {}
acc = 0
i = 0

loop do
  break if visited[i]

  visited[i] = true
  op, num = instructions[i].split
  num = num.to_i
  case op
  when 'jmp'
    i += num
    next
  when 'acc'
    acc += num
  end
  i += 1
end

puts acc
