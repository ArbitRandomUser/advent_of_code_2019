# cell1 
f = open("input")
lines = readlines(f)

##cell2
function points_from_step( startpoint::Vector , step)
  ret_array = []
  R,L,U,D = [1,0],[-1,0],[0,1],[0,-1]
  dir_table = Dict(['R'=>R,'L'=>L,'U'=>U,'D'=>D])
  dir = dir_table[step[1]]
  mag = parse(Int,step[2:end])
  for i in 1:mag
    push!(ret_array, startpoint+i*dir) 
  end
  return ret_array
end

##cell3 
function points_from_path( startpoint::Vector, path::Array)
  pointpath = [startpoint]
  for step in path
    newstartpoint = pointpath[end]
    append!(pointpath,points_from_step(newstartpoint,step))
  end
  return pointpath
end

#cell4

function dpoint( point::Vector)
  return abs(point[1])+abs(point[2])
end


function dpathpoint(point , pointpath1 , pointpath2)
  sum1 = -1
  for p in pointpath1
    sum1 = sum1 + 1
    if  p == point
      sum2 = -1
      for p2 in pointpath2
	sum2 = sum2+1
	if p2 == point 
	  return sum1+sum2
	end
      end
    end
  end
  return 0
end


function findshort(pointpath1,pointpath2)
  intersection_d = []
  for point in pointpath1
    if point in pointpath2
      push!(intersection_d , dpoint(point))
      #println("found ", point)
    end
  end
  min(intersection_d[2:end]...)
end

function findshortpath(pointpath1,pointpath2)
  intersection_d = []
  for point in pointpath1
    if point in pointpath2
      push!(intersection_d , dpathpoint(point,pointpath1,pointpath2))
      #println("found ", point)
    end
  end
  min(intersection_d[2:end]...)
end

function findshort2(pointpath1,pointpath2)
  dist = 1
  while true
    println("checking ", dist)
    for i in -dist:dist
      point1 = [i, dist - abs(i)]
      point2 = [i, -(dist - abs(i)) ]
      if point1 in pointpath1
	  if (point1 in pointpath2)
	      return dist
	  end
      elseif point2 in pointpath1
	if point2 in pointpath2
          return dist
	end
      end
    end
    dist = dist+1
  end
end



##term cell
path1 = split(lines[1],",")
path2 = split(lines[2],",")
pointpath1 = points_from_path( [0,0] , path1)
pointpath2 = points_from_path( [0,0] , path2)
#@time findshort2(pointpath1,pointpath2)
println("first ",findshort(pointpath1,pointpath2))
println("second ",findshortpath(pointpath1,pointpath2))

#path1 = split("R75,D30,R83,U83,L12,D49,R71,U7,L72",",")
#path2 = split("U62,R66,U55,R34,D71,R55,D58,R83",",")
#pointpath1 = points_from_path([0,0],path1)
#pointpath2 = points_from_path([0,0],path2)

#
#path1= split("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",",")
#path2 = split("U98,R91,D20,R16,D67,R40,U7,R15,U6,R7",",")
#pointpath1 = points_from_path([0,0],path1)
#pointpath2 = points_from_path([0,0],path2)
#findshort(pointpath1,pointpath2)

