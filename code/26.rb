a = [1, 2, 3, 4, 5]

p a.select { |e| e % 2 != 0 }.map { |e| e * 10 }.reduce(0) { |a, e| a + e }

# odd? というメソッドと symbol to_proc と reduce の特性が理解出来ていれば以下でも
p a.select(&:odd?).map { |e| e * 10 }.reduce(&:+)
