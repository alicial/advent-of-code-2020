input = File.readlines('input.txt').map(&:to_i)

window = 25
sums = Hash.new { |h, k| h[k] = [] }
i = 0
part1 = -1

while i < window - 1
  j = i + 1
  while j < window
    sum = input[i] + input[j]
    sums[sum] << [i, j]
    j += 1
  end
  i += 1
end

i += 1
while i < input.length
  if sums[input[i]] && sums[input[i]].length > 0
    sums.each { |_k, v| v.delete_if { |pairs| pairs.include?(i - window) } }
    j = i - window + 1
    while j < i
      sum = input[i] + input[j]
      sums[sum] << [i, j]
      j += 1
    end
  else
    part1 = input[i]
    break
  end
  i += 1
end

# Part 1
puts part1

i = 0

while i < input.length - 1
  sum = input[i]
  j = i + 1
  while j < input.length
    sum += input[j]
    if sum == part1
      arr = input[i..j + 1]

      # Part 2
      puts arr.min + arr.max
      exit(0)
    end
    break if sum > part1

    j += 1
  end
  i += 1
end
