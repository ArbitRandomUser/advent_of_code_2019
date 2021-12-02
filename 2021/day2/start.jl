lines = readlines("input")

instructions = [ split(line," ") for line in lines]
instructions = [ [inst[1],parse(Int,inst[2])] for inst in instructions]

function findpos(instructions,initpos=[0,0])
  for inst in instructions
    if inst[1]=="forward"
      initpos .+=  [inst[2],0]
    elseif inst[1]=="down"
      initpos .+= [0,inst[2]]
    elseif inst[1]=="up"
      initpos .+= [0,-inst[2]]
    end
  end
  return initpos
end

pos = findpos(instructions)
println("first answer ", pos[1]*pos[2]);

function findposaim(instructions,initpos=[0,0],aim=0)
  for inst in instructions
    if inst[1]=="forward"
      initpos .+=  [inst[2],0]
      initpos .+=  [0,aim*inst[2]]
    elseif inst[1]=="down"
      aim += inst[2]
      #initpos .+= [0,inst[2]]
    elseif inst[1]=="up"
      aim -= inst[2]
      #initpos .+= [0,-inst[2]]
    end
  end
  return initpos
end
