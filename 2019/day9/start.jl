include("../intcode.jl")
using .IntCode

f = open("input")
lines = readlines(f)
ops = lines[1]
ops = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]

prog1 = program(ops)
run_program(prog1)

