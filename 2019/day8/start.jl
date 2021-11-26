f = open("input")
lines = readlines(f)
img = lines[1]

layersize = 25*6
layers = [img[k:k+layersize-1] for k in 1:layersize:length(img)]

min = Inf 
minlayer=1
for (i,layer) in enumerate(layers)
  no_ofzeros = count("0",layer)
  if no_ofzeros < min
    minlayer = i
    min = no_ofzeros
  end
end
#answer = count("1",layers[minlayer])*count("2",layers[minlayer])
println("first answer : $(answer)")
