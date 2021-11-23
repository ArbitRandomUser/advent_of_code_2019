include("../intcode.jl")
ops = [i for i in include("input")] 

using .IntCode
prog1 = program(ops)
prog1[1]=12
prog1[2]=2
run_program(prog1)
println("part1 : ", prog1[0])

prog1 = program(ops)

function find_inputs(prog::program)
  break_flag = 0
  retval = nothing
  for noun in 99:-1:0
    for verb in 99:-1:0
      #println("trying pair", noun , " " , verb)
      prog.ops = copy(ops) #reset program
      prog.pc = 0
      prog[1] = noun
      prog[2] = verb
      run_program(prog)
      if prog[0] == 19690720
	retval = 100*noun + verb
	break_flag = 1
	break
      end
    end
    if break_flag ==1
      break
    end
  end
  return retval
end

println("part2 : " ,find_inputs(prog1))
