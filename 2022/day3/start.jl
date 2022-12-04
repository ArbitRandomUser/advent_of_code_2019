inp = readlines("input")
#inp = split("vJrwpWtwJgWrhcsFMMfFFhFp
#jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
#PmmdzqPrVvPwwTWBwg
#wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
#ttgJtRGJQctTZtZT
#CrZsJsPPZsGzwwsLwLmpwMDw")

function priority(c::Char)
    if 65<=Int(c)<=90
        return 26+Int(c)-65+1
    else
        return Int(c)-97+1
    end
end

cumprior = 0
for line in inp
    global cumprior
    fc = line[begin:end÷2]
    sc = line[end÷2+1:end]
    for e in fc
        if e in sc
            cumprior = cumprior+priority(e)
            break
        end
    end
end

cumprior2 = 0
for i in 1:3:length(inp)
    global cumprior2
    line = inp[i]
    for e in line
        if (e in inp[i+1]) && (e in inp[i+2] )
            cumprior2 = cumprior2+priority(e)
            break
        end
    end
end

println("part1 ",cumprior)
println("part2 ",cumprior2)
