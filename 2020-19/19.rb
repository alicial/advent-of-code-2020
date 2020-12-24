input = File.read('input.txt').split("\n\n")

rules = Hash[input[0].split("\n").map { |line| k, v = line.split(':'); [k, v.split('|').map(&:split)] }]

messages = input[1].split("\n")

def match(msg, idx, rule, rules, depth)
  return msg[idx] == 'a' ? [idx] : [] if rule == '"a"'
  return msg[idx] == 'b' ? [idx] : [] if rule == '"b"'
  raise 'no rule' unless rules.key?(rule)

  matches = []
  c = 0
  loop do
    matched_to = idx

    m = []
    rules[rule][c].each do |k|
      m = match(msg, matched_to, k, rules, depth + 1)
      break if m.length == 0

      matched_to = m.first + 1
    end

    matches << m.first unless m.length == 0

    c += 1
    break unless c < rules[rule].length
  end
  matches.uniq
end

count = messages.count do |msg|
  match(msg, 0, '0', rules, 0).include?(msg.length - 1)
end

# Part 1
puts count

# Part 2
rules['8'] = [['42'], %w[42 8]]
rules['11'] = [%w[42 31], %w[42 11 31]]

def match0(msg, rules)
  matches8 = []
  i = 0
  until i.nil?
    r = match(msg, i, '42', rules, 0)
    if r.empty?
      i = nil
    else
      i = r.first
      matches8 << i
      i += 1
    end
  end

  matches8.map do |j|
    match(msg, j + 1, '11', rules, 0)
  end.flatten
end

count = messages.count do |msg|
  match0(msg, rules).include?(msg.length - 1)
end

puts count
