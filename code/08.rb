def average(a)
  sum = 0.0
  a.each { |i| sum += i }
  sum / a.size
end

a = [1, 2, 3]

if a.empty?
  # 平均値が計算出来ない場合の処理をその都度考えられる
  # 0.0を返すべきなのかnilを返すべきなのか
else
  average a
end
