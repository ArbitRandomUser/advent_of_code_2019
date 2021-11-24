module IntCode
export step_program, run_program, program

mutable struct program
  ops::Array ##array of ops
  pc::Int ##program pc
end

program(x::Array) = program(copy(x),0) #we copy the ops 

##julia is 1 indexed soo..
function Base.getindex(prog::program,i::Int)
  return prog.ops[i+1]
end

function Base.setindex!(prog::program,val::Int,i::Int)
  prog.ops[i+1] = val
end

function get_cur_op(prog::program)
  return (prog[prog.pc]%100)
end

function addrmode(prog::program)
  pc = prog.pc
  i,j,k = prog[pc+1], prog[pc+2], prog[pc+3]
  #println( (prog[pc]%Int(1e4))%10 , (prog[pc]%Int(1e3))%10, (prog[pc]%Int(1e2))%10)
  if (prog[pc]÷Int(1e2))%10 == 1
    #print("encountered imm mode for 1")
    i = pc +1 
  end
  if (prog[pc]÷Int(1e3))%10 == 1
    #print("encountered imm mode for 2")
    j = pc+2
  end
  if (prog[pc]÷Int(1e4))%10 == 1
    #throw(DomainError(prog[pc] , "Parameters that an instruction writes to
#		      will never be in immediate mode."))
    k = pc + 3
  end
  i,j,k
end

function op_code1(prog::program)
  i,j,k = addrmode(prog)
  prog[k] = prog[j] + prog[i]
  prog.pc = prog.pc + 4
end

function op_code2(prog::program)
  i,j,k = addrmode(prog)
  prog[k] = prog[j] * prog[i]
  prog.pc = prog.pc + 4
end

function op_code3(prog::program,args,argpos)
  try 
    inp=args[argpos]
  catch err
    if isa(err,BoundsErrro)
      print("awaiting stdin input : ")
      inp = parse(Int,readline(stdin))
    end
  end

  i,j,k = addrmode(prog)
  prog[i] = inp 
  prog.pc = prog.pc + 2
  argpos = argpos + 1
end

function op_code4(prog::program)
  i,j,k = addrmode(prog)
  println("output : ",prog[i])
  ret = prog[i]
  prog.pc = prog.pc + 2
  return ret
end

function op_code5(prog::program)
  i,j,k = addrmode(prog)
  if prog[i] != 0
    prog.pc = prog[j]
  else
    prog.pc = prog.pc + 3
  end
end

function op_code6(prog::program)
  i,j,k = addrmode(prog)
  if prog[i] == 0
    prog.pc = prog[j]
  else
    prog.pc = prog.pc + 3
  end
end

function op_code7(prog::program)
  i,j,k = addrmode(prog)
  if prog[i] < prog[j]
    prog[k] = 1
  else
    prog[k] = 0
  end
  prog.pc = prog.pc + 4
end

function op_code8(prog::program)
  i,j,k = addrmode(prog)
  if prog[i] == prog[j]
    prog[k] = 1
  else 
    prog[k] = 0
  end
  prog.pc = prog.pc + 4
end

function step_program(prog::program,args,argpos)
    end_flag = 0
    if get_cur_op(prog) == 1
      op_code1(prog)
    elseif get_cur_op(prog) == 2
      op_code2(prog)
    elseif get_cur_op(prog) == 3
      argpos = op_code3(prog)
    elseif get_cur_op(prog) == 4
      ret = op_code4(prog)
    elseif get_cur_op(prog) == 5
      op_code5(prog)
    elseif get_cur_op(prog) == 6
      op_code6(prog)
    elseif get_cur_op(prog) == 7
      op_code7(prog)
    elseif get_cur_op(prog) == 8
      op_code8(prog)
    elseif get_cur_op(prog) == 99
      end_flag = 1 
    end
  return end_flag,ret,argpos
end

function run_program(prog::program,args=[], pc::Int = 0)
  prog.pc = pc 
  end_flag = 0
  argspos = 1
  retvals = []
  while(end_flag == 0)
    #argpos gets incremented in op_code3 and is returned all the way back here
    end_flag,ret,argpos = step_program(prog,args,argpos)
    push!(retvals,ret)
    if end_flag == 1
      break
    end
  end
  return retvals
end #run_program

end #module
