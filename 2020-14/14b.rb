# Strategy is to apply the bitmask without the "X" floating bits first, with an OR
# Then apply each "X" as an XOR successively to get all combinations.

inputs = File.readlines('input.txt').map(&:chomp).freeze

mem = {}
instructions = []
or_mask = 0
xor_masks = []

def xor(xor_masks, instructions, mem)
  return if xor_masks.length == 0

  x_instructions = instructions.map do |i_num|
    i, num = i_num
    i_x = i ^ xor_masks[0]
    mem[i] = num
    mem[i_x] = num
    [i_x, num]
  end
  xor(xor_masks[1..], instructions.zip(x_instructions).flatten(1), mem)
end

inputs.each do |input|
  a, b = input.split(' = ')
  if a == 'mask'
    xor(xor_masks, instructions, mem) if instructions.length > 0
    instructions = []
    mask = b.chars
    or_mask = mask.map { |x| x == '1' ? '1' : '0' }.join.to_i(2)
    xor_masks = mask.reverse.each_with_index.map { |x, i| x == 'X' ? 2**i : nil }.compact
  else
    i = a.scan(/\d+/)[0].to_i | or_mask
    num = b.to_i
    instructions << [i, num]
  end
end

xor(xor_masks, instructions, mem) if instructions.length > 0

puts mem.values.sum
