lines_string = map(x-> split.(x,","),split.(replace.(readlines("input"),"->"=>"")))
lines = map(x-> [parse.(Int,x[i]) for i in 1:length(x)],lines_string)

po1(l) =  l[1] #just for clarity
po2(l) =  l[2]
xof(p)    =  p[1]
yof(p)    =  p[2]

notdiagonal(line) =
 xof(po1(line)) == xof(po2(line)) || 
 yof(po1(line)) == yof(po2(line))

horizontal(line) = yof(point1(line)) == yof(point2(line))
vertical(line)   = xof(point1(line)) == xof(point2(line))

xspan(line) = xof(point1(line))<xof(point2(line)) ?
 [i for i in xof(point1(line)):xof(point2(line))] :
 [i for i in xof(point2(line)):xof(point1(line))] 
;
yspan(line) = yof(point1(line))<yof(point2(line)) ?
 [i for i in yof(point1(line)):yof(point2(line))] :
 [i for i in yof(point2(line)):yof(point1(line))] 
;

slope(l) = yof(po2(l).-po1(l))//xof(po2(l).-po1(l))
function pointsof(l)
  points = []
  xskip = slope(l).den 
  if xof(po2(l).-po1(l))>0
    #print("here")
    for x in xof(po1(l)): xskip  :xof(po2(l))
      push!(points, Array{Int}([x, yof(po1(l)) + slope(l)*(x-xof(po1(l)) )]))
    end
  elseif xof(po2(l).-po1(l))<0
    for x in xof(po1(l)):-1*xskip:xof(po2(l))
      push!(points,Array{Int}([x , yof(po2(l)) + slope(l)*(x-xof(po2(l)))]))
    end
  elseif xof(po2(l).-po1(l))==0 #inf slope
    if yof(po2(l).-po1(l)) > 0
     for y in yof(po1(l)):yof(po2(l))
       push!(points,[xof(po2(l)) , y])
     end
    else
     for y in yof(po1(l)):-1:yof(po2(l))
       push!(points,[xof(po2(l)) , y])
     end
    end
  end
  return points
end

function intersection(l1,l2)
  collect(intersect(pointsof(l1),pointsof(l2)))
end

h_or_vlines = [line for line in lines if notdiagonal(line)  ]
h_or_v_or_45_lines= [line for line in lines if notdiagonal(line) || slope(line) in [-1,1] ]

let
pointscores = Dict()
for (i,line1) in enumerate(h_or_vlines)
  for line2 in h_or_vlines[i+1:end]
    for point in intersection(line1,line2)
      haskey(pointscores,point) ? pointscores[point]+=1 : pointscores[point]=1
    end
  end
end
println("first answer ", length(pointscores))
pointscores2 = Dict()
for (i,line1) in enumerate(h_or_v_or_45_lines)
  for line2 in h_or_v_or_45_lines[i+1:end]
    for point in intersection(line1,line2)
      haskey(pointscores2,point) ? pointscores2[point]+=1 : pointscores2[point]=1
    end
  end
end
println("first answer ", length(pointscores2))
end
