def f(x: nil, y: nil, z: 3)
  p x + y + z
end

f x: 10, y: 100 #=> 113
f y: 100, x: 10 #=> 113
f z: 1000, y: 100, x: 10 #=> 1110
