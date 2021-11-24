include("../intcode.jl")
using .IntCode
using IterTools

f = open("input")
lines = readlines(f)
ops = [parse(Int,x) for x in split(lines[1],",")]
amps = [program(copy(ops)) for i in 1:5]

function amplify(amps,inp=0,)

