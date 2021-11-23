include("../intcode.jl")
using .IntCode

f=open("input")
lines = readlines(f)
ops = [parse(Int,x) for x in split(lines[1],",")]

prog1 = program(ops)
run_program(prog1,0)
