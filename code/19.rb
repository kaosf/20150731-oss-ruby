def f
  puts block_given?
end

f { call_illegal_method } #=> true
f                         #=> false
