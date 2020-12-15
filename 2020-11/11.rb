DIRECTIONS = [[-1, -1], [-1, 0], [-1, +1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

# Count number of occupied neighbors up to `count_to`
# width and height determine the furthest seat to count as neighbor
# Part 1 passes in 0 for width and height, so only the adjacent neighbor is checked.
def occupied(seat, seats, width, height, count_to)
  count = 0
  DIRECTIONS.each do |dir|
    x, y = seat
    dx, dy = dir
    loop do
      x += dx
      y += dy
      if seats.key?([x, y])
        count += 1 if seats[[x, y]]
        break
      end
      break unless x >= 0 && y >= 0 && x < width && y < height && count < count_to
    end
  end
  count >= count_to
end

def process(seats, width, height, count_to)
  output = seats.dup

  seats.each do |seat, occupied|
    if occupied
      output[seat] = false if occupied(seat, seats, width, height, count_to)
    else
      output[seat] = true unless occupied(seat, seats, width, height, 1)
    end
  end
  output
end

def run(seats, width, height, count_to)
  i = 0
  loop do
    output = process(seats, width, height, count_to)

    if output == seats
      # Pattern has stabilized, count occupied seats
      return output.count { |_k, v| v }
    end

    seats = output
    i += 1
  end
end

# Set up
input = File.readlines('input.txt').map(&:chomp).freeze

seats = {}

input.each_with_index do |row, y|
  row.chars.each_with_index do |seat, x|
    seats[[x, y]] = false if seat == 'L'
  end
end

# Part 1
puts run(seats, 0, 0, 4)

# Part 2
puts run(seats, input[0].length, input.length, 5)
