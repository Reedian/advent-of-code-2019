def intcode(input)
  instruction_pointer = 0

  loop do
    opcode = input[instruction_pointer]
    case opcode
    when 1 then
      parameters = input[instruction_pointer+1..instruction_pointer+2]
      address = input[instruction_pointer+3]
      values = parameters.map { |param| input[param] }
      input[address] = values.sum
      instruction_pointer += 4
    when 2 then
      parameters = input[instruction_pointer+1..instruction_pointer+2]
      address = input[instruction_pointer+3]
      values = parameters.map { |param| input[param] }
      input[address] = values.inject(:*)
      instruction_pointer += 4
    when 99 then break
    end
  end

  input
end

# Part1
output = intcode([1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,5,23,1,23,9,27,2,27,6,31,1,31,6,35,2,35,9,39,1,6,39,43,2,10,43,47,1,47,9,51,1,51,6,55,1,55,6,59,2,59,10,63,1,6,63,67,2,6,67,71,1,71,5,75,2,13,75,79,1,10,79,83,1,5,83,87,2,87,10,91,1,5,91,95,2,95,6,99,1,99,6,103,2,103,6,107,2,107,9,111,1,111,5,115,1,115,6,119,2,6,119,123,1,5,123,127,1,127,13,131,1,2,131,135,1,135,10,0,99,2,14,0,0])
puts output[0]

# Part2
(0..99).each do |a|
  (0..99).each do |b|
    output = intcode([1,a,b,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,5,23,1,23,9,27,2,27,6,31,1,31,6,35,2,35,9,39,1,6,39,43,2,10,43,47,1,47,9,51,1,51,6,55,1,55,6,59,2,59,10,63,1,6,63,67,2,6,67,71,1,71,5,75,2,13,75,79,1,10,79,83,1,5,83,87,2,87,10,91,1,5,91,95,2,95,6,99,1,99,6,103,2,103,6,107,2,107,9,111,1,111,5,115,1,115,6,119,2,6,119,123,1,5,123,127,1,127,13,131,1,2,131,135,1,135,10,0,99,2,14,0,0])
    if output[0] == 19690720
      puts 100 * a + b
      exit
    end
  end
end
