#$DEBUG=1

class Test
end

$b = ["test_a_1","test_a_2"]
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
      key.new.methods.each do |method| 
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



class A < Test
    
    def test_a_1
    a = 6/0
        puts "a_1"
    end
    
    def test_a_2
        puts "a_2"
    end
    
end