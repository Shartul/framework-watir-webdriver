#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require 'pathname'

class TuanIndex < Test::Unit::TestCase
    
    def test_login
        puts self.class
        #puts __LINE__, __FILE__.realpath, __callee__
        puts __FILE__ + ' at line:' + __LINE__.to_s
    end
end