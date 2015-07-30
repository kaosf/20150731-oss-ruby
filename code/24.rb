class C
  def method_missing(name, *args)
    puts "#{name} called"
    puts args
  end
end

C.new.m 1, 2
#=>
# m called
# 1
# 2

C.new.fooooo #=> fooooo called
