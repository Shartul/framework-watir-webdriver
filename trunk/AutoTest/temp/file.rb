#$DEBUG=1
class Test
end


at_exit do
    a = Array.new
    isRun = 0
    ObjectSpace.each_object(Class) do |klass|
        if klass.superclass == Test     
            a<<klass          
        end
    end
  $b.each{|m|
    a.each{|key|    
      key.new.methods.grep(/^test/) do |method|      
        if m == method
          isRun = isRun + 1
          begin
          key.new.__send__(method)
          rescue
            puts "error"
          end
        end
      end
    }
  if isRun== 0 
    puts "no #{m} testcase"
  end
  }
end

$b = ["test_a_1","test_a_2","test_b_1","test_b_1"]

class A < Test
    
    def test_a_1
    a = 6/0
        puts "a_1"
    end
    
    def test_a_2
        puts "a_2"
    end
    
end

class B < Test

    def test_b_1
        puts "b_1"
    end
    
    def test_b_2
        puts "b_2"
    end

end