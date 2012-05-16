at_exit do
    a = Array.new
    isRun = 0
    ObjectSpace.each_object(Class) do |klass|
        if klass.superclass == AutoTest    
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