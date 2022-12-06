inp = readlines("input")
starting(region) = parse(Int,split(region,"-")[1])
ending(region) = parse(Int,split(region,"-")[2])
testinp = split("2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8","\n")

function part1(inp)
count=0
for i in inp
    count
    elf1,elf2 = split(i,",")
    if (starting(elf1)<=starting(elf2))&&(ending(elf1)>=ending(elf2))
        count+=1
    end
    if (starting(elf1)>=starting(elf2))&&(ending(elf1)<=ending(elf2))
        count+=1
    end
    if (starting(elf1)==starting(elf2))&&(ending(elf1)==ending(elf2))
        count-=1
    end
end
println("part1 ",count)
end

function part2(inp)
    count=0
    for i in inp
        elf1,elf2=split(i,",")
    if ((starting(elf1)<=starting(elf2)<=ending(elf1))) || (starting(elf2)<=starting(elf1)<=ending(elf2))
            count+=1
        end
    end
    println("part2 ",count)
end

#part1(testinp)
part1(inp)
part2(testinp)
part2(inp)
