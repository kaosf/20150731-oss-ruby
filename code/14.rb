# x は普通の引数
# &のついた最後の引数 block が do ... end に書いた「処理そのもの」
def f(x, &block)
  puts x
  puts block.nil? # blockがあるかどうかだけ確認している
end

f 1 do
  call_illegal_method # どうせ呼ばれないので何をしても良い
end
#=>
# 1
# false

f 2
#=>
# 2
# true
