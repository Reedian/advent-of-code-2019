def intcode(memory, input)
  instruction_pointer = 0
  output_list = []
  relative_base = 0

  loop do
    instruction_header = memory[instruction_pointer]
    opcode = instruction_header % 100
    parameters = [instruction_header.digits[2],instruction_header.digits[3], instruction_header.digits[4]]
    parameter1 = lambda do
      case parameters[0]
      when 1 then memory[instruction_pointer+1]
      when 2 then memory[memory[instruction_pointer+1] + relative_base]  || 0
      else
        memory[memory[instruction_pointer+1]]
      end
    end
    parameter2 = lambda do
      case parameters[1]
      when 1 then memory[instruction_pointer+2]
      when 2 then memory[memory[instruction_pointer+2] + relative_base] || 0
      else
        memory[memory[instruction_pointer+2]]
      end
    end
    parameter3 = lambda do
      case parameters[2]
      when 2 then memory[instruction_pointer+3] + relative_base
      else
        memory[instruction_pointer+3]
      end
    end

    case opcode
    when 1 then
      address = parameter3.call
      memory[address] = parameter1.call + parameter2.call
      instruction_pointer += 4
    when 2 then
      address = parameter3.call
      memory[address] = parameter1.call * parameter2.call
      instruction_pointer += 4
    when 3 then
      address = case parameters[0]
      when 1 then instruction_pointer+1
      when 2 then memory[instruction_pointer+1] + relative_base
      else
        memory[instruction_pointer+1]
      end
      memory[address] = input
      instruction_pointer += 2
    when 4 then
      output_list << parameter1.call
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
      address = parameter3.call
      memory[address] = value
      instruction_pointer += 4
    when 8
      value = parameter1.call == parameter2.call ? 1 : 0
      address = parameter3.call
      memory[address] = value
      instruction_pointer += 4
    when 9
      relative_base += parameter1.call
      instruction_pointer += 2
    when 63
      break
      when 0 then break
    when 99 then break
    end
  end

  output_list
end
