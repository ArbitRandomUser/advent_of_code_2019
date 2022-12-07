inp = readlines("input")
inp = inp[1]

for i in 4:length(inp)
    c = inp[i]
    continueflag = false 
    for (j,c) in enumerate(inp[i-3:i])
        if (c in inp[i-3:i][j+1:end])
            continueflag = true
            break
        end
    end
    if continueflag 
        continue
    else
        println("part1 $i")
        break
    end
end

for i in 14:length(inp)
    c = inp[i]
    continueflag = false 
    for (j,c) in enumerate(inp[i-13:i])
        if (c in inp[i-13:i][j+1:end])
            continueflag = true
            break
        end
    end
    if continueflag 
        continue
    else
        println("part2 $i")
        break
    end
end

