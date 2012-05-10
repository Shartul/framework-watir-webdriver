require 'yaml'
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/read_yaml.rb"

class Baidu < Test::Unit::TestCase
    
    def self.startup
        p 11111111
        $ui = ReadYaml.new("#{File.dirname(__FILE__)}/../elements/index.yml")
    end
    
    def test_index
        
        p $ui.get_porperty('login_link')
    end

end