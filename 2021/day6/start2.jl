lines = parse.(Int,split(strip(read("input",String)),","))
function countinit(lines,counts)
for n  in  lines 
  counts[n+1]+=1
end
end
function step!(n,counts)
  for i in 1:n
    #println(counts[i:i+8])
    counts[i+(1+6)] += counts[i]
    counts[i+(1+8)] = counts[i]
  end
end
function run(n,lines)
  counts=zeros(Int,n+9) #1-9 for 0-8 , 10 for newfish
  countinit(lines,counts)
  step!(n,counts)
  sum(counts[n+1:end])
end
#step!(80,counts)
#println(sum(counts[81:end]))
#println(sum(counts[257:end]))
