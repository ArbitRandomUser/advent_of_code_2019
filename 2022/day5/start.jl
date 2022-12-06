inp = readlines("input")
#inp = split("    [D]    
#[N] [C]    
#[Z] [M] [P]
# 1   2   3 
#
#move 1 from 2 to 1
#move 3 from 1 to 3
#move 2 from 2 to 1
#move 1 from 1 to 2","\n")
#
#"""
#hardcoded where the stack ends and instructions begin
#"""
stacks = []

function parsestack(data)
    indices = data[end]
    idx = findlast(isdigit , indices)
    #endidx = findprev(isspace, indices , startidx)
    #println(endidx)
    nstacks = parse(Int , indices[idx])
    stacks = [Char[] for _ in 1:nstacks]

    for line in data[end-1:-1:begin]
        stackno=1
        for i in 2:4:length(line)
            if isspace(line[i])
                stackno+=1
                continue
            else
                push!(stacks[stackno],line[i])
                stackno+=1
            end
        end
    end
    stacks
end

idx = findfirst(isempty,inp)
parsestack(inp[1:idx-1])

function parsemove(move)
    amt,from,to = match(r"move (\d+) from (\d+) to (\d+)",move)
    return parse.(Int,[amt,from,to])
end

function runmoves1(moves,stacks)
    for move in moves
        amt,from,to = parsemove(move)
        shift = splice!(stacks[from],(length(stacks[from])-amt+1):length(stacks[from]))
        append!(stacks[to],reverse(shift))
    end
end

function runmoves2(moves,stacks)
    for move in moves
        amt,from,to = parsemove(move)
        shift = splice!(stacks[from],(length(stacks[from])-amt+1):length(stacks[from]))
        append!(stacks[to],shift)
    end
end

function run(inp)
    idx = findfirst(isempty,inp)
    data = inp[1:idx-1] 
    moves = inp[idx+1:end]
    stacks = parsestack(data)
    runmoves(moves,stacks)
    stacks2 = parsestack(data)
    println("part1 ",join(stack[end] for stack in stacks))
    runmoves2(moves,stacks2)
    println("part2 ",join(stack[end] for stack in stacks2))
end
run(inp)

