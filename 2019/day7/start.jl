include("../intcode.jl")
using .IntCode
using Combinatorics 

f = open("input")
lines = readlines(f)
ops = [parse(Int,x) for x in split(lines[1],",")]
#amps = [program(copy(ops)) for i in 1:5]

mutable struct amp
  prog::program
  config::Int
end

amps = [amp( program(copy(ops)) , 0) for i in 1:5 ]

function run_amp(amp,config,inp::Int)
  return run_program(amp.prog,[config,inp])[1]
end

function cascade_amps(amps::Array{amp},configs::Array{Int},inp=0)
  #configure the amps
  for (ind,c) in enumerate(configs)
    amps[ind].config = c
  end
  for amp in amps
    inp = run_amp(amp,amp.config,inp)
  end
  return inp
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

println("first answer :" , calc_best_signal(ops,0) )
