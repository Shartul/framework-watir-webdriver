require 'yaml'
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/../lib/auto_test.rb"

class Baidu < AutoTest
    
    
    def self.index
        sleep 2
        a = 6/0
        p 'index'
    end
    
    def self.tuangou
        p '222222222'
        sleep 1
    end
end