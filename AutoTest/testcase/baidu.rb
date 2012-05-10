require 'yaml'
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/../lib/auto_test.rb"

class Baidu < AutoTest
    
    def test_index
        arr = %W[index tuangou]
        begin
            for a in arr
                self.__send__(a)
            end
        rescue
            p $!
        end
    end
    
    
    def index
        a = 6/0
        p 'index'
    end
    
    def tuangou
        puts 'tuangou'
    end
end