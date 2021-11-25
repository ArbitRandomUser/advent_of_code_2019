module IntCode
export step_program, run_program, program

mutable struct program
  ops::Array ##array of ops
  pc::Int ##program pc
  argpos::Int
  retvals::Array
end

program(x::Array) = program(copy(x),0,1,[]) #we copy the ops 

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
  len = length(prog.ops)
  #%len is to treat the ops as circular
  #instructions near the end might not need k , but if we assign 
  #k anyway as pc+3 it might go out of bounds , so we just treat
  #our ops as a circular array , correct intcode programs should not
  #use these spurious k values which have rolled over so its okay.

  i,j,k = prog[(pc+1)%len], prog[(pc+2)%len], prog[(pc+3)%len]
  #println( (prog[pc]%Int(1e4))%10 , (prog[pc]%Int(1e3))%10, (prog[pc]%Int(1e2))%10)
  if (prog[pc]÷Int(1e2))%10 == 1
    #print("encountered imm mode for 1")
    i = (pc +1)%len 
  end
  if (prog[pc]÷Int(1e3))%10 == 1
    #print("encountered imm mode for 2")
    j = (pc+2)%len
  end
  if (prog[pc]÷Int(1e4))%10 == 1
    #throw(DomainError(prog[pc] , "Parameters that an instruction writes to
#		      will never be in immediate mode."))
    k = (pc + 3)%len
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

function op_code3(prog::program,args)
  #println("running opcode3")
  inp = nothing
  #println(args , " " , argpos)
  try 
    inp=args[prog.argpos]
    #println("got input", inp)
  catch err
    if isa(err,BoundsError)
      print("awaiting stdin input : ")
      inp = parse(Int,readline(stdin))
    else
      @assert 1==2 #hack because i dont know how to use try/catch in julia
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
