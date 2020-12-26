k1 = 8987316
k2 = 14681524

MOD = 20201227

val = 1
l1 = nil
l2 = nil
loops = 0
subject = 7
while l1.nil? || l2.nil?
  val = (val * subject) % MOD
  loops += 1
  l1 = loops if val == k1
  l2 = loops if val == k2
end

def transform(loop, subject)
  loop.times.reduce(1) { |val| (val * subject) % MOD }
end

puts transform(l2, k1)
puts transform(l1, k2) # double check
