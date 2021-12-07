posarr = parse.(Int,split(read("input",String),","))
minimum(posarr)
exarr = [16,1,2,0,4,2,7,1,2,14] 
fuel(pos,posarr) =  sum(abs.(pos .- posarr))
fuel2(pos,posarr) =  sum(cumulate.(abs.(pos .- posarr)))
cumulate(n) = n*(n+1)÷2
fuel(m) = fuel(m,posarr) 
dfuel(m,n) = fuel(m) - fuel(n) 
fuel2(m) = fuel2(m,posarr) 
dfuel2(m,n) = fuel2(m) - fuel2(n) 
function binary_run()
  ends = [minimum(posarr),maximum(posarr)]
  mid= sum(ends)÷2
  fuel_eval_n = 0
  while( !(fuel(mid-1) > fuel(mid) && fuel(mid) < fuel(mid+1) ))
    mid= sum(ends)÷2
    fuel_eval_n += 3
    if dfuel(mid,mid-1) <= 0
      ends[1] = mid
    elseif dfuel(mid,mid-1) >0
      ends[2] = mid
    end
  end
  return mid,fuel(mid),fuel_eval_n
end

function binary_run2()
  ends = [minimum(posarr),maximum(posarr)]
  mid= sum(ends)÷2
  fuel2_eval_n = 0
  while( !(fuel2(mid-1) > fuel2(mid) && fuel2(mid) < fuel2(mid+1) ))
    mid= sum(ends)÷2
    fuel2_eval_n += 3
    if dfuel2(mid,mid-1) <= 0
      ends[1] = mid
    elseif dfuel2(mid,mid-1) >0
      ends[2] = mid
    end
  end
  return mid,fuel2(mid),fuel2_eval_n
end
function run(posarr)
  retpos=minimum(posarr)
  retpos2=minimum(posarr)
  prevfuel=fuel(minimum(posarr),posarr)
  prevfuel2= fuel2(minimum(posarr),posarr)
  for xpos in minimum(posarr):maximum(posarr)
    if fuel(xpos,posarr)<prevfuel
      prevfuel = fuel(xpos,posarr)
      retpos=xpos
    end
    if fuel2(xpos,posarr)<prevfuel2
      prevfuel2= fuel2(xpos,posarr)
      retpos2=xpos
    end
  end
  prevfuel,prevfuel2,retpos,retpos2
end

fuels = []
for pos in minimum(posarr):0.1:maximum(posarr)
  push!(fuels,fuel(pos,posarr))
end

@show binary_run()
@show binary_run2()

@show run(posarr)
