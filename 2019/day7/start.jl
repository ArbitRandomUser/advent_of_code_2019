include("../intcode.jl")
using .IntCode
#using Combinatorics 

f = open("input")
lines = readlines(f)
ops = [parse(Int,x) for x in split(lines[1],",")]
#amps = [program(copy(ops)) for i in 1:5]

mutable struct amp
  prog::program
  config::Int
end

amps = [amp( program(copy(ops)) , 0) for i in 1:5 ]

function run_amp(amp,args::Array,)
  amp.prog.argpos = 1 #reset arg position
  return run_program(amp.prog,args,mode="TILLOP")
end

function cascade_amps(amps::Array{amp},configs::Array{Int},inp=0)
  #configure the amps
  for (ind,c) in enumerate(configs)
    amps[ind].config = c
  end
  for amp in amps
    inp = run_amp(amp,[amp.config,inp])[end]
  end
  return inp
end

function cascade_amps_feedback(amps,configs,inp=0)
  retval = 0
  #for (ind,c) in enumerate(configs)
  #  amps[ind].config = c
  #end
  #ampstates = [nothing for i in 1:length(amps)]
  for (i,amp) in enumerate(amps)
    #println("configuring amp " ,i, " with " , configs[i])
    out = run_amp(amp,[configs[i],inp])
    #println(out)
    inp = out[end]
  end
  while(true)
    retval = inp
    break_flag=false
    for (i,amp) in enumerate(amps)
      #println("feeding amp " ,i, " with " , inp)
      out = run_amp(amp,[inp,])
      #println(out)
      inp = out[end]
      if inp == "HALT"
	break_flag = true
	break
      end
    end
    if break_flag == true
      break
    end
  end
  return retval
end


#println(cascade_amps(amps,[0,1,2,3,4],0))

function calc_best_signal(ops,inputval=0)
  biggestval = -Inf 
  for i1 in 0:4,i2 in 0:4,i3 in 0:4,i4 in 0:4,i5 in 0:4
    amps = [amp( program(copy(ops)) , 0) for i in 1:5 ]
    configs = [i1,i2,i3,i4,i5]
    if length(unique(configs)) == length(configs)
	  newval = cascade_amps(amps,configs,inputval)
	  if newval > biggestval
		biggestval = newval
	  end
    end
  end
  return biggestval
end

function calc_best_feedback(ops,inputval=0)
  biggestval = -Inf
  for i1 in 5:9,i2 in 5:9,i3 in 5:9,i4 in 5:9,i5 in 5:9
    amps = [amp( program(copy(ops)) , 0) for i in 1:5 ]
    configs = [i1,i2,i3,i4,i5]
    if length(unique(configs)) == length(configs)
	newval = cascade_amps_feedback(amps,configs,inputval)
	if newval > biggestval
	  biggestval = newval
	end
    end
  end
  return biggestval
end

println("first answer : " , calc_best_signal(ops,0) )
println("second answer : " , calc_best_feedback(ops,0) )
