include("../intcode.jl")
using .IntCode

f = open("input")
lines = readlines(f)
ops = [parse(BigInt,i) for i in split(lines[1],",")]

#ops = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
#ops = [1102,34915192,34915192,7,4,7,99,0]
#ops = [104,1125899906842624,2,99]
prog1 = program(ops)
run_program(prog1)
