using Plots 
f = open("input")
lines = readlines(f)
img = lines[1]

layersize = 25*6
layers = [img[k:k+layersize-1] for k in 1:layersize:length(img)]

function firstpart()
min = Inf 
minlayer=1
for (i,layer) in enumerate(layers)
  no_ofzeros = count("0",layer)
  if no_ofzeros < min
    minlayer = i
    min = no_ofzeros
  end
end
answer = count("1",layers[minlayer])*count("2",layers[minlayer])
println("first answer : $(answer)")
end

#canvas = reshape([2 for i in 1:layersize],(6,25))
function secondpart()
  canvas = ['2' for i in 1:layersize]
  for layer in layers
    for (i,c) in enumerate(layer)
      if canvas[i]=='2'
        canvas[i] = c
      else
        nothing
      end
    end
  end
  x = []
  y = []
  for (i,c) in enumerate(canvas)
    if c=='1'
      push!(x,i%25)
      push!(y,i÷25)
    end
  end
  plt = scatter(x,-y,width=50)
  savefig(plt,"secondanswer.png")
  println("open secondanswer.png for second answer")
end
firstpart()
secondpart()
