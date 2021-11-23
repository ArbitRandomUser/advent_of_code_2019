f = open("input")
lines = readlines(f)
close(f)

struct obj
  orbits
  orbitedby
end

com = obj(nothing,nothing)

occursin("hell", "hello")

function find_next(s,orbmap)
  for orb in orbmap 
    if s == split(orb,")")[2]
      #println(orb)
      return split(orb,")")[1]
    end
  end
end

function count_till_com(s,orbmap)
  count = 0
  currentobj = s 
  while(currentobj!="COM")
    currentobj = find_next(currentobj,orbmap)
    #println(currentobj)
    count = count + 1
  end
  return count
end

function count_all(orbmap)
  totcount=0
  for orb in orbmap
    o1,o2 = split(orb,")")
    totcount = totcount + count_till_com(o2,orbmap)
  end
  return totcount
end

#count_till_com("NQY",lines)
print("first answer", count_all(lines))
