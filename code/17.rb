def f(&block)
  block.call
  block[]
  yield
end

f do
  puts 'in the block'
end
#=>
# in the block
# in the block
# in the block
