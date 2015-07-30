def f(&block)
  puts 'before call'
  block.call
  puts 'after call'
end

f do
  puts 'in the block'
end
#=>
# before call
# in the block
# after call
