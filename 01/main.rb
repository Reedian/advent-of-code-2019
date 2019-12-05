def fuel(mass)
  (mass / 3).floor - 2
end

def calculate_fuel(mass)
  sum = 0
  while mass >= 0
    mass = fuel(mass)
    sum += mass if mass.positive?
  end
  sum
end

sum = 0

File.readlines('input.txt').each do |line|
  sum += calculate_fuel(line.to_i)
end

puts sum
