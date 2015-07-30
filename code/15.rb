def f(x, &block)
  puts block.class # blockのクラスはProcである
end

f 1 do
  call_illegal_method
end
#=> Proc
