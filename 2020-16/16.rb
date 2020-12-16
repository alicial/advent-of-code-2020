require 'set'

input = File.read('input.txt').split("\n\n")

fields = {}
input[0].split("\n").each do |x|
  parsed = x.scan(/^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)$/).first
  fields[parsed[0]] = [(parsed[1].to_i..parsed[2].to_i), (parsed[3].to_i..parsed[4].to_i)]
end

nearby_tickets = input[2].split("\n").map{ |x| x.split(',').map(&:to_i) }
nearby_tickets.shift

invalid_nums = []
ranges = fields.values.flatten

valid_tickets = nearby_tickets.filter do |ticket|
  invalid = ticket.filter { |n| ranges.none? { |r| r.include?(n) } }
  invalid_nums += invalid
  invalid.length == 0
end

# Part 1
puts invalid_nums.sum

guesses = Hash[fields.keys.map { |k| [k, Set.new(0..valid_tickets.first.length - 1)] }]

valid_tickets.each do |ticket|
  ticket.each_with_index do |n, i|
    fields.each do |k, v|
      guesses[k].delete(i) if v.none? { |r| r.include?(n) }
    end
  end
end

mapping = {}
while guesses.length > 0
  ones = guesses.filter { |_, indexes| indexes.length == 1 }
  raise "Can't determine next guess" if ones.length == 0

  ones.each do |k, indexes|
    val = indexes.to_a[0]
    mapping[k] = val
    guesses.delete(k)
    guesses.each { |_, v| v.delete(val) }
  end
end

departure_field_indexes = mapping.filter { |k, _| k.start_with?('departure') }.values

my_ticket = input[1].split("\n").last.split(',').map(&:to_i)

# Part 2
puts departure_field_indexes.reduce(1) { |sum, i| sum * my_ticket[i] }
