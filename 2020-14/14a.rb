inputs = File.readlines('input.txt').map(&:chomp).freeze

mem = []
ones = 0
zeros = 1

inputs.each do |input|
  a, b = input.split(' = ')
  if a == 'mask'
    mask = b.chars
    ones = mask.map { |x| x == '1' ? '1' : '0' }.join.to_i(2)
    zeros = mask.map { |x| x == '0' ? '0' : '1' }.join.to_i(2)
  else
    i = a.scan(/\d+/)[0].to_i
    num = b.to_i
    mem[i] = (num | ones) & zeros
  end
end

puts mem.compact.sum
