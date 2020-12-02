
input = File.readlines("input.txt")
numbers = Hash[input.map{ |x| [x.to_i, true] }]

numbers.each do |a, v|
  numbers.each do |b, v|
    if numbers[2020 - a - b]
      puts a * b * (2020 - a - b)
      return
    end
  end
end

