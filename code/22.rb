def f
  yield if block_given?
end

f # 何も起こらない(yieldしないのでエラーも起こらない)

f { puts 'in the block' } #=> in the block
