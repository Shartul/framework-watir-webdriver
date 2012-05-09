#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/operate.rb"
require "#{File.dirname(__FILE__)}/../lib/read_yaml.rb"
require "#{File.dirname(__FILE__)}/../lib/log.rb"


class Baidu < Test::Unit::TestCase
    
    def setup
        $log = Log.new('index')
        @browser = Watir::Browser.new :chrome
        @element= Operate.new(@browser,"#{File.dirname(__FILE__)}/../ui_elements/index.yml")
        
    end
    
    def test_index
        $log.add_log()
        @browser.goto "http://baidu.com"
        @element.input_msg("baidu_index_text_field",'测试')
        #@browser.close
    end
end