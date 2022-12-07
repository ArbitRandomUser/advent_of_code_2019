inp = readlines("input")
#testinp = split(raw"$ cd /
#$ ls
#dir a
#14848514 b.txt
#8504156 c.dat
#dir d
#$ cd a
#$ ls
#dir e
#29116 f
#2557 g
#62596 h.lst
#$ cd e
#$ ls
#584 i
#$ cd ..
#$ cd ..
#$ cd d
#$ ls
#4060174 j
#8033020 d.log
#5626152 d.ext
#7214296 k","\n")

dirs = Dict{String,Int}([])

curdir = ""

function parse(line)
    global curdir
    println(curdir)
    words = split(line)
    if line[1] == '$' #command
        if words[2]=="cd"
            if words[3] == "/"
                curdir = "/"
            elseif words[3] ==".."
                dirpath = split(curdir,"/")  
                curdir =  join(dirpath[1:end-1],"/")
            else
                curdir=curdir*"/"*words[3]
            end
        end
    else
        number = tryparse(Int,words[1])
        if number!=nothing 
            dirpath = split(curdir,"/")
            for (i,dir) in enumerate(dirpath)
                dirname = join(dirpath[1:i],"/")
                dirname in keys(dirs) ? dirs[dirname]+=number : dirs[dirname]=number
            end
        end
    end
end

for line in inp
    global curdir
    parse(line)
end

summ=0
for dir in keys(dirs)
    global summ
    if dirs[dir] <=100000
        summ=summ+dirs[dir]
    end
end
println("part1 ",summ)

curbest=Inf
for dir in keys(dirs)
    global curbest
    if 21618835+dirs[dir]>30000000
        if dirs[dir]<curbest
            curbest=dirs[dir]
        end
    end
end
println("part2 ",curbest)
