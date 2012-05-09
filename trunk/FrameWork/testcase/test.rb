#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'

class TuanIndex < Test::Unit::TestCase
    def setup
        @browser = Watir::Browser.new :chrome
        puts self.class
    end
    
    def test_login
        @browser.goto 'http://tuan.qq.com'
        @browser.link(:class=>'mod_userinfo_login').click
        @browser.frame(:src=>/ptlogin2/).text_field(:id=>'u').set('383145138')
        @browser.close
    end
end