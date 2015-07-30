def average(a)
  return nil if a.empty?

  sum = 0.0
  a.each { |i| sum += i }
  sum / a.size
end

p average([1, 2, 3]) #=> 2.0
p average([]) #=> nil
