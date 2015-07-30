module M1
  class C
    def m
      puts 'method m of C of M1'
    end
  end
end

module M2
  class C
    def m
      puts 'method m of C of M2'
    end
  end
end

M1::C.new.m #=> method m of C of M1
M2::C.new.m #=> method m of C of M2
