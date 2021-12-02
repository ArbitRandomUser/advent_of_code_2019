f = open("input")
lines = readlines(f)
ilines = [parse(Int,x) for x in lines]

println("first answer : ", sum((ilines[2:end] .- ilines[1:end-1]).>0))
#moving sum of every 3 elements
movsums = [sum(ilines[i:i+2]) for i in 1:(length(ilines)-2)]
println("second answer : ", sum((movsums[2:end] .- movsums[1:end-1]).>0))

#alternatively we can just compare every 4th element
#since
#sum([a,b,c]) < sum([b,c,d]) is true if a<d when a and d are positive
println("second answer :", count(3:length(ilines)-1) do idx
	  ilines[idx-2]<ilines[idx+1]
	end)

