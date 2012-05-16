require "#{File.dirname(__FILE__)}/../lib/auto_test.rb"

class A < AutoTest
    
#    def get_m
#        c = Conf.new("#{File.dirname(__FILE__)}/../conf/method_conf.yml")
#        return c.get_methods
#    end
    
    def self.a_1
        a = 6/0
        puts "a_1"
    end
    
    def self.a_2
        puts "a_2"
    end
    
end
