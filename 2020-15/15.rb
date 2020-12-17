input = [0, 6, 1, 7, 2, 19, 20]

def play(starting_numbers, final_round)
  lookup = Hash.new { |h, k| h[k] = [] }
  starting_numbers.each_with_index { |x, idx| lookup[x] << idx }

  i = starting_numbers.length
  prev = starting_numbers.last

  while i < final_round
    if lookup.key?(prev) && lookup[prev].length > 1
      prev = lookup[prev][-1] - lookup[prev][-2]
      lookup[prev].shift if lookup[prev].length > 2
    else
      prev = 0
    end
    lookup[prev] << i
    i += 1
  end

  prev
end

# Part 1
puts play(input, 2020)

# Part 2
puts play(input, 30_000_000)
