require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require "#{File.dirname(__FILE__)}/elements.rb"
require "#{File.dirname(__FILE__)}/log.rb"

class Assert
    def initialize(ui)
        @ui = ui
    end
    
    def assert_text_include?(text)
        if eval("$browser.text.include?(#{text})")
            return 'PASS'
        else
            return 'FAIL'
        end
    end
end