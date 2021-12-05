inp = readlines("input")

counter = zeros(Int,12)
for bin in inp
  for (i,c) in enumerate(bin)
    if c=='0'
      counter[i] -= 1
    elseif c=='1'
      counter[i] +=1
    else
      println("error ", typeof(c) ," ", c)
      @assert 1==2
    end
  end
end
gamma = parse(Int,"0b"*prod(string.((sign.(counter).+1).÷2)))
epsilon = parse(Int,"0b"*bitstring(~gamma)[end-11:end])

bit_vecofvec = [[parse(Int,c) for c in bin] for bin in inp]
bitmat = BitArray(transpose(hcat(bitvecofvec...)))

let
searchlist = Set(1:length(inp))
for i in 1:length(inp[1]) 
  onepos = Set([])
  zeropos = Set([])
  for j in searchlist
    if inp[j][i]=='1'
      push!(onepos,j)
    elseif inp[j][i]=='0'
      push!(zeropos,j)
    end
  end
  if length(onepos) >= length(zeropos)
    searchlist = onepos
  else
    searchlist = zeropos
  end
  if length(searchlist)==1
    break
  end
end
o2rating = parse(Int,"0b"*inp[iterate(searchlist)[1]])
searchlist = Set(1:length(inp))
for i in 1:length(inp[1]) 
  onepos = Set([])
  zeropos = Set([])
  for j in searchlist
    if inp[j][i]=='1'
      push!(onepos,j)
    elseif inp[j][i]=='0'
      push!(zeropos,j)
    end
  end
  if length(onepos) < length(zeropos)
    searchlist = onepos
  else
    searchlist = zeropos
  end
  if length(searchlist)==1
    break
  end
end
co2rating = parse(Int,"0b"*inp[iterate(searchlist)[1]])
println(o2rating*co2rating)
end
