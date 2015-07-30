def m(x)
  if x > 0
    'pos'
  elsif x < 0
    'neg'
  else
    'zero'
  end
end

p m(1) #=> "pos"
p m(-1) #=> "neg"
p m(0) #=> "zero"
