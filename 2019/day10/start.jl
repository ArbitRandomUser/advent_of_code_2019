f = open("input")
lines = readlines(f)
"""
lines = ".#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##"
lines = split(lines,"\n")
"""
coordinates = []
for (i,line) in enumerate(lines)
  for (j,c) in enumerate(line)
    if c=='#'
      push!(coordinates,[j,i])
    end
  end
end

function get_integerpoints(p1,p2)
  #p1 and p2 two coordinates
  #returns all integer points between them
  
  #we dont want to involve floats in this calculation
  #lets stick to only integer computations
  #lets use rationals 
  if p1[2] > p2[2]
    p1,p2 = p2,p1
  end

  ret = []
  slope = (p2-p1)[2]//(p2-p1)[1] 
  if slope.num==0
    if p2[1] >= p1[1]
      push!(ret,[ [j,p1[2]] for j in p1[1]:p2[1]]...)
      return ret[2:end-1]
    else
      push!(ret,[ [j,p1[2]] for j in p2[1]:p1[1] ]...)
      return ret[2:end-1]
    end
  end

  for y in p1[2]:p2[2]
    if (y-p1[2])%slope.num == 0
      push!(ret,[ p1[1]+Int((y-p1[2])÷slope) , y ])
    end
  end
  ret[2:end-1]
end

function run_first()
  besteroid = nothing
  visible_asteroids = 0 
  for (i,point1) in enumerate(coordinates)
    vis_point1 = 0
    for point2 in coordinates
      if point1==point2
        continue
      end
      something_in_between = false
      for intpoint in get_integerpoints(point1,point2)
        if (intpoint in coordinates)
	  something_in_between=true
        end
      end
      if something_in_between==false
        vis_point1 = vis_point1+1
      end
    end
    if vis_point1 > visible_asteroids
      besteroid = i
      visible_asteroids = vis_point1
    end
  end
  #println("location ", coordinates[besteroid])
  println("first answer " ,visible_asteroids)
  return coordinates[besteroid]
end
coord = run_first()

function get_all_slopes(p1,coordinates)
  ret = []
  for p2 in coordinates
    if p2==p1
      continue
    end
    push!(ret,[p2,(p2-p1)[1],(p2-p1)[2]])
  end
  ret
end

function ctan(e)
  x = e[2]
  y = e[3]
  if x >=0 && y >=0
    return π-atan(x/y) #atan is smart enough for 1/0
  elseif x>=0 && y<0
    return atan(x/-y)
  elseif x<0 && y >=0
    return  π + atan(-x/y)
  elseif x<0 && y <0
    return 2π - atan(-x/-y) #could be x/y , -x/-y just for symmettry
  end
end

function modsquare(e)
  return e[2]^2 + e[3]^2
end

function compare(e1,e2)
  if ctan(e1)==ctan(e2)
    if modsquare(e1)<modsquare(e2)
      return true 
    else
      return false 
    end
  elseif ctan(e1) < ctan(e2)
    return true 
  else
    return false 
  end
end

function sort2(E)
  COORD=1
  ANGLE=2
  sort!(E,lt=compare)
  finE = []
  push!(finE,[E[1][COORD],ctan(E[1])])
  for (i,e) in enumerate(E[2:end])
    if ctan(e)==ctan(E[i])
      push!(finE,[e[COORD],2π+finE[end][ANGLE]])
    else
      push!(finE,[e[COORD],ctan(e)])
    end
  end
  sort!(finE,by = x->x[ANGLE])
  return finE
end
slopes = get_all_slopes(coord,coordinates) #coord obtained from run_first
sorted = sort2(slopes)
#println(sorted[200])
#
#"we are 1 indexing the map therefore the point is .."
ans2 = sorted[200][1].-1
#println(ans2)
println("second answer $(ans2[1]*100+ans2[2])")

