f = open("input")
lines = readlines(f)
ilines = [parse(Int,x) for x in lines]

println("first answer : ", sum((ilines[2:end] .- ilines[1:end-1]).>0))
#moving sum of every 3 elements
movsums = [sum(ilines[i:i+2]) for i in 1:(length(ilines)-2)]
println("second answer : ", sum((movsums[2:end] .- movsums[1:end-1]).>0))
