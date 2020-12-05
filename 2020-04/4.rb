# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

file = File.read("input.txt")

passports = file.split("\n\n")

valid = 0
strictly_valid = 0

required = %w(byr iyr eyr hgt hcl ecl pid)

passports.each do |passport|
  keyvals = passport.sub("\n", " ").split

  keyval = Hash[keyvals.map { |kv| kv.split(":") } ]

  valid += 1 if required.difference(keyval.keys).length == 0

  remaining = keyval.count do |key, val|
    case key
    when "byr"
      val.to_i >= 1920 && val.to_i <= 2002
    when "iyr"
      val.to_i >= 2010 && val.to_i <= 2020
    when "eyr"
      val.to_i >= 2020 && val.to_i <= 2030
    when "hgt"
      (val.end_with?("cm") && (val.to_i >= 150 && val.to_i <= 193)) || (val.end_with?("in") && (val.to_i >= 59 && val.to_i <= 76))
    when "hcl"
      val.match(/^#[0-9a-f]{6}$/)
    when "ecl"
      %w(amb blu brn gry grn hzl oth).include?(val)
    when "pid"
      val.match(/^\d{9}$/)
    end
  end
      
  strictly_valid += 1 if remaining == required.length
end

# Part 1
puts valid

# Part 2
puts strictly_valid