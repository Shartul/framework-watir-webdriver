require 'yaml'
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/../lib/auto_test.rb"

class Baidu < AutoTest
    
    def test_index
        puts 'tuangou'
    end
    
    
    def index
        a = 6/0
        p 'index'
    end
    
    def tuangou
        
    end
end