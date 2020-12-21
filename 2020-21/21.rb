input = File.readlines('input.txt')

allergens = {}
all_ingredients = []

input.each do |line|
  parsed = line.scan(/([\w, ]+) \(contains ([\w, ]+)\)/).first
  ingredients = parsed[0].split
  all_ingredients += ingredients
  parsed[1].split(', ').each do |a|
    allergens[a] = if allergens.key?(a)
                     allergens[a] & ingredients
                   else
                     ingredients
                   end
  end
end

known_allergens = {}

loop do
  by_count = allergens.group_by { |_a, ingredients| ingredients.length }

  break if by_count.empty?

  by_count[1].each do |k, v|
    known = v.first
    allergens.each do |a, _ingredients|
      allergens[a].delete(known) unless a == k
    end
    known_allergens[known] = k
    allergens.delete(k)
  end
end

all_ingredients.delete_if { |a| known_allergens.key?(a) }

# Part 1
puts all_ingredients.count

# Part 2
puts known_allergens.sort_by { |_, v| v }.map(&:first).join(',')
