def intcode(memory, input)
  instruction_pointer = 0
  output_list = []

  loop do
    instruction_header = memory[instruction_pointer]
    opcode = instruction_header % 100
    parameters = [instruction_header.digits[2],instruction_header.digits[3]]
    parameter1 = -> { parameters[0] == 1 ? memory[instruction_pointer+1] : memory[memory[instruction_pointer+1]] }
    parameter2 = -> { parameters[1] == 1 ? memory[instruction_pointer+2] : memory[memory[instruction_pointer+2]] }
    case opcode
      when 1 then
        address = memory[instruction_pointer+3]
        memory[address] = parameter1.call + parameter2.call
        instruction_pointer += 4
      when 2 then
        address = memory[instruction_pointer+3]
        memory[address] = parameter1.call * parameter2.call
        instruction_pointer += 4
      when 3 then
        address = parameters[0] == 1 ? instruction_pointer+1 : memory[instruction_pointer+1]
        memory[address] = input
        instruction_pointer += 2
      when 4 then
        output = parameters[0] == 1 ? instruction_pointer+1 : memory[instruction_pointer+1]
        output_list << memory[output]
        instruction_pointer += 2
      when 5 then
        if parameter1.call.zero?
          instruction_pointer += 3
        else
          instruction_pointer = parameter2.call
        end
      when 6
        if parameter1.call.zero?
          instruction_pointer = parameter2.call
        else
          instruction_pointer += 3
        end
      when 7
        value = parameter1.call < parameter2.call ? 1 : 0
        address = memory[instruction_pointer+3]
        memory[address] = value
        instruction_pointer += 4
      when 8
        value = parameter1.call == parameter2.call ? 1 : 0
        address = memory[instruction_pointer+3]
        memory[address] = value
        instruction_pointer += 4
      when 99 then break
    end
  end

  output_list
end
