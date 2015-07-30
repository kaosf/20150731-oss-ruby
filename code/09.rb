module M
  def m
    puts 'M m'
  end
end

class C
  include M
end

C.new.m #=> 'M m'
