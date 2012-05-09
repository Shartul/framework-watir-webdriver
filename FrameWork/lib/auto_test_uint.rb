#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/require_file.rb"

class AutoTestUnit < Test::Unit::TestCase
    class << self
        def set
        end
        def setup
            @browser = Watir::Browser.new :chrome
        end
        
        def init_enviroment
            $log = Log.new("AutoTestLog")
            $result = Hash.new
            $ui= Operate.new("#{File.dirname(__FILE__)}/../ui_elements/index.yml")
        end
        
        def exists_text?(exp)
            if @browser.text.include?(exp)
                return 'PASS'
            else
                return 'FAIL'
            end
        end
        
        
        
        def teardown
            @browser.close
        end
    end
end