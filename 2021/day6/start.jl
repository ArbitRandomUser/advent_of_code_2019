lines = parse.(Int,split(strip(read("input",String)),","))
#naive way ...
#function step_fish(fishs)
#  for (i,f) in enumerate(fishs[1:end])
#    if f==0
#      push!(fishs,8)
#      fishs[i]=6
#    else
#      fishs[i] -= 1
#    end
#  end
#  println(fishs)
#end

#for i in 1:256
#  step_fish(lines)
#end
#the above sol runs out of mem for 256 for second part

#the right way ...
count=zeros(Int,10) #1-9 for 0-8 , 10 for newfish
for n  in  lines 
  count[n+1]+=1
end
function step_fish!(count)
  count[10] = count[1]
  #count[0+1:7+1] .= view(count,1+1:8+1)
  for i in 1:8
    count[i] = count[i+1]
  end
  count[6+1] = count[6+1] + count[10] 
  count[8+1] = count[10] 
  nothing
end
function run(n,count)
 for _ in 1:n
   step_fish!(count)
 end
 return sum(count[begin:end-1])
end
println("first answer :", run(80,count))
println("second answer ",run(256-80,count))

