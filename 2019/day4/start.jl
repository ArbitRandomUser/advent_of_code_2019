#cell 1
start = 136818
ending = 685979

function check_adjacent(num::String)
  for (i,c) in enumerate(num[1:end-1])
    if c == num[i+1]
      return true
    end
  end
  return false
end

function check_adjacent2(num::String)
  countlist=[]
  count = 1
  prev_c = num[1]
  for c in num[2:end]
    #println(countlist)
    if c == prev_c
      count=count+1
    else
      push!(countlist,count)
      count=1
    end
    prev_c = c
  end
  push!(countlist,count)
  #println(countlist)
  if 2 in countlist
    return true
  else
    return false
  end
end



function check_increase(num::String)
  for (i,c) in enumerate(num[1:end-1])
    if c> num[i+1]
      return false
    end
  end
  return true
end

#cell2
function run()
   sums = 0
   for i in start:ending
     if check_adjacent(string(i)) && check_increase(string(i))
       sums = sums + 1
     end
   end
   println(sums)
end

function run2()
   sums = 0
   for i in start:ending
     if check_adjacent2(string(i)) && check_increase(string(i))
       sums = sums + 1
     end
   end
   println(sums)
end
##outputs
run()
run2()

##term cell
a = "hhello"
string(22)

for (ind,i) in enumerate(a)
  println(ind,i)
end

for i in 1:10
  print(i)
end

