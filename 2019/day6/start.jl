f = open("input")
orbmap = readlines(f)
close(f)

function find_next(s::AbstractString,orbmap::Vector{String})
  for orb in orbmap 
    if s == split(orb,")")[2]
      #println(orb)
      return split(orb,")")[1]
    end
  end
end

function count_till_obj(currentobj::AbstractString,obj::AbstractString,orbmap::Vector{String})
  count = 0
  while(currentobj!=obj)
    currentobj = find_next(currentobj,orbmap)
    #println(currentobj)
    count = count + 1
  end
  return count
end

count_till_com(s,orbmap) = count_till_obj(s,"COM",orbmap) 

function count_all(orbmap::Vector{String})
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


function find_transfers(obj1,obj2,orbmap)
    obj1path = path_till_com(obj1,orbmap)
    obj2path = path_till_com(obj2,orbmap)
    intersection = nothing
    for s in reverse(obj1path)
      if s in obj2path 
        intersection = s
      end
    end
    #find intesection and count both paths till intersection
    return count_till_obj("YOU",intersection,orbmap) + count_till_obj("SAN",intersection,orbmap) - 2 # -2 because YOU to orbiting planet and orbitting planet to SAN dont count
end


#first answer might take a while, took about 130 seconds on my Radeon 5500u
#lot of allocations happen , see if we can reduce that ?
@time println("first answer ", count_all(orbmap))
println("second answer ", find_transfers("YOU","SAN",orbmap))
