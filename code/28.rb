p [1, 2, 3].reduce(0) { |a, e| a + e } #=> 6

p ['a', 'b', 'c'].inject('') { |a, e| e + a } #=> "cba"
