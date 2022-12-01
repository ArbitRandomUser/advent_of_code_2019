calorielist = readlines("input.txt")
parse(Int,"1")
bestsum = 0
sum=0
elfs = []

function readcalorie(str)
    if str==""
        return nothing
    else
        return parse(Int,str)
    end
end

for calorie in calorielist 
    global sum
    if (readcalorie(calorie)!=nothing)
        sum=sum+readcalorie(calorie)
    else
        push!(elfs,sum)
        sum=0
    end
end
m1 = max(elfs...)
m1i = findfirst((x)->x==m1,elfs)
splice!(elfs,m1i)
m2 = max(elfs...)
m2i = findfirst((x)->x==m2,elfs)
splice!(elfs,m2i)
m3 = max(elfs...)
println(m1+m2+m3)
