module IntCode
export step_program, run_program, program

mutable struct program
  ops::Array{BigInt} ##array of ops
  pc::BigInt ##program pc
  relbase::BigInt
  argpos::BigInt
  retvals::Array
end

program(x::Array) = program(copy(x),0,0,1,[]) #we copy the ops 

##julia is 1 indexed soo..
function Base.getindex(prog::program,i::BigInt)
  #trying to access array elements greater than array length 
  #will pad enough 0's to the array and return the value 
  #this way we dynamically increase memory as we require
  try
    return prog.ops[i+1]
  catch err
    if isa(err,BoundsError)
      push!(prog.ops,zeros(i+1-length(prog.ops))...)
      return prog.ops[i+1]
    end
  end
end

function Base.setindex!(prog::program,val::BigInt,i::BigInt)
  try
    prog.ops[i+1] = val
  catch err 
    if isa(err,BoundsError)
      push!(prog.ops,zeros(i+1-length(prog.ops))...) 
      prog.ops[i+1] = val
    end
   end
end

function get_cur_op(prog::program)
  return (prog[prog.pc]%100)
end

function addrmode(prog::program)
  pc = prog.pc
  len = length(prog.ops)
  i,j,k = prog[(pc+1)], prog[(pc+2)], prog[(pc+3)]
  #println( (prog[pc]%Int(1e4))%10 , (prog[pc]%Int(1e3))%10, (prog[pc]%Int(1e2))%10)
  if (prog[pc]÷10^2)%10 == 1
    #print("encountered imm mode for 1")
    i = (pc +1) 
  elseif (prog[pc]÷10^2)%10 == 2 #rel mode
    i = prog.relbase + prog[(pc+1)]
  end
  if (prog[pc]÷Int(1e3))%10 == 1
    #print("encountered imm mode for 2")
    j = (pc+2)
  elseif (prog[pc]÷10^3)%10 == 2 #rel mode
    j = prog.relbase + prog[(pc+2)]
  end
  if (prog[pc]÷Int(1e4))%10 == 1
    #throw(DomainError(prog[pc] , "Parameters that an instruction writes to
#		      will never be in immediate mode."))
    k = (pc + 3)
  elseif (prog[pc]÷10^4)%10 == 2 #rel mode
    k = prog.relbase + prog[(pc+3)]
  end
  return i,j,k
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

function op_code3(prog::program,args)
  inp = nothing
  #println(args , " " , argpos)
  try 
    inp=args[prog.argpos]
    #println("got input", inp)
  catch err
    if isa(err,BoundsError)
      print("awaiting stdin input : ")
      inp = parse(BigInt,readline(stdin))
    else
      throw(err)
    end
  end

  i,j,k = addrmode(prog)
  prog[i] = inp 
  prog.pc = prog.pc + 2
  prog.argpos = prog.argpos + 1
end

function op_code4(prog::program)
  i,j,k = addrmode(prog)
  #println("output : ",prog[i])
  push!(prog.retvals,prog[i])
  prog.pc = prog.pc + 2
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
    prog[k] = BigInt(1)
  else
    prog[k] = BigInt(0)
  end
  prog.pc = prog.pc + 4
end

function op_code8(prog::program)
  i,j,k = addrmode(prog)
  if prog[i] == prog[j]
    prog[k] = BigInt(1)
  else 
    prog[k] = BigInt(0)
  end
  prog.pc = prog.pc + 4
end

function op_code9(prog::program)
  i,j,k = addrmode(prog)
  prog.relbase = prog.relbase + prog[i]
  prog.pc = prog.pc + 2
end

function step_program(prog::program,args)
    end_flag = 0
    op_flag = 0
    ret = nothing
    if get_cur_op(prog) == 1
      op_code1(prog)
    elseif get_cur_op(prog) == 2
      op_code2(prog)
    elseif get_cur_op(prog) == 3
      op_code3(prog,args)
    elseif get_cur_op(prog) == 4
      op_code4(prog)
      op_flag = 1
    elseif get_cur_op(prog) == 5
      op_code5(prog)
    elseif get_cur_op(prog) == 6
      op_code6(prog)
    elseif get_cur_op(prog) == 7
      op_code7(prog)
    elseif get_cur_op(prog) == 8
      op_code8(prog)
    elseif get_cur_op(prog) == 9
      op_code9(prog)
    elseif get_cur_op(prog) == 99
      push!(prog.retvals,"HALT")
      end_flag = 1 
    end
  return end_flag,op_flag
end

function run_program(prog::program,args=[]; mode="TILLHALT")
  #println("running with args",args)
  #mode can be TILLHALT or TILLOP
  end_flag = 0
  op_flag = 0
  while(end_flag == 0)
    end_flag,op_flag = step_program(prog,args)
    if end_flag == 1 
      break
    elseif mode=="TILLOP" && op_flag==1
      break
    end
  end
  return prog.retvals 
end #run_program
end #module
