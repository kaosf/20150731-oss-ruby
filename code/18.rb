def f
  puts 'f'
end

f do
  puts 'in the block'
end
#=> f
