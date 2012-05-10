require 'yaml'
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/../lib/auto_test.rb"

class Baidu < AutoTest
    
    def test_index
        $browser.goto 'http://baidu.com'
        $locat.find_element('login_link').click
        $browser.close
    end

end