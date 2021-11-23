f = open("input")
orbmap = readlines(f)
close(f)

function find_next(s,orbmap)
  for orb in orbmap 
    if s == split(orb,")")[2]
      #println(orb)
      return split(orb,")")[1]
    end
  end
end

function count_till_obj(currentobj,obj,orbmap)
  count = 0
  while(currentobj!=obj)
    currentobj = find_next(currentobj,orbmap)
    #println(currentobj)
    count = count + 1
  end
  return count
end

count_till_com(s,orbmap) = count_till_obj(s,"COM",orbmap) 

function count_all(orbmap)
  totcount=0
  for orb in orbmap
    o1,o2 = split(orb,")")
    totcount = totcount + count_till_com(o2,orbmap)
  end
  return totcount
end

function path_till_obj(currentobj,obj,orbmap)
  path = []
  while(currentobj!=obj)
    currentobj = find_next(currentobj,orbmap)
    push!(path,currentobj)
  end
  return path
end

path_till_com(currentobj,orbmap) = path_till_obj(currentobj,"COM",orbmap)


function find_transfers(path1,path2,orbmap)
    intersection = nothing
    for s in reverse(youpath)
      if s in sanpath
        intersection = s
      end
    end
    #find intesection and count both paths till intersection
    return count_till_obj("YOU",intersection,orbmap) + count_till_obj("SAN",intersection,orbmap) - 2 # -2 because YOU to orbiting planet and orbitting planet to SAN dont count
end

youpath = path_till_com("YOU",orbmap)
sanpath = path_till_com("SAN",orbmap)

#count_till_com("NQY",orbmap)
println("first answer ", count_all(orbmap))
println("second answer ", find_transfers(youpath,sanpath,orbmap))
