a = [1, 2, 3, 4, 5]

s = 0
for i in a do
  if i % 2 != 0
    s += i * 10
  end
end
p s #=> 90
