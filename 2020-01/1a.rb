
input = File.readlines("input.txt")
numbers = Hash[input.map{ |x| [x.to_i, true] }]

numbers.each do |k, v|
  if numbers[2020 - k]
    puts k * (2020 - k)
    return
  end
end

