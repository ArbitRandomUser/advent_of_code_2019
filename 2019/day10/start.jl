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
      push!(coordinates,[i,j])
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
  println("location ", coordinates[besteroid])
  println("first answer " ,visible_asteroids)
end
run_first()
