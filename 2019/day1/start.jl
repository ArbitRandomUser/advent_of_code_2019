f = open("input")
ip = map( x->parse(Int,x) ,readlines(f))

function fuel(mass::Int)
  return div(mass,3)-2
end

function total_fuel(arr::Array)
  sum = 0
  for mod in arr
    sum = sum + fuel(mod)
  end
  return sum
end

function total_recursive_fuel(arr::Array)
  sum = 0
  for mod in arr
    sum = sum + recursive_fuel(mod)
  end
  return sum
end


function recursive_fuel(mass::Int)
  sum = 0
  mass = fuel(mass)
  while(mass > 0)
    sum = sum + mass
    mass = fuel(mass)
  end
  return sum
end

println(total_fuel(ip))
println(total_recursive_fuel(ip))
