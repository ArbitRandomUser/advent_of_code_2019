game = readlines("input")
scoredict = Dict(['X'=>1,'Y'=>2,'Z'=>3,'A'=>1,'B'=>2,'C'=>3])
xamap = Dict(['X'=>'A','Y'=>'B','Z'=>'C'])
score = 0

winsdict = Dict(['X'=>'C','Y'=>'A','Z'=>'B'])

function runmatch(c1,c2)
    if xamap[c1]==c2
        return :draw
    end
    if winsdict[c1]==c2
        return :win
    end
end
for line in game
    global score
    score = score+scoredict[line[end]] 
    if (runmatch(line[end],line[begin]) == :draw)
        score=score+3
    elseif runmatch(line[end],line[begin]) == :win
        score=score+6
    end
end
println("part1 ",score)
#p2
score = 0
scoredict = Dict(['A'=>1,'B'=>2,'C'=>3])
winsdict = Dict(['A'=>'C','B'=>'A','C'=>'B'])
losedict = Dict(['A'=>'B','B'=>'C','C'=>'A'])
function matchscore2(c1,c2)
    if c1=='X'
        return scoredict[winsdict[c2]]+0
    elseif c1=='Y'
        return scoredict[c2] + 3
    elseif c1=='Z'
        return scoredict[losedict[c2]]+6
    end
end

for line in game
    global score
    score = score+matchscore2(line[end],line[begin])
end
println("part2 ",score)



