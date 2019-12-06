def intcode(memory, input)
  instruction_pointer = 0
  output_list = []

  loop do
    opcode = memory[instruction_pointer]
    case opcode
      when 1 then
        parameters = memory[instruction_pointer+1..instruction_pointer+2]
        address = memory[instruction_pointer+3]
        values = parameters.map { |param| memory[param] }
        memory[address] = values.sum
        instruction_pointer += 4
      when 2 then
        parameters = memory[instruction_pointer+1..instruction_pointer+2]
        address = memory[instruction_pointer+3]
        values = parameters.map { |param| memory[param] }
        memory[address] = values.inject(:*)
        instruction_pointer += 4
      when 3 then
        address = memory[instruction_pointer+1]
        instruction_pointer += 2
        memory[address] = input
      when 4 then
        output = memory[instruction_pointer+1]
        output_list << memory[output]
        instruction_pointer += 2
      when 5 then
        parameter1 = memory[instruction_pointer+1]
        parameter2 = memory[instruction_pointer+2]

        memory[parameter1].zero? ? instruction_pointer += 3 : instruction_pointer = memory[parameter2]
      when 6
        parameter1 = memory[instruction_pointer+1]
        parameter2 = memory[instruction_pointer+2]

        memory[parameter1].zero? ? instruction_pointer = memory[parameter2] : instruction_pointer += 3
      when 7
        parameter1 = memory[instruction_pointer+1]
        parameter2 = memory[instruction_pointer+2]

        value = memory[parameter1] < memory[parameter2] ? 1 : 0
        address = memory[instruction_pointer+3]
        memory[address] = value
        instruction_pointer += 4
      when 8
        parameter1 = memory[instruction_pointer+1]
        parameter2 = memory[instruction_pointer+2]

        value = memory[parameter1] == memory[parameter2] ? 1 : 0
        address = memory[instruction_pointer+3]
        memory[address] = value
        instruction_pointer += 4
      when 99 then break
      else
        parsed_opcode = opcode.digits
        opcode = parsed_opcode[0]
        case opcode
          when 1 then
            parameter1 = parsed_opcode[2] == 1 ? memory[instruction_pointer+1] : memory[memory[instruction_pointer+1]]
            parameter2 = parsed_opcode[3] == 1 ? memory[instruction_pointer+2] : memory[memory[instruction_pointer+2]]
            address = memory[instruction_pointer+3]
            memory[address] = parameter1 + parameter2
            instruction_pointer += 4
          when 2 then
            parameter1 = parsed_opcode[2] == 1 ? memory[instruction_pointer+1] : memory[memory[instruction_pointer+1]]
            parameter2 = parsed_opcode[3] == 1 ? memory[instruction_pointer+2] : memory[memory[instruction_pointer+2]]
            address = memory[instruction_pointer+3]
            memory[address] = parameter1 * parameter2
            instruction_pointer += 4
          when 3 then
            address = parsed_opcode[2] == 1 ? instruction_pointer+1 : memory[instruction_pointer+1]
            memory[address] = input
            instruction_pointer += 2
          when 4 then
            output = parsed_opcode[2] == 1 ? instruction_pointer+1 : memory[instruction_pointer+1]
            output_list << memory[output]
            instruction_pointer += 2
          when 5 then
            parameter1 = parsed_opcode[2] == 1 ? memory[instruction_pointer+1] : memory[memory[instruction_pointer+1]]
            parameter2 = parsed_opcode[3] == 1 ? memory[instruction_pointer+2] : memory[memory[instruction_pointer+2]]

            if parameter1.zero?
              instruction_pointer += 3
            else
              instruction_pointer = parameter2
            end
          when 6
            parameter1 = parsed_opcode[2] == 1 ? memory[instruction_pointer+1] : memory[memory[instruction_pointer+1]]
            parameter2 = parsed_opcode[3] == 1 ? memory[instruction_pointer+2] : memory[memory[instruction_pointer+2]]

            if parameter1.zero?
              instruction_pointer = parameter2
            else
              instruction_pointer += 3
            end
          when 7
            parameter1 = parsed_opcode[2] == 1 ? memory[instruction_pointer+1] : memory[memory[instruction_pointer+1]]
            parameter2 = parsed_opcode[3] == 1 ? memory[instruction_pointer+2] : memory[memory[instruction_pointer+2]]
            value = parameter1 < parameter2 ? 1 : 0
            address = memory[instruction_pointer+3]
            memory[address] = value
            instruction_pointer += 4
          when 8
            parameter1 = parsed_opcode[2] == 1 ? memory[instruction_pointer+1] : memory[memory[instruction_pointer+1]]
            parameter2 = parsed_opcode[3] == 1 ? memory[instruction_pointer+2] : memory[memory[instruction_pointer+2]]
            value = parameter1 == parameter2 ? 1 : 0
            address = memory[instruction_pointer+3]
            memory[address] = value
            instruction_pointer += 4
          when 9 then break
        end
    end
  end

  output_list
end