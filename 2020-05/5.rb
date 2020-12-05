def midpoint(min, max)
  min + (max-min) / 2
end

def bisect(instructions, min, max, choose_lower)
  if instructions.length == 1
    return choose_lower.(instructions[0]) ? min : max
  end
  if choose_lower.(instructions[0])
    max = midpoint(min, max)
  else
    min = midpoint(min, max) + 1
  end
  bisect(instructions[1..], min, max, choose_lower)
end

seats = File.readlines("input.txt").map(&:chomp).freeze

seat_ids = seats.map do |seat|
  row = bisect(seat[0..6], 0, 127, -> x { x == "F" })
  col = bisect(seat[7..9], 0, 7, -> x { x == "L"})
  row * 8 + col
end

# Part 1
max_id = seat_ids.max
puts max_id

# Part 2
puts (0..max_id).to_a.difference(seat_ids).max