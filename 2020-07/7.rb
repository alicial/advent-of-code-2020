require 'set'

input = File.readlines("input.txt").map(&:chomp).freeze
my_bag = "shiny gold"

# populate two hashes:
# 1 maps all bags that contain a bag (key is inner bag)
# 2 maps how many bags of each color are inside another bag (key is outer bag)
contained_inside = Hash.new { |h, k| h[k] = Set.new }
contains = Hash.new { |h, k| h[k] = {} }

input.each do |line|
  outer_bag, inner_bags_str = line.split(" bags contain ")  
  inner_bags = Hash[inner_bags_str.scan(/(\d+) ([a-z ]+) bag/).map{|num_bag| [num_bag[1], num_bag[0].to_i]}]
  
  inner_bags.each {|bag, num| contained_inside[bag].add outer_bag }
  contains[outer_bag] = inner_bags
end

bags_to_check = [my_bag]
valid_bags = Set.new
while bags_to_check.length > 0
  bag = bags_to_check.pop
  if !valid_bags.include?(bag)
    valid_bags.add(bag)
    bags_to_check += contained_inside[bag].to_a if contained_inside[bag]
  end
end
valid_bags.delete(my_bag)

# Part 1
puts valid_bags.length

def count_bags(bag, contains, counted)
  return counted[bag] if counted.has_key?(bag)
  counted[bag] = 1
  if contains[bag].length > 0
    counted[bag] += contains[bag].sum {|b, n| n * count_bags(b, contains, counted)}
  end
  return counted[bag]
end

# Part 2
puts count_bags(my_bag, contains, {}) - 1 # don't count my bag