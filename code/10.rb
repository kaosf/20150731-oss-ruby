module M
  def m
    puts 'M m'
  end
end

class C
  extend M
end

C.m #=> 'M m'
