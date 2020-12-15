instructions = File.readlines('input.txt').map(&:chomp).freeze

# when changeable is set to true, the jmp and nop commands will try switching to the respective other command

def run(i, acc, visited, instructions, changeable)
  while i >= 0 && i < instructions.length
    return false if visited[i]

    visited[i] = true
    op, num = instructions[i].split
    num = num.to_i
    case op
    when 'jmp'
      run(i + 1, acc, visited.clone, instructions, false) if changeable
      i += num
      next
    when 'acc'
      acc += num
    when 'nop'
      run(i + num, acc, visited.clone, instructions, false) if changeable
    end
    i += 1
  end
  if i == instructions.length
    puts 'terminated!'
    puts acc
    exit(0)
  end
  false
end

run(0, 0, {}, instructions, true)
