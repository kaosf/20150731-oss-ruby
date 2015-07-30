def f
  puts 'f'
  yield
end

f do
  puts 'in the block'
end
#=>
#  f
#  in the block
