#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/auto_test.rb"

class Baidu < AutoTest
    
#    def test_index
#        $browser.goto 'http://baidu.com'
#        $locat.find_element('login_link1').click
#        $browser.close
#    end
    def test_a
        $browser.goto 'http://baidu.com'
        $locat.find_element('login_link').click
        $browser.close
    end
    
    #    def test_json
    #        $browser.goto 'http://baidu.com'
    #        $locat.find_element('login_link1').click
    #    end
    
    #    def teardown
    #        $browser.close
    #    end
end